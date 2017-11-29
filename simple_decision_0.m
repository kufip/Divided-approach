function varargout = simple_decision_0(varargin)
% SIMPLE_DECISION MATLAB code for simple_decision.fig
%      SIMPLE_DECISION, by itself, creates a new SIMPLE_DECISION or raises the existing
%      singleton*.
%
%      H = SIMPLE_DECISION returns the handle to a new SIMPLE_DECISION or the handle to
%      the existing singleton*.
%
%      SIMPLE_DECISION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMPLE_DECISION_0.M with the given input arguments.
%
%      SIMPLE_DECISION('Property','Value',...) creates a new SIMPLE_DECISION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simple_decision_0_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simple_decision_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simple_decision

% Last Modified by GUIDE v2.5 11-Jul-2017 11:11:11

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


% --- Executes just before simple_decision is made visible.
function simple_decision_0_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simple_decision (see VARARGIN)

% Choose default command line output for simple_decision
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simple_decision wait for user response (see UIRESUME)
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
global im im2
[path,user_canceled]=imgetfile(); % OPEN IMAGE dialog box
if user_canceled
    msgbox(sprintf('Cannot load the image'),'Error','error');
    return
end
im = imread(path);
im2 = im; % for backup process :)
axes(handles.saturation);
imshow(im);
axes(handles.Canny);
imshow(im);




% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% here we reset the original image
global im2 % global-ra nincs szükség
if isempty(im2)
    msgbox(sprintf('Cannot restore any previous image!'),'Error','error');
    return
end
axes(handles.saturation);
imshow(im2);
axes(handles.Canny);
imshow(im2);




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

% --- Executes on slider movement.
function avg_slider_Callback(hObject, eventdata, handles)
% hObject    handle to avg_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global im max_area slider_val
slider_val = get(hObject,'Value');
if isempty(max_area) % for first calling
    msgbox(sprintf('Please, give me area value(s)!'),'Error','error');
    return
end
[output_img ratio] = divided_approach(im,slider_val,max_area); % ratio-t megjelenítését belefûzni!
axes(handles.saturation)
imshow(output_img)
set(handles.avg_value_screen,'String',num2str(slider_val));
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




% --- Executes on button press in avg_area_editor_button.
function avg_area_editor_button_Callback(hObject, eventdata, handles)
% hObject    handle to avg_area_editor_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% here we execute the modifications of avg_editor textbox
global im max_area avg_editor
if isempty(max_area) || isempty(avg_editor) % for first calling
    msgbox(sprintf('Please, give me area and/or treshold value(s)!'),'Error','error');
    return
end
[output_img ratio] = divided_approach(im,avg_editor,max_area); % ratio-t megjelenítését belefûzni!
axes(handles.saturation)
imshow(output_img)
set(handles.avg_value_screen,'String',avg_editor);
set(handles.avg_slider,'Value',avg_editor);




% --- Executes on button press in save_sat_button.
function save_sat_button_Callback(hObject, eventdata, handles)
% hObject    handle to save_sat_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% here we execute the saving of output images
global im
axes(handles.saturation);
[im,user_canceled] = imsave(); % OPEN IMAGE dialog box
if user_canceled
    msgbox(sprintf('Cannot save the image!'),'Error','error');
    return
end




% --- Executes during object creation, after setting all properties.
function thresh1_editor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresh1_editor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function thresh1_editor_Callback(hObject, eventdata, handles)
% hObject    handle to thresh1_editor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of thresh1_editor as text
%        str2double(get(hObject,'String')) returns contents of thresh1_editor as a double
global t1
t1 = str2num(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function thresh2_editor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresh2_editor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function thresh2_editor_Callback(hObject, eventdata, handles)
% hObject    handle to thresh2_editor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of thresh2_editor as text
%        str2double(get(hObject,'String')) returns contents of thresh2_editor as a doubl
global t2
t2 = str2num(get(hObject,'String'));

% --- Executes on button press in thresholds_button.
function thresholds_button_Callback(hObject, eventdata, handles)
% hObject    handle to thresholds_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im t1 t2
if isempty(t1) || isempty(t2) % for first calling
    msgbox(sprintf('Please, give me trehold value(s)!'),'Error','error');
    return
end
[output_img] = Canny_edge_detector_func(im,t1,t2);
axes(handles.Canny)
imshow(output_img)




% --- Executes on button press in save_Canny_button.
function save_Canny_button_Callback(hObject, eventdata, handles)
% hObject    handle to save_Canny_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
axes(handles.Canny);
[im,user_canceled] = imsave(); % OPEN IMAGE dialog box
if user_canceled
    msgbox(sprintf('Cannot save the image!'),'Error','error');
    return
end


% --- Executes on button press in fuse_button.
function fuse_button_Callback(hObject, eventdata, handles)
% hObject    handle to fuse_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im2 max_area avg_editor t1 t2
[output_img_sat output_bw] = divided_approach(im,avg_editor,max_area);
[output_img_Canny] = Canny_edge_detector_func(im,t1,t2);
fused = imfuse(output_bw,output_img_Canny);
axes(handles.saturation);
imshow(im2);
axes(handles.Canny);
imshow(fused);


% --- Executes on button press in save_fuse_button.
function save_fuse_button_Callback(hObject, eventdata, handles)
% hObject    handle to save_fuse_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
axes(handles.Canny);
[im,user_canceled] = imsave(); % OPEN IMAGE dialog box
if user_canceled
    msgbox(sprintf('Cannot save the image!'),'Error','error');
    return
end
