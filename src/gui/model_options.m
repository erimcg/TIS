function varargout = model_options(varargin)
%MODEL_OPTIONS M-file for model_options.fig
%      MODEL_OPTIONS, by itself, creates a new MODEL_OPTIONS or raises the existing
%      singleton*.
%
%      H = MODEL_OPTIONS returns the handle to a new MODEL_OPTIONS or the handle to
%      the existing singleton*.
%
%      MODEL_OPTIONS('Property','Value',...) creates a new MODEL_OPTIONS using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to model_options_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MODEL_OPTIONS('CALLBACK') and MODEL_OPTIONS('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MODEL_OPTIONS.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help model_options

% Last Modified by GUIDE v2.5 01-Jul-2015 12:19:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @model_options_OpeningFcn, ...
                   'gui_OutputFcn',  @model_options_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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

function model_options_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for model_options
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes model_options wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function varargout = model_options_OutputFcn(hObject, eventdata, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;


function classifier_type_Callback(hObject, eventdata, handles)
    str = get(hObject, 'String');
    val = get(hObject, 'Value');
    switch str{val};
        case 'Probabilistic'
            R = findobj(gcf, 'Tag', 'svm_options_label');
            set(R, 'enable', 'off');
            R = findobj(gcf, 'Tag', 'cmin_label');
            set(R, 'enable', 'off');
            R = findobj(gcf, 'Tag', 'cstep_label');
            set(R, 'enable', 'off'); 
            R = findobj(gcf, 'Tag', 'cmax_label');
            set(R, 'enable', 'off');  
            R = findobj(gcf, 'Tag', 'gmin_label');
            set(R, 'enable', 'off'); 
            R = findobj(gcf, 'Tag', 'gstep_label');
            set(R, 'enable', 'off'); 
            R = findobj(gcf, 'Tag', 'gmax_label');
            set(R, 'enable', 'off');  
            R = findobj(gcf, 'Tag', 'cmin');
            set(R, 'enable', 'off');  
            R = findobj(gcf, 'Tag', 'cstep');
            set(R, 'enable', 'off');   
            R = findobj(gcf, 'Tag', 'cmax');
            set(R, 'enable', 'off');   
            R = findobj(gcf, 'Tag', 'gmin');
            set(R, 'enable', 'off');
           R = findobj(gcf, 'Tag', 'gstep');
            set(R, 'enable', 'off');   
            R = findobj(gcf, 'Tag', 'gmax');
            set(R, 'enable', 'off'); 
        case 'Support Vector Machine'
            R = findobj(gcf, 'Tag', 'svm_options_label');
            set(R, 'enable', 'on');
            R = findobj(gcf, 'Tag', 'cmin_label');
            set(R, 'enable', 'on');
            R = findobj(gcf, 'Tag', 'cstep_label');
            set(R, 'enable', 'on'); 
            R = findobj(gcf, 'Tag', 'cmax_label');
            set(R, 'enable', 'on');  
            R = findobj(gcf, 'Tag', 'gmin_label');
            set(R, 'enable', 'on'); 
            R = findobj(gcf, 'Tag', 'gstep_label');
            set(R, 'enable', 'on'); 
            R = findobj(gcf, 'Tag', 'gmax_label');
            set(R, 'enable', 'on');  
            R = findobj(gcf, 'Tag', 'cmin');
            set(R, 'enable', 'on');  
            R = findobj(gcf, 'Tag', 'cstep');
            set(R, 'enable', 'on');   
            R = findobj(gcf, 'Tag', 'cmax');
            set(R, 'enable', 'on');   
            R = findobj(gcf, 'Tag', 'gmin');
            set(R, 'enable', 'on');
           R = findobj(gcf, 'Tag', 'gstep');
            set(R, 'enable', 'on');   
            R = findobj(gcf, 'Tag', 'gmax');
            set(R, 'enable', 'on');
    end


function system_mode_Callback(hObject, eventdata, handles)
    str = get(hObject, 'String');
    val = get(hObject, 'Value');
    switch str{val};
        case 'Identification'
            R = findobj(gcf, 'Tag', 'threshold');
            set(R, 'enable', 'off');
            R = findobj(gcf, 'Tag', 'threshold_label');
            set(R, 'enable', 'off');
            
            R = findobj(gcf, 'Tag', 'classifier_type');
            set(R, 'enable', 'on');
            
        case 'Authentication'
            R = findobj(gcf, 'Tag', 'threshold');
            set(R, 'enable', 'on');
            R = findobj(gcf, 'Tag', 'threshold_label');
            set(R, 'enable', 'on');
            
            R = findobj(gcf, 'Tag', 'classifier_type');
            set(R, 'value', 1);
            set(R, 'enable', 'off');
            
            R = findobj(gcf, 'Tag', 'svm_options_label');
            set(R, 'enable', 'off');
            R = findobj(gcf, 'Tag', 'cmin_label');
            set(R, 'enable', 'off');
            R = findobj(gcf, 'Tag', 'cstep_label');
            set(R, 'enable', 'off'); 
            R = findobj(gcf, 'Tag', 'cmax_label');
            set(R, 'enable', 'off');  
            R = findobj(gcf, 'Tag', 'gmin_label');
            set(R, 'enable', 'off'); 
            R = findobj(gcf, 'Tag', 'gstep_label');
            set(R, 'enable', 'off'); 
            R = findobj(gcf, 'Tag', 'gmax_label');
            set(R, 'enable', 'off');  
            R = findobj(gcf, 'Tag', 'cmin');
            set(R, 'enable', 'off');  
            R = findobj(gcf, 'Tag', 'cstep');
            set(R, 'enable', 'off');   
            R = findobj(gcf, 'Tag', 'cmax');
            set(R, 'enable', 'off');   
            R = findobj(gcf, 'Tag', 'gmin');
            set(R, 'enable', 'off');
           R = findobj(gcf, 'Tag', 'gstep');
            set(R, 'enable', 'off');   
            R = findobj(gcf, 'Tag', 'gmax');
            set(R, 'enable', 'off');            
    end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over subject_model_dir.
function subject_model_dir_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to subject_model_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    dir_name = uigetdir;
    set(hObject, 'String', dir_name);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over hetero_model_dir.
function hetero_model_dir_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to hetero_model_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    dir_name = uigetdir;
    set(hObject, 'String', dir_name);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over homo_model_dir.
function homo_model_dir_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to homo_model_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    dir_name = uigetdir;
    set(hObject, 'String', dir_name);


%%% --- End of File --- %%%


% --- Executes during object creation, after setting all properties.
function subject_model_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subject_model_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function hetero_model_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hetero_model_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function homo_model_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to homo_model_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
