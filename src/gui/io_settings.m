function varargout = io_settings(varargin)
% IO_SETTINGS MATLAB code for io_settings.fig
%      IO_SETTINGS, by itself, creates a new IO_SETTINGS or raises the existing
%      singleton*.
%
%      H = IO_SETTINGS returns the handle to a new IO_SETTINGS or the handle to
%      the existing singleton*.
%
%      IO_SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IO_SETTINGS.M with the given input arguments.
%
%      IO_SETTINGS('Property','Value',...) creates a new IO_SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before io_settings_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to io_settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help io_settings

% Last Modified by GUIDE v2.5 02-Jul-2015 14:07:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @io_settings_OpeningFcn, ...
                   'gui_OutputFcn',  @io_settings_OutputFcn, ...
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

% --- Executes just before io_settings is made visible.
function io_settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to io_settings (see VARARGIN)

% Choose default command line output for io_settings
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes io_settings wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = io_settings_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over thoracic_data_dir.

% --- No Longer in use, moved to trial_selection.m

%function thoracic_data_dir_ButtonDownFcn(hObject, eventdata, handles)
%   dir_name = uigetdir;     
%   set(hObject, 'String', dir_name);
%end

function subject_model_dir_ButtonDownFcn(hObject, eventdata, handles)
   dir_name = uigetdir;     
   set(hObject, 'String', dir_name);
end

function hetero_model_dir_ButtonDownFcn(hObject, eventdata, handles)
   dir_name = uigetdir;     
   set(hObject, 'String', dir_name);
end

function homo_model_dir_ButtonDownFcn(hObject, eventdata, handles)
   dir_name = uigetdir;     
   set(hObject, 'String', dir_name);
end

% END OF FILE
