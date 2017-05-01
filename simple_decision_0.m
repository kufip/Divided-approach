function varargout = simple_decision_0(varargin)
% SIMPLE_DECISION_0 MATLAB code for simple_decision_0.fig
%      SIMPLE_DECISION_0, by itself, creates a new SIMPLE_DECISION_0 or raises the existing
%      singleton*.
%
%      H = SIMPLE_DECISION_0 returns the handle to a new SIMPLE_DECISION_0 or the handle to
%      the existing singleton*.
%
%      SIMPLE_DECISION_0('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMPLE_DECISION_0.M with the given input arguments.
%
%      SIMPLE_DECISION_0('Property','Value',...) creates a new SIMPLE_DECISION_0 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simple_decision_0_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simple_decision_0_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simple_decision_0

% Last Modified by GUIDE v2.5 03-Apr-2017 21:51:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simple_decision_0_OpeningFcn, ...
                   'gui_OutputFcn',  @simple_decision_0_OutputFcn, ...
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


% --- Executes just before simple_decision_0 is made visible.
function simple_decision_0_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simple_decision_0 (see VARARGIN)

% Choose default command line output for simple_decision_0
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simple_decision_0 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = simple_decision_0_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_button.
function load_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% here we load the image
global im
[path,user_canceled]=imgetfile(); % OPEN IMAGE dialog box
if user_canceled
    msgbox(sprintf('Cannot load the image'),'Error','error');
    return
end
im = imread(path);
axes(handles.picture);
imshow(im);
axes(handles.histogram);
bar(0:255,histogram(im));
xlim([0 255])
xlabel('intensity value')
ylabel('number of occurences')
% axes(handles.plot_3)
% [x y] = meshgrid(0:1:size(histogram(im),1),0:1:max(histogram(im)));
% z = histogram(im);
% surf(x,y,z);
% colormap hot




% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% here we reset the original image
global im im2 % global-ra nincs szükség
im2 = im; % for backup process :)
axes(handles.picture);
imshow(im2);
axes(handles.histogram);
bar(0:255,histogram(im));
xlim([0 255])
xlabel('intensity value')
ylabel('number of occurences')




function area_editor_Callback(hObject, eventdata, handles)
% hObject    handle to area_editor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of area_editor as text
%        str2double(get(hObject,'String')) returns contents of area_editor as a double
global max_area
max_area = str2num(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function area_editor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to area_editor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in area_editor_button.
function area_editor_button_Callback(hObject, eventdata, handles)
% hObject    handle to area_editor_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im max_area slider_val
% ha 1.-re a területtet hívjuk meg, akkor a legutóbbi használat utolsó
% slider_val értékével dolgozik
[output_img ratio] = divided_approach(im,slider_val,max_area);
axes(handles.picture)
imshow(output_img)
axes(handles.histogram);
bar(0:255,histogram(output_img));
xlim([0 255])
xlabel('intensity value')
ylabel('number of occurences')




% --- Executes on slider movement.
function avg_slider_Callback(hObject, eventdata, handles)
% hObject    handle to avg_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global im max_area slider_val
slider_val = get(hObject,'Value');
% ha edit_1-ba nem írtunk semmit, és elõször a slider-t használjuk
% többszöri meghívásra u.a. mint a max_area pushbutton
% if ~max_area
%     max_area=0;
%     return
% end
[output_img ratio] = divided_approach(im,slider_val,max_area); % ratio-t megjelenítését belefûzni!
axes(handles.picture)
imshow(output_img)
set(handles.avg_value_screen,'String',num2str(slider_val));
axes(handles.histogram);
bar(0:255,histogram(output_img));
xlim([0 255])
xlabel('intensity value')
ylabel('number of occurences')

% --- Executes during object creation, after setting all properties.
function avg_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to avg_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




function avg_editor_Callback(hObject, eventdata, handles)
% hObject    handle to avg_editor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of avg_editor as text
%        str2double(get(hObject,'String')) returns contents of avg_editor as a double
global avg_editor
avg_editor = str2num(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function avg_editor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to avg_editor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in avg_editor_button.
function avg_editor_button_Callback(hObject, eventdata, handles)
% hObject    handle to avg_editor_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% here we execute the modifications of avg_editor textbox
global im max_area avg_editor
[output_img ratio] = divided_approach(im,avg_editor,max_area); % ratio-t megjelenítését belefûzni!
axes(handles.picture)
imshow(output_img)
set(handles.avg_value_screen,'String',avg_editor);
% set(handles.avg_slider,'String',num2str(avg_editor));
axes(handles.histogram);
bar(0:255,histogram(output_img));
xlim([0 255])
xlabel('intensity value')
ylabel('number of occurences')




function avg_value_screen_Callback(hObject, eventdata, handles)
% hObject    handle to avg_value_screen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of avg_value_screen as text
%        str2double(get(hObject,'String')) returns contents of avg_value_screen as a double

% --- Executes during object creation, after setting all properties.
function avg_value_screen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to avg_value_screen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_button.
function save_button_Callback(hObject, eventdata, handles)
% hObject    handle to save_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% here we execute the saving of output images
global im
axes(handles.picture);
[im,user_canceled] = imsave(); % OPEN IMAGE dialog box
if user_canceled
    msgbox(sprintf('Cannot save the image'),'Error','error');
    return
end
