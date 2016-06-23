function [] = openReadInFig()
%OPENREADINFIG opens the first window of the GUI

figLeft = 200;
figBottom = 500;
figWidth = 400;
figHeight = 310;

global XRDFolder;
global EDXFile;
global saveFile;
global restoreFile;
global saveRestoreFile;

fReadInFig = figure(...
    'Visible', 'off', ...
    'Position', [figLeft figBottom figWidth figHeight], ...
    'Name', 'Open Analysis');

% set background to white
figure(fReadInFig);
set(gcf, 'color', 'w');

% title

titleBottomOffset = 0.9;
titleWidth = 0.4;
titleHeight = 0.05;
titleMiddleHor = 0.5 - titleWidth / 2;
titleFontSize = 16;

htextTitle = uicontrol(fReadInFig, ...
    'Style', 'text', ...
    'String', 'Import Data', ...
    'FontSize', titleFontSize, ...
    'Units', 'Normalized', ...
    'Position', [titleMiddleHor titleBottomOffset ...
    titleWidth titleHeight]);

% labels

leftColOffset = 0.05;
topRowOffset = 0.8;
textWidth = 0.1;
textHeight = 0.05;
textSpacingVert = 0.1;

htextXRD = uicontrol(fReadInFig, 'Style', 'text', 'String', 'XRD', ...
    'Units', 'Normalized', ...
    'Position', [leftColOffset topRowOffset textWidth textHeight]);
htextEDX = uicontrol(fReadInFig, 'Style', 'text', 'String', 'EDX', ...
    'Units', 'Normalized', ...
    'Position', [leftColOffset (topRowOffset - textSpacingVert) ...
    textWidth textHeight]);
htextEC = uicontrol(fReadInFig, 'Style', 'text', 'String', 'EC', ...
    'Units', 'Normalized', ...
    'Position', [leftColOffset (topRowOffset - 2 * textSpacingVert) ...
    textWidth textHeight]);
htextSave = uicontrol(fReadInFig, 'Style', 'text', 'String', 'Save to', ...
    'Units', 'Normalized', ...
    'Position', [leftColOffset (topRowOffset - 3 * textSpacingVert) ...
    textWidth textHeight]);
htextRestore = uicontrol(fReadInFig, ...
    'Style', 'text', ...
    'String', 'Restore', ...
    'Units', 'Normalized', ...
    'Position', [leftColOffset (topRowOffset - 5 * textSpacingVert) ...
    textWidth textHeight]);
htextSaveRestore = uicontrol(fReadInFig, 'Style', 'text', ...
    'String', 'Save to', ...
    'Units', 'Normalized', ...
    'Position', [leftColOffset (topRowOffset - 6 * textSpacingVert) ...
    textWidth textHeight]);

% buttons

colSpacing = 0.15;

buttonWidth = textWidth * 2;
buttonHeight = textHeight;
buttonMiddleHor = 0.5 - buttonWidth / 2;

hbuttonXRD = uicontrol(fReadInFig, 'Style', 'pushbutton', ...
    'String', 'Select folder', 'Units', 'Normalized', ...
    'Position', [(leftColOffset + colSpacing) topRowOffset ...
    buttonWidth buttonHeight], ...
    'Callback', {@buttonXRDCallback});
hbuttonEDX = uicontrol(fReadInFig, 'Style', 'pushbutton', ...
    'String', 'Select file', 'Units', 'Normalized', ...
    'Position', [(leftColOffset + colSpacing) ...
    (topRowOffset - textSpacingVert) ...
    buttonWidth buttonHeight], ...
    'Callback', {@buttonEDXCallback});
hbuttonEC = uicontrol(fReadInFig, 'Style', 'pushbutton', ...
    'String', 'Select folder', 'Units', 'Normalized', ...
    'Position', [(leftColOffset + colSpacing) ...
    (topRowOffset - 2 * textSpacingVert) ...
    buttonWidth buttonHeight]);
hbuttonSave = uicontrol(fReadInFig, 'Style', 'pushbutton', ...
    'String', 'Select file', 'Units', 'Normalized', ...
    'Position', [(leftColOffset + colSpacing) ...
    (topRowOffset - 3 * textSpacingVert) ...
    buttonWidth buttonHeight], ...
    'Callback', {@buttonSaveCallback});
hbuttonImport = uicontrol(fReadInFig, 'Style', 'pushbutton', ...
    'String', 'Begin analysis', 'Units', 'Normalized', ...
    'Position', [buttonMiddleHor (topRowOffset - 4 * textSpacingVert) ...
    buttonWidth buttonHeight], ...
    'Callback', {@buttonImportCallback});
hbuttonRestoreFile = uicontrol(fReadInFig, 'Style', 'pushbutton', ...
    'String', 'Select file', 'Units', 'Normalized', ...
    'Position', [(leftColOffset + colSpacing) ...
    (topRowOffset - 5 * textSpacingVert) ...
    buttonWidth buttonHeight], ...
    'Callback', {@buttonRestoreFileCallback});
hbuttonSaveRestore = uicontrol(fReadInFig,'Style', 'pushbutton', ...
    'String', 'Select file', 'Units', 'Normalized', ...
    'Position', [(leftColOffset + colSpacing) ...
    (topRowOffset - 6 * textSpacingVert) ...
    buttonWidth buttonHeight], ...
    'Callback', {@buttonSaveRestoreCallback});
hbuttonRestore = uicontrol(fReadInFig, 'Style', 'pushbutton', ...
    'String', 'Restore analysis', 'Units', 'Normalized', ...
    'Position', [buttonMiddleHor ...
    (topRowOffset - 7 * textSpacingVert) ...
    buttonWidth buttonHeight], ...
    'Callback', {@buttonRestoreCallback});

% filenames

fileLeftOffset = leftColOffset + colSpacing + buttonWidth + 0.05;
fileWidth = 0.5;
fileHeight = textHeight * 1.5;

htextXRDFolder = uicontrol(fReadInFig, 'Style', 'text', 'String', '', ...
    'Units', 'Normalized', ...
    'Position', [fileLeftOffset topRowOffset ...
    fileWidth fileHeight]);
htextEDXFile = uicontrol(fReadInFig, 'Style', 'text', 'String', '', ...
    'Units', 'Normalized', ...
    'Position', [fileLeftOffset (topRowOffset - textSpacingVert) ...
    fileWidth fileHeight]);
htextSaveFile = uicontrol(fReadInFig, 'Style', 'text', 'String', '', ...
    'Units', 'Normalized', ...
    'Position', [fileLeftOffset (topRowOffset - textSpacingVert * 3) ...
    fileWidth fileHeight]);
htextRestoreFile = uicontrol(fReadInFig, 'Style', 'text', 'String', '', ...
    'Units', 'Normalized', ...
    'Position', [fileLeftOffset (topRowOffset - textSpacingVert * 5) ...
    fileWidth fileHeight]);
htextSaveRestoreFile = uicontrol(fReadInFig, ...
    'Style', 'text', ...
    'String', '', ...
    'Units', 'Normalized', ...
    'Position', [fileLeftOffset (topRowOffset - textSpacingVert * 6) ...
    fileWidth fileHeight]);
    
% make figure visible
fReadInFig.Visible = 'on';

%% callback functions

    function buttonXRDCallback(hbuttonXRD, eventdata, handles)
        XRDFolder = uigetdir;
        set(htextXRDFolder, 'String', XRDFolder);
    end

    function buttonEDXCallback(hbuttonEDX, eventdata, handles)
        [EDXFilename, EDXPathname] = uigetfile;
        EDXFile = strcat(EDXPathname, EDXFilename);
        set(htextEDXFile, 'String', EDXFile);
    end

    function buttonECCallback(hbuttonEC, eventdata, handles)
        ECFolder = uigetdir;
    end

    function buttonSaveCallback(hbuttonSave, eventdata, handles)
        [saveFilename, savePathname] = uigetfile;
        saveFile = strcat(savePathname, saveFilename);
        set(htextSaveFile, 'String', saveFile);
    end

    function buttonImportCallback(hbuttonImport, eventdata, handles)
        if XRDFolder ~= 0
            if EDXFile ~= 0
                if saveFile ~= 0
                    close(fReadInFig);
                    beginAnalysis(XRDFolder, EDXFile, saveFile, ...
                        '/Users/sjiao/Documents/summer_2016/data/CoFeMnO/CoFeMn_OER_cond&CV_KOH1M', ...
                        '/Users/sjiao/Documents/summer_2016/data/CoFeMnO/CoFeMn_OER_cond&CV_KOH1M_2', ...
                        '/Users/sjiao/Documents/summer_2016/data/CoFeMnO/CoFeMn_OER_cond&CV_KOH1M_3');
                else
                    errordlg('No save file selected');
                end
            else
                errordlg('No EDX file selected');
            end
        else
            errordlg('No XRD folder selected');
        end
    end

    function buttonRestoreFileCallback(hbuttonRestoreFile, ...
            eventdata, handles)
        [restoreFilename, restorePath] = uigetfile;
        restoreFile = strcat(restorePath, restoreFilename);
        set(htextRestoreFile, 'String', restoreFile);
    end

    function buttonSaveRestoreCallback(hbuttonSaveRestore, ...
            eventdata, handles)
        [saveRestoreFilename, saveRestorePath] = uigetfile;
        saveRestoreFile = strcat(saveRestorePath, saveRestoreFilename);
        set(htextSaveRestoreFile, 'String', saveRestoreFile);
    end

    function buttonRestoreCallback(hbuttonRestore, ...
            eventdata, handles)
        if restoreFile ~= 0
            if saveRestoreFile ~= 0
                close(fReadInFig);
                importAnalysis(restoreFile, saveRestoreFile);
            else
                errordlg('No save file selected');
            end
        else
            errordlg('No restore file selected');
        end
    end

end

