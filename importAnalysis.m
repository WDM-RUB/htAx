function [] = importAnalysis(analysisFile, saveFile)
%IMPORTANALYSIS reloads an analysis session

analysis = load(analysisFile, '-mat');

otherData = 0;

openFigs(analysis.XRDData, ...
    analysis.A, analysis.B, analysis.C, ...
    analysis.numSelected, analysis.pointInfo, ...
    analysis.ECData, analysis.ECPlotInfo, ...
    analysis.collcodes, analysis.XRDDatabase, analysis.labels, ...
    analysis.savedPoly, analysis.ECDataReal, otherData);
end

