function varargout = Code_1640608(varargin)
% ALL MATLAB code for Code_1640608.fig
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help all
% Last Modified by GUIDE v2.5 09-Dec-2018 18:28:30
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @all_OpeningFcn, ...
                   'gui_OutputFcn',  @all_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
% --- Executes just before all is made visible.
function all_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to all (see VARARGIN)

% Choose default command line output for all
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes all wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% --- Outputs from this function are returned to the command line.
function varargout = all_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
axis ([-100 100 -100 100]);
grid on;
global AoR;
AoR = 0;

% --- Executes on button press in IncreaseAoR.
function IncreaseAoR_Callback(hObject, eventdata, handles)
% hObject    handle to IncreaseAoR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%axes(handles.axes1); % Make averSpec the current axes.
cla; % Do a complete and total reset of the axes
global RoBc;
global RoSc;
global X_Centre;
global Y_Centre;
global j;
global k;
global h;
global AoR;
AoR = AoR + 1;
DOR = sprintf('Degree of rotation: %d', AoR);
set(handles.DOR, 'String',DOR);
draw_rectangle(X_Centre, Y_Centre, AoR);
draw_first_circle(X_Centre, Y_Centre, AoR, RoBc ,k , j)
draw_second_circle(X_Centre, Y_Centre, AoR, RoBc ,k , j)
draw_third_circle(X_Centre, Y_Centre, AoR, RoSc ,h , j)
draw_fourth_circle(X_Centre, Y_Centre, AoR, RoSc ,h , j)

% --- Executes on button press in DecreaseAoR.
function DecreaseAoR_Callback(hObject, eventdata, handles)
% hObject    handle to DecreaseAoR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%axes(handles.axes1); % Make averSpec the current axes.
%cla reset; % Do a complete and total reset of the axes
cla; % Do a complete and total reset of the axes
global RoBc;
global RoSc;
global X_Centre;
global Y_Centre;
global j;
global k;
global h;
global AoR;
AoR = AoR - 1;
DOR = sprintf('Degree of rotation: %d', AoR);
set(handles.DOR, 'String',DOR);
draw_rectangle(X_Centre, Y_Centre, AoR);
draw_first_circle(X_Centre, Y_Centre, AoR, RoBc ,k , j)
draw_second_circle(X_Centre, Y_Centre, AoR, RoBc ,k , j)
draw_third_circle(X_Centre, Y_Centre, AoR, RoSc ,h , j)
draw_fourth_circle(X_Centre, Y_Centre, AoR, RoSc ,h , j)
function draw_rectangle(X_Centre, Y_Centre, AoR)
a = X_Centre;  
b = Y_Centre;
%centre of the rectangle
X_rectangle = [X_Centre-a, X_Centre-a, X_Centre+a,X_Centre+a,X_Centre-a];
Y_rectangle = [Y_Centre-b,Y_Centre+b,Y_Centre+b,Y_Centre-b,Y_Centre-b];
hold on
%make the origin the centre of the rectangle
XO = X_rectangle - X_Centre;
YO = Y_rectangle - Y_Centre;
%rotates the rectangle
global X_initial;
global Y_initial;
global X_final;
global Y_final;
global RoBc;
global RoSc;
global bkj;
global j;
global k;
global h;
global X_rotation;
global Y_rotation;
global Q;
k = ((a-b)*(a + 3*b + sqrt(a^2 + 6*a*b + b^2)))/(4*b);
h = (a-b)* (a+b+sqrt(a^2+6*a*b+b^2))/(a-b+sqrt(a^2+6*a*b+b^2));
RoBc = b+k; % radius of big circle
RoSc = a-h; % radius of small circle
bkj = atand(h/k); %finding the angle of rotation 
j = 90-bkj; 
X_rotation = cosd(AoR)*XO-sind(AoR)*YO;
Y_rotation = sind(AoR)*XO+cosd(AoR)*YO;
%returns the rectangle to its original position
if  X_initial < X_final  && Y_initial > Y_final %if the rectangle was drawn from the top left to the bottom right
    X_rotation = X_rotation+X_Centre+X_initial;
    Y_rotation = Y_rotation+Y_Centre+Y_final;
    %TL->BR
end
if  X_initial < X_final && Y_initial < Y_final %if the rectangle was drawn from the bottom left to the top right
    X_rotation = X_rotation+X_Centre+X_initial;
    Y_rotation = Y_rotation+Y_Centre+Y_initial;
    %BL->TR
end
if  X_initial > X_final && Y_initial > Y_final % if the rectangle was drawn from the top right to the bottom left
    X_rotation = X_rotation+X_Centre+X_final;
    Y_rotation = Y_rotation+Y_Centre+Y_final;
    %TR->BL
end
if  X_initial > X_final && Y_initial < Y_final % if the rectangle was drawn from the bottom right to the top left
    X_rotation = X_rotation+X_Centre+X_final;
    Y_rotation = Y_rotation+Y_Centre+Y_initial;
    %BR->TL
end
if Q == 1
    plot (X_rotation, Y_rotation)%plots the rectangle
else
    plot(X_rotation,Y_rotation,'visible','off')
end

function draw_first_circle(X_Centre, Y_Centre, AoR, RoBc ,k , j)
global X_initial;
global Y_initial;
global X_final;
global Y_final;
global O;
class(O);
if O == 1
    angle1 = (j+AoR):1/1000:(540-j+AoR);
elseif O == 0
    angle1 = (j+AoR):1/1000:(180-j+AoR);
end
x1_circ = X_Centre + k*sind(AoR);
y1_circ = Y_Centre - k + (k - k*cosd(AoR));
if  X_initial < X_final  && Y_initial > Y_final %if the rectangle was drawn from the top left to the bottom right
    x1 = (RoBc*cosd(angle1)+ x1_circ)+X_initial;
    y1 = (RoBc*sind(angle1)+ y1_circ)+Y_final;
elseif  X_initial < X_final && Y_initial < Y_final%if the rectangle was drawn from the bottom left to the top right
    x1 = (RoBc*cosd(angle1)+ x1_circ)+X_initial;
    y1 = (RoBc*sind(angle1)+ y1_circ)+Y_initial;
elseif  X_initial > X_final && Y_initial > Y_final % if the rectangle was drawn from the top right to the bottom left
    x1 = (RoBc*cosd(angle1)+ x1_circ)+X_final;
    y1 = (RoBc*sind(angle1)+ y1_circ)+Y_final;
elseif  X_initial > X_final && Y_initial < Y_final % if the rectangle was drawn from the bottom right to the top left
    x1 = (RoBc*cosd(angle1)+ x1_circ)+X_final;
    y1 = (RoBc*sind(angle1)+ y1_circ)+Y_initial;
else
    msgbox('The width or length of the rectangle you wanted to draw is equal to zero','WARNING');
end
plot (x1, y1) 
axis equal;
function draw_second_circle(X_Centre, Y_Centre, AoR, RoBc ,k , j)
global X_initial;
global Y_initial;
global X_final;
global Y_final;
global O;
class(O);
if O == 1
    angle2 = (AoR+180+j):1/1000:(720-j+AoR);
elseif O == 0
    angle2 = (AoR+180+j):1/1000:(360-j+AoR);
end
x2_circ = X_Centre - k*sind(AoR);
y2_circ = Y_Centre + k - (k - k*cosd(AoR));
if  X_initial < X_final  && Y_initial > Y_final %if the rectangle was drawn from the top left to the bottom right
    x2 = (RoBc*cosd(angle2) + x2_circ)+X_initial;
    y2 = (RoBc*sind(angle2) + y2_circ)+Y_final;
elseif  X_initial < X_final && Y_initial < Y_final%if the rectangle was drawn from the bottom left to the top right
    x2 = (RoBc*cosd(angle2) + x2_circ)+X_initial;
    y2 = (RoBc*sind(angle2) + y2_circ)+Y_initial;
elseif  X_initial > X_final && Y_initial > Y_final % if the rectangle was drawn from the top right to the bottom left
    x2 = (RoBc*cosd(angle2) + x2_circ)+X_final;
    y2 = (RoBc*sind(angle2) + y2_circ)+Y_final;
elseif  X_initial > X_final && Y_initial < Y_final % if the rectangle was drawn from the bottom right to the top left
    x2 = (RoBc*cosd(angle2) + x2_circ)+X_final;
    y2 = (RoBc*sind(angle2) + y2_circ)+Y_initial;
else
    msgbox('The width or length of the rectangle you wanted to draw is equal to zero','WARNING');
end
plot (x2, y2) 
axis equal;
function draw_third_circle(X_Centre, Y_Centre, AoR, RoSc ,h , j)
global X_initial;
global Y_initial;
global X_final;
global Y_final;
global O;
class(O);
if O == 1
    angle3 = (AoR+180-j):1/1000:(AoR+540+j);
elseif O == 0
    angle3 = (AoR+180-j):1/1000:(AoR+180+j);
end

x3_circ = X_Centre - h + (h - h*cosd(AoR));
y3_circ = Y_Centre - h*sind(AoR);
if  X_initial < X_final  && Y_initial > Y_final %if the rectangle was drawn from the top left to the bottom right
    x3 = (RoSc*cosd(angle3) + x3_circ)+X_initial;
    y3 = (RoSc*sind(angle3) + y3_circ)+Y_final;
elseif  X_initial < X_final && Y_initial < Y_final%if the rectangle was drawn from the bottom left to the top right
    x3 = (RoSc*cosd(angle3) + x3_circ)+X_initial;
    y3 = (RoSc*sind(angle3) + y3_circ)+Y_initial;
elseif  X_initial > X_final && Y_initial > Y_final % if the rectangle was drawn from the top right to the bottom left
    x3 = (RoSc*cosd(angle3) + x3_circ)+X_final;
    y3 = (RoSc*sind(angle3) + y3_circ)+Y_final;
elseif  X_initial > X_final && Y_initial < Y_final % if the rectangle was drawn from the bottom right to the top left
    x3 = (RoSc*cosd(angle3) + x3_circ)+X_final;
    y3 = (RoSc*sind(angle3) + y3_circ)+Y_initial;
else
    msgbox('The width or length of the rectangle you wanted to draw is equal to zero','WARNING');
end
plot (x3, y3) 
axis equal;
function draw_fourth_circle(X_Centre, Y_Centre, AoR, RoSc ,h , j)
global X_initial;
global Y_initial;
global X_final;
global Y_final;
global O;
class(O);
if O == 1
    angle4 = (AoR-j):1/1000:(j+AoR+360);
elseif O == 0
    angle4 = (AoR-j):1/1000:(j+AoR);
end
x4_circ = X_Centre + h - (h - h*cosd(AoR));
y4_circ = Y_Centre + h*sind(AoR);
if  X_initial < X_final  && Y_initial > Y_final %if the rectangle was drawn from the top left to the bottom right
    x4 = (RoSc*cosd(angle4) + x4_circ)+X_initial;
    y4 = (RoSc*sind(angle4) + y4_circ)+Y_final;
elseif  X_initial < X_final && Y_initial < Y_final%if the rectangle was drawn from the bottom left to the top right
    x4 = (RoSc*cosd(angle4) + x4_circ)+X_initial;
    y4 = (RoSc*sind(angle4) + y4_circ)+Y_initial;
elseif  X_initial > X_final && Y_initial > Y_final % if the rectangle was drawn from the top right to the bottom left
    x4 = (RoSc*cosd(angle4) + x4_circ)+X_final;
    y4 = (RoSc*sind(angle4) + y4_circ)+Y_final;
elseif  X_initial > X_final && Y_initial < Y_final % if the rectangle was drawn from the bottom right to the top left
    x4 = (RoSc*cosd(angle4) + x4_circ)+X_final;
    y4 = (RoSc*sind(angle4) + y4_circ)+Y_initial;
else
    msgbox('The width or length of the rectangle you wanted to draw is equal to zero','WARNING');
end
plot (x4, y4) 
axis equal;
% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global AoR;
global X_initial;
global Y_initial;
global X_final;
global Y_final;
global X_Centre;
global Y_Centre;
global RoBc;
global RoSc;
global h;
global k;
global j;
AoR = 0;
[x,y] = ginput(2); %get the x and y coords of the users inputs and allows the user to choose two coords
va = [x,y]; % Assigns the matrix to a variable

X_initial = va(1); %Assigns the first value in the matrix to the variable X_initial( X-Coord for the first click)
Y_initial = va(3); %Assigns the third value in the matrix to the variable Y_initial(Y-Coord for the first click)
X_final = va(2);%Assigns the second value in the matrix to the variable X_final(X-Coord for the second click)
Y_final = va(4);%Assigns the second value in the matrix to the variable Y_final(Y-Coord for the second click)

w = abs(va(1)-va(2)); % width of the rectangle( by subtracting x-crood of the first click and the x-coord of the second click and taking is absolute value) 
height = abs(va(3)-va(4)); %height of the rectangle( by subtracting y-crood of the first click and the y-coord of the second click and taking is absolute value)

X_Centre =w/2; % divides the width of the rectangle to find the x value of the centre
Y_Centre =height/2; % divides the height of the rectangle to find the y value of the centre

X_Sstring = sprintf('x start point: %f', va(1));
set(handles.label_X_initial, 'String',X_Sstring); %displays the value of X_initial on the graph by using labels
Y_Sstring = sprintf('y start point: %f', va(3));
set(handles.label_Y_initial, 'String',Y_Sstring); %displays the value of Y_initial on the graph by using labels
X_Fstring = sprintf('x finish point: %f', va(2));
set(handles.label_X_final, 'String',X_Fstring); %displays the value of X_final on the graph by using labels
Y_Fstring = sprintf('y finish point: %f', va(4));
set(handles.label_Y_final, 'String',Y_Fstring); %displays the value of Y_final on the graph by using labels

draw_rectangle(X_Centre, Y_Centre, AoR);
draw_first_circle(X_Centre, Y_Centre, AoR, RoBc ,k , j)
draw_second_circle(X_Centre, Y_Centre, AoR, RoBc ,k , j)
draw_third_circle(X_Centre, Y_Centre, AoR, RoSc ,h , j)
draw_fourth_circle(X_Centre, Y_Centre, AoR, RoSc ,h , j)
axis equal;
%#######################################################

% --- Executes on button press in Clear.
function Clear_Callback(hObject, eventdata, handles)
% hObject    handle to Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;
set(handles.label_X_initial, 'String','x start point'); %displays the value of X_initial on the graph by using labels
set(handles.label_Y_initial, 'String','y start point'); %displays the value of Y_initial on the graph by using labels
set(handles.label_X_final, 'String','x finish point'); %displays the value of X_final on the graph by using labels
set(handles.label_Y_final, 'String','y finish point'); %displays the value of Y_final on the graph by using labels
grid on;

% --- Executes on button press in circles.
function circles_Callback(hObject, eventdata, handles)
% hObject    handle to circles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of circles
cla;
global RoBc;
global RoSc;
global X_Centre;
global Y_Centre;
global j;
global k;
global h;
global AoR;
global O;
O = get(handles.circles,'Value');
draw_rectangle(X_Centre, Y_Centre, AoR);
draw_first_circle(X_Centre, Y_Centre, AoR, RoBc ,k , j)
draw_second_circle(X_Centre, Y_Centre, AoR, RoBc ,k , j)
draw_third_circle(X_Centre, Y_Centre, AoR, RoSc ,h , j)
draw_fourth_circle(X_Centre, Y_Centre, AoR, RoSc ,h , j)
axis equal;
% --- Executes on button press in rectangle.
function rectangle_Callback(hObject, eventdata, handles)
% hObject    handle to rectangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rectangle
cla;
global RoBc;
global RoSc;
global X_Centre;
global Y_Centre;
global j;
global k;
global h;
global AoR;
global Q;
Q = get(handles.rectangle,'Value');
draw_rectangle(X_Centre, Y_Centre, AoR);
draw_first_circle(X_Centre, Y_Centre, AoR, RoBc ,k , j)
draw_second_circle(X_Centre, Y_Centre, AoR, RoBc ,k , j)
draw_third_circle(X_Centre, Y_Centre, AoR, RoSc ,h , j)
draw_fourth_circle(X_Centre, Y_Centre, AoR, RoSc ,h , j)
axis equal;
