function varargout = SimImLi(varargin)
% SIMIMLI MATLAB code for SimImLi.fig
%      SIMIMLI, by itself, creates a new SIMIMLI or raises the existing
%      singleton*.
%
%      H = SIMIMLI returns the handle to a new SIMIMLI or the handle to
%      the existing singleton*.
%
%      SIMIMLI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMIMLI.M with the given input arguments.
%
%      SIMIMLI('Property','Value',...) creates a new SIMIMLI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SimImLi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SimImLi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SimImLi

% Last Modified by GUIDE v2.5 27-Jul-2016 12:44:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SimImLi_OpeningFcn, ...
                   'gui_OutputFcn',  @SimImLi_OutputFcn, ...
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


% --- Executes just before SimImLi is made visible.
function SimImLi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SimImLi (see VARARGIN)

% Choose default command line output for SimImLi
handles.output = hObject;

import java.net.*;
import java.io.*;

handles.ip = '134.100.111.111';
handles.port = 1080;

handles.socket = 1;% Socket(handles.ip, handles.port);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SimImLi wait for user response (see UIRESUME)
% uiwait(handles.MainFigure);


% --- Outputs from this function are returned to the command line.
function varargout = SimImLi_OutputFcn(hObject, eventdata, handles) 
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

result = SimulateImaging('s', str2double(s), 'time', str2double(t)*1e-6, ...
    'initialDetuning', str2double(iD), 'doChirp', ...
    [dC, str2double(cS), str2double(cE)]);
handles.chirp = result.chirp;
handles.time = result.time;
set(handles.edtChirp, 'String', num2str(result.chirp*1e-6,4));

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pbVFG.
function pbVFG_Callback(hObject, eventdata, handles)
% hObject    handle to pbVFG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

multiplier = str2double(handles.edtMulti.String);
chirp = str2double(handles.edtChirp.String)*multiplier;
offset = str2double(handles.edtOffset.String)*multiplier;
time = str2double(handles.edtT.String);
amp = str2double(handles.edtAmp.String);
dC = handles.checkboxDoSweep.Value;

if dC 
    msg = ['tri; amp ' num2str(amp) '.; swe ' num2str(offset) '. ' num2str(offset+chirp) '. ' num2str(time*1e-3) '. ', ...
         num2str(time*1e-3/2,'%1.6f') '.; amp ' num2str(amp) '.; fre ' num2str(offset) '.;eos; flush'];
else
    msg = ['amp ' num2str(amp) '.; fre ' num2str(offset) '.; eos; flush'];
end

set(handles.txtCMD, 'String', msg);
 
out = handles.socket.getOutputStream;
out.write(int8(msg));


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

close(handles.socket);

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
