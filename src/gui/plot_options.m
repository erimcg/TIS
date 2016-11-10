function varargout = plot_options(varargin)
    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @plot_options_OpeningFcn, ...
                       'gui_OutputFcn',  @plot_options_OutputFcn, ...
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

function plot_options_OpeningFcn(hObject, eventdata, handles, varargin)
    % Choose default command line output for plot_options
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes plot_options wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
end


function varargout = plot_options_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;
end


