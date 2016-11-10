function varargout = trial_selection(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trial_selection_OpeningFcn, ...
                   'gui_OutputFcn',  @trial_selection_OutputFcn, ...
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


% --- Executes just before trial_selection is made visible.
function trial_selection_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for trial_selection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trial_selection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = trial_selection_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ecg_1_1.
function ecg_1_1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ecg_1_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
% --- Otherwise, executes on mouse press in 5 pixel border or over testing_data_dir.
function training_data_dir_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to testing_data_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   dir_name = uigetdir;     
   set(hObject, 'String', dir_name);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over training_data_dir.
function testing_data_dir_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to training_data_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   dir_name = uigetdir;     
   set(hObject, 'String', dir_name);
