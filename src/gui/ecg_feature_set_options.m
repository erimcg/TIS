function varargout = ecg_feature_set_options(varargin)
% ECG_FEATURE_SET_OPTIONS MATLAB code for ecg_feature_set_options.fig
%      ECG_FEATURE_SET_OPTIONS, by itself, creates a new ECG_FEATURE_SET_OPTIONS or raises the existing
%      singleton*.
%
%      H = ECG_FEATURE_SET_OPTIONS returns the handle to a new ECG_FEATURE_SET_OPTIONS or the handle to
%      the existing singleton*.
%
%      ECG_FEATURE_SET_OPTIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ECG_FEATURE_SET_OPTIONS.M with the given input arguments.
%
%      ECG_FEATURE_SET_OPTIONS('Property','Value',...) creates a new ECG_FEATURE_SET_OPTIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ecg_feature_set_options_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ecg_feature_set_options_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ecg_feature_set_options

% Last Modified by GUIDE v2.5 25-Jun-2015 12:08:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ecg_feature_set_options_OpeningFcn, ...
                   'gui_OutputFcn',  @ecg_feature_set_options_OutputFcn, ...
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

end

% --- Executes just before ecg_feature_set_options is made visible.
function ecg_feature_set_options_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ecg_feature_set_options (see VARARGIN)

% Choose default command line output for ecg_feature_set_options
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ecg_feature_set_options wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = ecg_feature_set_options_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

end

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
end

function segment_boundaries_Callback(hObject, eventdata, handles)
    parent = get(hObject, 'Parent');
    str = get(hObject, 'String');
    val = get(hObject, 'Value');
    
    switch str{val};
        case 'Fixed Length Relative to Peaks'
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
    end
end


function feature_selection_Callback(hObject, eventdata, handles)
    parent = get(hObject, 'Parent');
    str = get(hObject, 'String');
    val = get(hObject, 'Value');
    
    switch str{val};
        case 'Fixed Number'
            R = findobj(gcf, 'Tag', 'num_selected_bins', 'Parent', parent);
            set(R, 'visible', 'on');
            R = findobj(gcf, 'Tag', 'num_selected_bins_label', 'Parent', parent);
            set(R, 'visible', 'on'); 
            R = findobj(gcf, 'Tag', 'maxHz', 'Parent', parent);
            set(R, 'visible', 'on');
            R = findobj(gcf, 'Tag', 'maxHz_label', 'Parent', parent);
            set(R, 'visible', 'on');             
            R = findobj(gcf, 'Tag', 'threshold', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'threshold_label', 'Parent', parent);
            set(R, 'visible', 'off');   
                  
        case 'Threshold Based'
            R = findobj(gcf, 'Tag', 'num_selected_bins', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'num_selected_bins_label', 'Parent', parent);
            set(R, 'visible', 'off'); 
            R = findobj(gcf, 'Tag', 'maxHz', 'Parent', parent);
            set(R, 'visible', 'off');
            R = findobj(gcf, 'Tag', 'maxHz_label', 'Parent', parent);
            set(R, 'visible', 'off');             
            R = findobj(gcf, 'Tag', 'threshold', 'Parent', parent);
            set(R, 'visible', 'on');
            R = findobj(gcf, 'Tag', 'threshold_label', 'Parent', parent);
            set(R, 'visible', 'on');             
    end
end


% --- Executes on button press in closest_to_mean.
function ecg_closest_to_mean_Callback(hObject, eventdata, handles)
% hObject    handle to closest_to_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of closest_to_mean
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over closest_to_mean.
function ecg_closest_to_mean_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to closest_to_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


% --- Executes on selection change in segment_selection_mode.
function segment_selection_mode_Callback(hObject, eventdata, handles)
% hObject    handle to segment_selection_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns segment_selection_mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from segment_selection_mode
end

% --- Executes during object creation, after setting all properties.
function segment_selection_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to segment_selection_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
