function varargout = SimImLiGui(varargin)
% SIMIMLIGUI MATLAB code for SimImLiGui.fig
%      SIMIMLIGUI, by itself, creates a new SIMIMLIGUI or raises the existing
%      singleton*.
%
%      H = SIMIMLIGUI returns the handle to a new SIMIMLIGUI or the handle to
%      the existing singleton*.
%
%      SIMIMLIGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMIMLIGUI.M with the given input arguments.
%
%      SIMIMLIGUI('Property','Value',...) creates a new SIMIMLIGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SimImLiGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SimImLiGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SimImLiGui

% Last Modified by GUIDE v2.5 01-Dec-2016 12:22:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SimImLiGui_OpeningFcn, ...
                   'gui_OutputFcn',  @SimImLiGui_OutputFcn, ...
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


% --- Executes just before SimImLiGui is made visible.
function SimImLiGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SimImLiGui (see VARARGIN)

% Choose default command line output for SimImLiGui
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SimImLiGui wait for user response (see UIRESUME)
% uiwait(handles.MainFigure);


% --- Outputs from this function are returned to the command line.
function varargout = SimImLiGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edtS_Callback(hObject, eventdata, handles)
% hObject    handle to edtS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtS as text
%        str2double(get(hObject,'String')) returns contents of edtS as a double


% --- Executes during object creation, after setting all properties.
function edtS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtT_Callback(hObject, eventdata, handles)
% hObject    handle to edtT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtT as text
%        str2double(get(hObject,'String')) returns contents of edtT as a double


% --- Executes during object creation, after setting all properties.
function edtT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtInitD_Callback(hObject, eventdata, handles)
% hObject    handle to edtInitD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtInitD as text
%        str2double(get(hObject,'String')) returns contents of edtInitD as a double


% --- Executes during object creation, after setting all properties.
function edtInitD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtInitD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbSim.
function pbSim_Callback(hObject, eventdata, handles)
% hObject    handle to pbSim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

s = handles.edtS.String;
t = handles.edtT.String;
iD = handles.edtInitD.String;
dC = handles.checkboxDoSweep.Value;
cS = handles.edtSweepStart.String;
cE = handles.edtSweepEnd.String;

result = SimImLi('s', str2double(s), 'time', str2double(t)*1e-6, ...
    'initialDetuning', str2double(iD), 'doChirp', ...
    [dC, str2double(cS), str2double(cE)]);
handles.chirp = result.chirp;
handles.time = result.time;

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in checkboxDoSweep.
function checkboxDoSweep_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxDoSweep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxDoSweep



function edtSweepStart_Callback(hObject, eventdata, handles)
% hObject    handle to edtSweepStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtSweepStart as text
%        str2double(get(hObject,'String')) returns contents of edtSweepStart as a double


% --- Executes during object creation, after setting all properties.
function edtSweepStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtSweepStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtSweepEnd_Callback(hObject, eventdata, handles)
% hObject    handle to edtSweepEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtSweepEnd as text
%        str2double(get(hObject,'String')) returns contents of edtSweepEnd as a double


% --- Executes during object creation, after setting all properties.
function edtSweepEnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtSweepEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtOffset_Callback(hObject, eventdata, handles)
% hObject    handle to edtOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtOffset as text
%        str2double(get(hObject,'String')) returns contents of edtOffset as a double


% --- Executes during object creation, after setting all properties.
function edtOffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close MainFigure.
function MainFigure_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to MainFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


function edtAmp_Callback(hObject, eventdata, handles)
% hObject    handle to edtAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtAmp as text
%        str2double(get(hObject,'String')) returns contents of edtAmp as a double


% --- Executes during object creation, after setting all properties.
function edtAmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtAmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtChirp_Callback(hObject, eventdata, handles)
% hObject    handle to edtChirp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtChirp as text
%        str2double(get(hObject,'String')) returns contents of edtChirp as a double


% --- Executes during object creation, after setting all properties.
function edtChirp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtChirp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtMulti_Callback(hObject, eventdata, handles)
% hObject    handle to edtMulti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtMulti as text
%        str2double(get(hObject,'String')) returns contents of edtMulti as a double


% --- Executes during object creation, after setting all properties.
function edtMulti_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtMulti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
