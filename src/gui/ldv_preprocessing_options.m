function varargout = ldv_preprocessing_options(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ldv_preprocessing_options_OpeningFcn, ...
                   'gui_OutputFcn',  @ldv_preprocessing_options_OutputFcn, ...
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


% --- Executes just before ldv_preprocessing_options is made visible.
function ldv_preprocessing_options_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for ldv_preprocessing_options
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ldv_preprocessing_options wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ldv_preprocessing_options_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
varargout{1} = handles.output;



function window_size_Callback(hObject, eventdata, handles)
% hObject    handle to window_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of window_size as text
%        str2double(get(hObject,'String')) returns contents of window_size as a double


% --- Executes during object creation, after setting all properties.
function window_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to window_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over remove_dropouts.
function remove_dropouts_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to remove_dropouts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function remove_dropouts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to remove_dropouts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in remove_dropouts.
function remove_dropouts_Callback(hObject, eventdata, handles)
% hObject    handle to remove_dropouts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of remove_dropouts


% --- Executes on button press in apply_high_pass_filter.
function apply_high_pass_filter_Callback(hObject, eventdata, handles)
% hObject    handle to apply_high_pass_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of apply_high_pass_filter


% --- Executes on selection change in downsample_method.
function downsample_method_Callback(hObject, eventdata, handles)
% hObject    handle to downsample_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns downsample_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from downsample_method


% --- Executes during object creation, after setting all properties.
function downsample_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to downsample_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in peak_detect_alg.
function peak_detect_alg_Callback(hObject, eventdata, handles)
% hObject    handle to peak_detect_alg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns peak_detect_alg contents as cell array
%        contents{get(hObject,'Value')} returns selected item from peak_detect_alg


% --- Executes during object creation, after setting all properties.
function peak_detect_alg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to peak_detect_alg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
