function varargout = tis(varargin)
    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @tis_OpeningFcn, ...
                       'gui_OutputFcn',  @tis_OutputFcn, ...
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

end
% End initialization code - DO NOT EDIT

% --- Executes just before tis is made visible.
function tis_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);

    global training_options_panel;    
    global testing_options_panel;
    global ecg_preprocessing_options_panel;   
    global ecg_feature_set_options_panel;
    global ldv_preprocessing_options_panel;    
    global ldv_feature_set_options_panel;  
    global ldv_segmentation_options_panel;
    global model_options_panel;
    global plot_options_panel;
        
    training_options_fig = training_options;
    training_options_panel = get(training_options_fig, 'children');
    set(training_options_panel, 'Parent', hObject);
    delete(training_options_fig);
    
    testing_options_fig = testing_options;
    testing_options_panel = get(testing_options_fig, 'children');
    set(testing_options_panel, 'Parent', hObject);
    delete(testing_options_fig);
    
    ecg_preprocessing_options_fig = ecg_preprocessing_options;
    ecg_preprocessing_options_panel = get(ecg_preprocessing_options_fig, 'children');
    set(ecg_preprocessing_options_panel, 'Parent', hObject);    
    delete(ecg_preprocessing_options_fig);    
    
    ecg_feature_set_options_fig = ecg_feature_set_options;
    ecg_feature_set_options_panel = get(ecg_feature_set_options_fig, 'children');
    set(ecg_feature_set_options_panel, 'Parent', hObject);    
    delete(ecg_feature_set_options_fig);

    ldv_preprocessing_options_fig = ldv_preprocessing_options;
    ldv_preprocessing_options_panel = get(ldv_preprocessing_options_fig, 'children');
    set(ldv_preprocessing_options_panel, 'Parent', hObject);    
    delete(ldv_preprocessing_options_fig); 
    
    ldv_feature_set_options_fig = ldv_feature_set_options;
    ldv_feature_set_options_panel = get(ldv_feature_set_options_fig, 'children');
    set(ldv_feature_set_options_panel, 'Parent', hObject);    
    delete(ldv_feature_set_options_fig);
    
    ldv_segmentation_options_fig = ldv_segmentation_options;
    ldv_segmentation_options_panel = get(ldv_segmentation_options_fig, 'children');
    set(ldv_segmentation_options_panel, 'Parent', hObject);    
    delete(ldv_segmentation_options_fig);     
    
    model_options_fig = model_options;
    model_options_panel = get(model_options_fig, 'children');
    set(model_options_panel, 'Parent', hObject);    
    delete(model_options_fig); 
    
    plot_options_fig = plot_options;
    plot_options_panel = get(plot_options_fig, 'children');
    set(plot_options_panel, 'Parent', hObject);    
    delete(plot_options_fig); 
    
    default_panel_loc = get(handles.options_panel, 'Position');
    
    set(training_options_panel, 'Position', default_panel_loc);
    set(testing_options_panel, 'Position', default_panel_loc);
    set(ecg_preprocessing_options_panel, 'Position', default_panel_loc);   
    set(ecg_feature_set_options_panel, 'Position', default_panel_loc);
    set(ldv_preprocessing_options_panel, 'Position', default_panel_loc);   
    set(ldv_feature_set_options_panel, 'Position', default_panel_loc); 
    set(ldv_segmentation_options_panel, 'Position', default_panel_loc);
    set(model_options_panel,  'Position', default_panel_loc);
    set(plot_options_panel, 'Position', default_panel_loc);
    
    set_panel_visibility_off
   
    set(model_options_panel, 'Visible', 'on');  
end

% --- Outputs from tis function are returned to the command line.
function varargout = tis_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;    
end

% ------------------  OPTIONS MENUS --------------------------------------

function training_options_menu_Callback(hObject, eventdata, handles)
    global training_options_panel;
    
    set_panel_visibility_off   
    set(training_options_panel, 'Visible', 'on'); 
end

function testing_options_menu_Callback(hObject, eventdata, handles)
    global testing_options_panel;
    set_panel_visibility_off   
    set(testing_options_panel, 'Visible', 'on'); 
end

function ecg_preprocessing_options_menu_Callback(hObject, eventdata, handles)
    global ecg_preprocessing_options_panel;

    set_panel_visibility_off
    set(ecg_preprocessing_options_panel, 'Visible', 'on'); 
end

function ecg_feature_set_options_menu_Callback(hObject, eventdata, handles)
    global ecg_feature_set_options_panel;
    
    set_panel_visibility_off
    set(ecg_feature_set_options_panel, 'Visible', 'on');
end

function ldv_preprocessing_options_menu_Callback(hObject, eventdata, handles)
    global ldv_preprocessing_options_panel;

    set_panel_visibility_off
    set(ldv_preprocessing_options_panel, 'Visible', 'on'); 
end

function ldv_feature_set_options_menu_Callback(hObject, eventdata, handles)
    global ldv_feature_set_options_panel;

    set_panel_visibility_off
    set(ldv_feature_set_options_panel, 'Visible', 'on'); 
end
% --------------------------------------------------------------------
function ldv_segmentation_options_menu_Callback(hObject, eventdata, handles)
    global ldv_segmentation_options_panel;
    
    set_panel_visibility_off
    set(ldv_segmentation_options_panel, 'Visible', 'on');
end


function model_options_menu_Callback(hObject, eventdata, handles)
    global model_options_panel;

    set_panel_visibility_off
    set(model_options_panel, 'Visible', 'on'); 
end

function plot_options_menu_Callback(hObject, eventdata, handles)
    global plot_options_panel;

    set_panel_visibility_off
    set(plot_options_panel, 'Visible', 'on'); 
end
% ------------------- PLOT PANEL --------------------------------------    

function  plot_panel_CreateFcn(hObject, eventdata, handles)
    global plot_panel;
    plot_panel = hObject;   
end

% ------------------   CALCULATE_TRAINING_FEATURES BUTTON  -----------------------------

function calculate_training_features_Callback(hObject, eventdata, handles)   

    set_options_vars;
    calculate_features('train');
    
    fprintf('Finished calculating training features.\n'); 

end

% ------------------   CALCULATE_TESTING_FEATURES BUTTON  -----------------------

function calculate_testing_features_Callback(hObject, eventdata, handles)

    set_options_vars;
    calculate_features('test');
    
    fprintf('Finished calculating testing features.\n');
end

% -------------------   CLASSIFY BUTTON ----------------------------------------

function classify_Callback(hObject, eventdata, handles)

    set_options_vars;
    classify
    
    fprintf('Finished classifying\n');
end

% ------------------   EXIT BUTTON  -----------------------------   

function exit_Callback(hObject, eventdata, handles)
    close all
end

% ------------------ PRIVATE FUNCTIONS --------------------------------

function set_panel_visibility_off
    global training_options_panel;
    global testing_options_panel;
    global ecg_preprocessing_options_panel;
    global ecg_feature_set_options_panel;
    global ldv_preprocessing_options_panel;
    global ldv_feature_set_options_panel;
    global ldv_segmentation_options_panel;
    global model_options_panel;
    global plot_options_panel;
 
    set(training_options_panel, 'Visible', 'off');
    set(testing_options_panel, 'Visible', 'off');
    set(ecg_preprocessing_options_panel, 'Visible', 'off');    
    set(ecg_feature_set_options_panel, 'Visible', 'off');
    set(ldv_preprocessing_options_panel, 'Visible', 'off');
    set(ldv_feature_set_options_panel, 'Visible', 'off'); 
    set(ldv_segmentation_options_panel, 'Visible', 'off');
    set(model_options_panel, 'Visible', 'off');
    set(plot_options_panel, 'Visible', 'off');    
end
