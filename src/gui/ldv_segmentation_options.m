function varargout = ldv_segmentation_options(varargin)
%LDV_SEGMENTATION_OPTIONS M-file for ldv_segmentation_options.fig
%      LDV_SEGMENTATION_OPTIONS, by itself, creates a new LDV_SEGMENTATION_OPTIONS or raises the existing
%      singleton*.
%
%      H = LDV_SEGMENTATION_OPTIONS returns the handle to a new LDV_SEGMENTATION_OPTIONS or the handle to
%      the existing singleton*.
%
%      LDV_SEGMENTATION_OPTIONS('Property','Value',...) creates a new LDV_SEGMENTATION_OPTIONS using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to ldv_segmentation_options_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      LDV_SEGMENTATION_OPTIONS('CALLBACK') and LDV_SEGMENTATION_OPTIONS('CALLBACK',hObject,...) call the
%      local function named CALLBACK in LDV_SEGMENTATION_OPTIONS.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ldv_segmentation_options

% Last Modified by GUIDE v2.5 02-Jul-2015 12:38:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ldv_segmentation_options_OpeningFcn, ...
                   'gui_OutputFcn',  @ldv_segmentation_options_OutputFcn, ...
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


% --- Executes just before ldv_segmentation_options is made visible.
function ldv_segmentation_options_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for ldv_segmentation_options
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ldv_segmentation_options wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ldv_segmentation_options_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function num_segments_per_beat_Callback(hObject, eventdata, handles) 
    parent = get(hObject, 'Parent');
    str = get(hObject, 'String');
    val = get(hObject, 'Value');
 
    R = findobj(gcf, 'Tag', 'segment_boundaries', 'Parent', parent);
    str2 = get(R, 'String');
    val2 = get(R, 'Value');
    
    if strcmp(str2{val2}, 'Peak to Peak')
        return;
    end
    
    switch str{val};
        case '1'
            R = findobj(gcf, 'Tag', 'before_secondary_peak_segment_length_label', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'before_secondary_peak_segment_length', 'Parent', parent);
            set(R, 'visible', 'off'); 
            R = findobj(gcf, 'Tag', 'after_secondary_peak_segment_length_label', 'Parent', parent);
            set(R, 'visible', 'off');
            
            R = findobj(gcf, 'Tag', 'after_secondary_peak_segment_length', 'Parent', parent);
            set(R, 'visible', 'off');    
        case '2'
            R = findobj(gcf, 'Tag', 'before_secondary_peak_segment_length_label', 'Parent', parent);
            set(R, 'visible', 'on');
            R = findobj(gcf, 'Tag', 'before_secondary_peak_segment_length', 'Parent', parent);
            set(R, 'visible', 'on'); 
            R = findobj(gcf, 'Tag', 'after_secondary_peak_segment_length_label', 'Parent', parent);
            set(R, 'visible', 'on');
            R = findobj(gcf, 'Tag', 'after_secondary_peak_segment_length', 'Parent', parent);
            set(R, 'visible', 'on');
    end


function segment_boundaries_Callback(hObject, eventdata, handles)
    parent = get(hObject, 'Parent');
    str = get(hObject, 'String');
    val = get(hObject, 'Value');
    
    switch str{val};
        case 'Fixed Length'
            R = findobj(gcf, 'Tag', 'peak_to_peak_filter_method_label', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'peak_to_peak_filter_method', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'num_samples_from_peak_to_peak_label', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'num_samples_from_peak_to_peak', 'Parent', parent);
            set(R, 'visible', 'off');
            
            R = findobj(gcf, 'Tag', 'num_segments_per_beat_label', 'Parent', parent);
            set(R, 'visible', 'off');            
            R = findobj(gcf, 'Tag', 'num_segments_per_beat', 'Parent', parent);
            set(R, 'visible', 'off');
            
            R = findobj(gcf, 'Tag', 'before_primary_peak_segment_length_label', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'before_primary_peak_segment_length', 'Parent', parent);
            set(R, 'visible', 'off'); 
            R = findobj(gcf, 'Tag', 'after_primary_peak_segment_length_label', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'after_primary_peak_segment_length', 'Parent', parent);
            set(R, 'visible', 'off');
            
            R = findobj(gcf, 'Tag', 'window_size_label', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'window_size', 'Parent', parent);
            set(R, 'visible', 'off');
            
        case 'Fixed Length Relative to Peaks'
            R = findobj(gcf, 'Tag', 'window_size_label', 'Parent', parent);
            set(R, 'visible', 'on');
            R = findobj(gcf, 'Tag', 'window_size', 'Parent', parent);
            set(R, 'visible', 'on');
            
            R = findobj(gcf, 'Tag', 'peak_to_peak_filter_method_label', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'peak_to_peak_filter_method', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'num_samples_from_peak_to_peak_label', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'num_samples_from_peak_to_peak', 'Parent', parent);
            set(R, 'visible', 'off');
            
            R = findobj(gcf, 'Tag', 'num_segments_per_beat_label', 'Parent', parent);
            set(R, 'visible', 'on');            
            R = findobj(gcf, 'Tag', 'num_segments_per_beat', 'Parent', parent);
            set(R, 'visible', 'on');
            
            R = findobj(gcf, 'Tag', 'before_primary_peak_segment_length_label', 'Parent', parent);
            set(R, 'visible', 'on');
            R = findobj(gcf, 'Tag', 'before_primary_peak_segment_length', 'Parent', parent);
            set(R, 'visible', 'on'); 
            R = findobj(gcf, 'Tag', 'after_primary_peak_segment_length_label', 'Parent', parent);
            set(R, 'visible', 'on');
            R = findobj(gcf, 'Tag', 'after_primary_peak_segment_length', 'Parent', parent);
            set(R, 'visible', 'on');
            
            R = findobj(gcf, 'Tag', 'num_segments_per_beat', 'Parent', parent, 'Parent', parent);
            str2 = get(R, 'String');
            val2 = get(R, 'Value');

            
            if strcmp(str2{val2}, '2')
                R = findobj(gcf, 'Tag', 'before_secondary_peak_segment_length_label', 'Parent', parent);
                set(R, 'visible', 'on');
                R = findobj(gcf, 'Tag', 'before_secondary_peak_segment_length', 'Parent', parent);
                set(R, 'visible', 'on'); 
                R = findobj(gcf, 'Tag', 'after_secondary_peak_segment_length_label', 'Parent', parent);
                set(R, 'visible', 'on');
                R = findobj(gcf, 'Tag', 'after_secondary_peak_segment_length', 'Parent', parent);
                set(R, 'visible', 'on');
            end
            
        case 'Peak to Peak'
            R = findobj(gcf, 'Tag', 'window_size_label', 'Parent', parent);
            set(R, 'visible', 'on');
            R = findobj(gcf, 'Tag', 'window_size', 'Parent', parent);
            set(R, 'visible', 'on');
            
            R = findobj(gcf, 'Tag', 'num_segments_per_beat_label', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'num_segments_per_beat', 'Parent', parent);
            set(R, 'visible', 'off');
            
            R = findobj(gcf, 'Tag', 'before_primary_peak_segment_length_label', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'before_primary_peak_segment_length', 'Parent', parent);
            set(R, 'visible', 'off'); 
            R = findobj(gcf, 'Tag', 'after_primary_peak_segment_length_label', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'after_primary_peak_segment_length', 'Parent', parent);
            set(R, 'visible', 'off');
            
            R = findobj(gcf, 'Tag', 'before_secondary_peak_segment_length_label', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'before_secondary_peak_segment_length', 'Parent', parent);
            set(R, 'visible', 'off'); 
            R = findobj(gcf, 'Tag', 'after_secondary_peak_segment_length_label', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'after_secondary_peak_segment_length', 'Parent', parent);
            set(R, 'visible', 'off');
            
            R = findobj(gcf, 'Tag', 'peak_to_peak_filter_method_label', 'Parent', parent);
            set(R, 'visible', 'on');
            R = findobj(gcf, 'Tag', 'peak_to_peak_filter_method', 'Parent', parent);
            set(R, 'visible', 'on');
            
            R = findobj(gcf, 'Tag', 'num_samples_from_peak_to_peak_label', 'Parent', parent);
            set(R, 'visible', 'on');
            R = findobj(gcf, 'Tag', 'num_samples_from_peak_to_peak', 'Parent', parent);
            set(R, 'visible', 'on');
    end

    
function peak_to_peak_filter_method_Callback(hObject, eventdata, handles)


function before_primary_peak_segment_length_Callback(hObject, eventdata, handles)
% hObject    handle to before_primary_peak_segment_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of before_primary_peak_segment_length as text
%        str2double(get(hObject,'String')) returns contents of before_primary_peak_segment_length as a double


% --- Executes during object creation, after setting all properties.
function before_primary_peak_segment_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to before_primary_peak_segment_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function after_primary_peak_segment_length_Callback(hObject, eventdata, handles)
% hObject    handle to after_primary_peak_segment_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of after_primary_peak_segment_length as text
%        str2double(get(hObject,'String')) returns contents of after_primary_peak_segment_length as a double


% --- Executes during object creation, after setting all properties.
function after_primary_peak_segment_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to after_primary_peak_segment_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function segment_boundaries_CreateFcn(hObject, eventdata, handles)
% hObject    handle to segment_boundaries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function before_secondary_peak_segment_length_Callback(hObject, eventdata, handles)
% hObject    handle to before_secondary_peak_segment_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of before_secondary_peak_segment_length as text
%        str2double(get(hObject,'String')) returns contents of before_secondary_peak_segment_length as a double


% --- Executes during object creation, after setting all properties.
function before_secondary_peak_segment_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to before_secondary_peak_segment_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function after_secondary_peak_segment_length_Callback(hObject, eventdata, handles)
% hObject    handle to after_secondary_peak_segment_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of after_secondary_peak_segment_length as text
%        str2double(get(hObject,'String')) returns contents of after_secondary_peak_segment_length as a double


% --- Executes during object creation, after setting all properties.
function after_secondary_peak_segment_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to after_secondary_peak_segment_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function num_segments_per_beat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_segments_per_beat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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

% --- Executes during object creation, after setting all properties.
function peak_to_peak_filter_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to peak_to_peak_filter_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_samples_from_peak_to_peak_Callback(hObject, eventdata, handles)
% hObject    handle to num_samples_from_peak_to_peak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_samples_from_peak_to_peak as text
%        str2double(get(hObject,'String')) returns contents of num_samples_from_peak_to_peak as a double


% --- Executes during object creation, after setting all properties.
function num_samples_from_peak_to_peak_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_samples_from_peak_to_peak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
