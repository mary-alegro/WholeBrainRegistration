function varargout = seg_histology(varargin)
% SEG_histology MATLAB code for seg_histology.fig
%      SEG_histology, by itself, creates a new SEG_histology or raises the existing
%      singleton*.
%
%      H = SEG_histology returns the handle to a new SEG_histology or the handle to
%      the existing singleton*.
%
%      SEG_histology('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEG_histology.M with the given input arguments.
%
%      SEG_histology('Property','Value',...) creates a new SEG_histology or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before seg_histology_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to seg_histology_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help seg_histology

% Last Modified by GUIDE v2.5 17-Jul-2015 16:00:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @seg_histology_OpeningFcn, ...
                   'gui_OutputFcn',  @seg_histology_OutputFcn, ...
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

global tmp_dir;
tmp_dir = '/home/maryana/Posdoc/Brainstem/';

% --- Executes just before seg_histology is made visible.
function seg_histology_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to seg_histology (see VARARGIN)

% Choose default command line output for seg_histology
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes seg_histology wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = seg_histology_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function pathCase_Callback(hObject, eventdata, handles)
% hObject    handle to pathCase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pathCase as text
%        str2double(get(hObject,'String')) returns contents of pathCase as a double


% --- Executes during object creation, after setting all properties.
function pathCase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pathCase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonBrowseCase.
function buttonBrowseCase_Callback(hObject, eventdata, handles)
% hObject    handle to buttonBrowseCase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global root_dir histo_dir orig_dir seg_dir init_file init_str tmp_dir;

root_dir = uigetdir(tmp_dir);
if root_dir(end) ~= '/'
    root_dir = [root_dir '/'];
end
set(handles.pathCase,'String',root_dir);
histo_dir = strcat(root_dir,'histology/');
orig_dir = strcat(histo_dir, 'orig/');
seg_dir = strcat(histo_dir,'seg/');
init_file = strcat(histo_dir,'init_segmentation.mat'); 
try
    init = load(init_file);
    init_str = init.init_str;
    
    set(handles.pathRefImg,'String',init_str.file);
    
    mL = init_str.tissue(1);
    mA = init_str.tissue(2);
    mB = init_str.tissue(3);
    set(handles.textTissue,'String',strcat(num2str(mL),';',num2str(mA),';',num2str(mB)));
    mL = init_str.back(1);
    mA = init_str.back(2);
    mB = init_str.back(3);
    set(handles.textBackground,'String',strcat(num2str(mL),';',num2str(mA),';',num2str(mB)));
    mL = init_str.wp(1);
    mA = init_str.wp(2);
    mB = init_str.wp(3);
    set(handles.textWhite,'String',strcat(num2str(mL),';',num2str(mA),';',num2str(mB)));
    set(handles.textStatus,'String','Initialization file found!');
    
catch
    set(handles.textStatus,'String','Initialization file not found! User must initialize the segmentation parameters.' );
end



function textTissue_Callback(hObject, eventdata, handles)
% hObject    handle to textTissue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textTissue as text
%        str2double(get(hObject,'String')) returns contents of textTissue as a double


% --- Executes during object creation, after setting all properties.
function textTissue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textTissue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textBackground_Callback(hObject, eventdata, handles)
% hObject    handle to textBackground (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textBackground as text
%        str2double(get(hObject,'String')) returns contents of textBackground as a double


% --- Executes during object creation, after setting all properties.
function textBackground_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textBackground (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textWhite_Callback(hObject, eventdata, handles)
% hObject    handle to textWhite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textWhite as text
%        str2double(get(hObject,'String')) returns contents of textWhite as a double


% --- Executes during object creation, after setting all properties.
function textWhite_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textWhite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonInitTissue.
function buttonInitTissue_Callback(hObject, eventdata, handles)
% hObject    handle to buttonInitTissue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global init_str ref_img;

if isempty(ref_img)
    set(handles.textStatus,'String','User must select the reference point for white balance first.');
    return;
end    

hf = figure, imshow(ref_img);
H = imfreehand();
mask = H.createMask();
close(hf);
[mL, mA, mB] = meanLAB(ref_img,mask);
init_str.tissue = [mL mA mB];
set(handles.textTissue,'String',strcat(num2str(mL),';',num2str(mA),';',num2str(mB)));


% --- Executes on button press in buttonRun.
function buttonRun_Callback(hObject, eventdata, handles)
% hObject    handle to buttonRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global root_dir init_str;
set(handles.textStatus,'String','Running segmentation...');
preprocess_seg_histo_v2(root_dir,init_str.wp,init_str.tissue,init_str.back,'jpg');
set(handles.textStatus,'String','Segmentation ended.');

% --- Executes on button press in buttonInitBack.
function buttonInitBack_Callback(hObject, eventdata, handles)
% hObject    handle to buttonInitBack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global init_str ref_img;

if isempty(ref_img)
    set(handles.textStatus,'String','User must select the reference point for white balance first.');
    return;
end    

hf = figure, imshow(ref_img);
H = imfreehand();
mask = H.createMask();
close(hf);
[mL, mA, mB] = meanLAB(ref_img,mask);
init_str.back = [mL mA mB];
set(handles.textBackground,'String',strcat(num2str(mL),';',num2str(mA),';',num2str(mB)));


% --- Executes on button press in buttonInitWhite.
function buttonInitWhite_Callback(hObject, eventdata, handles)
% hObject    handle to buttonInitWhite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global init_str ref_img;

refImg = imread(init_str.file);
hf = figure, imshow(refImg);
H = impoint();
pos = H.getPosition();
pos = round(pos);
close(hf);
wR = refImg(pos(2),pos(1),1);
wG = refImg(pos(2),pos(1),2);
wB = refImg(pos(2),pos(1),3);
init_str.wp = [wR wG wB];

set(handles.textStatus,'String','Enhancing white balance...');
ref_img = weak_wb(refImg,init_str.wp);
set(handles.textStatus,'String','');
set(handles.textWhite,'String',strcat(num2str(wR),';',num2str(wG),';',num2str(wB)));



% --- Executes on button press in buttonSave.
function buttonSave_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global init_file init_str;

save(init_file,'init_str');
set(handles.textStatus,'String','Initialization file saved.');


function [mL, mA, mB] = meanLAB(img,mask)
	cform = makecform('srgb2lab');
	LAB = applycform(im2double(img),cform);
    L = LAB(:,:,1); A = LAB(:,:,2); B = LAB(:,:,3);
    mL = mean(L(mask == 1));
    mA = mean(A(mask == 1));
    mB = mean(B(mask == 1));
   

function pathRefImg_Callback(hObject, eventdata, handles)
% hObject    handle to pathRefImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pathRefImg as text
%        str2double(get(hObject,'String')) returns contents of pathRefImg as a double


% --- Executes during object creation, after setting all properties.
function pathRefImg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pathRefImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonBrowseRef.
function buttonBrowseRef_Callback(hObject, eventdata, handles)
% hObject    handle to buttonBrowseRef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ref_img init_str orig_dir;
ref_img = '';
path_img = '';
[ref_img, path_img] = uigetfile(strcat(orig_dir,'*.*'),'Choose reference image');
ref_img = strcat(path_img,ref_img);
init_str.file = ref_img;
set(handles.pathRefImg,'String',ref_img);
