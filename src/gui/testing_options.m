function varargout = testing_options(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testing_options_OpeningFcn, ...
                   'gui_OutputFcn',  @testing_options_OutputFcn, ...
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


% --- Executes just before testing_options is made visible.
function testing_options_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for testing_options
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testing_options wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testing_options_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in testing_data_dir.
function testing_data_dir_Callback(hObject, eventdata, handles)
% hObject    handle to testing_data_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns testing_data_dir contents as cell array
%        contents{get(hObject,'Value')} returns selected item from testing_data_dir


% --- Executes during object creation, after setting all properties.
function testing_data_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to testing_data_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over training_data_dir.
function testing_data_dir_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to training_data_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   dir_name = uigetdir;     
   set(hObject, 'String', dir_name);


% --- Executes on key press with focus on testing_data_dir and none of its controls.
function testing_data_dir_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to testing_data_dir (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function testing_samplerate_Callback(hObject, eventdata, handles)
% hObject    handle to testing_samplerate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of testing_samplerate as text
%        str2double(get(hObject,'String')) returns contents of testing_samplerate as a double


% --- Executes during object creation, after setting all properties.
function testing_samplerate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to testing_samplerate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in testing_delineator.
function testing_delineator_Callback(hObject, eventdata, handles)
% hObject    handle to testing_delineator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns testing_delineator contents as cell array
%        contents{get(hObject,'Value')} returns selected item from testing_delineator


% --- Executes during object creation, after setting all properties.
function testing_delineator_CreateFcn(hObject, eventdata, handles)
% hObject    handle to testing_delineator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
