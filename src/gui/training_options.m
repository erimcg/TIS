function varargout = training_options(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @training_options_OpeningFcn, ...
                   'gui_OutputFcn',  @training_options_OutputFcn, ...
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


% --- Executes just before training_options is made visible.
function training_options_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for training_options
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes training_options wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = training_options_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in training_data_dir.
function training_data_dir_Callback(hObject, eventdata, handles)
% hObject    handle to training_data_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns training_data_dir contents as cell array
%        contents{get(hObject,'Value')} returns selected item from training_data_dir


% --- Executes during object creation, after setting all properties.
function training_data_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to training_data_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over testing_data_dir.
function training_data_dir_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to testing_data_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   dir_name = uigetdir;     
   set(hObject, 'String', dir_name);


% --- Executes on key press with focus on training_data_dir and none of its controls.
function training_data_dir_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to training_data_dir (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function training_samplerate_Callback(hObject, eventdata, handles)
% hObject    handle to training_samplerate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of training_samplerate as text
%        str2double(get(hObject,'String')) returns contents of training_samplerate as a double


% --- Executes during object creation, after setting all properties.
function training_samplerate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to training_samplerate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in training_delineator.
function training_delineator_Callback(hObject, eventdata, handles)
% hObject    handle to training_delineator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns training_delineator contents as cell array
%        contents{get(hObject,'Value')} returns selected item from training_delineator


% --- Executes during object creation, after setting all properties.
function training_delineator_CreateFcn(hObject, eventdata, handles)
% hObject    handle to training_delineator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
