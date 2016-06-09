function [ output_args ] = binaryPlot( xAxis, yAxis, composition,scaling, axesHandle)
    %BINARYPLOT plots data onto a binary plot
    %   plots data on a nice binary plot where the x axis and y axis are nicely
    %   labeled. xAxis:  a vector containing e.g. the Angles of a XRD pattern
    %   yAxis: a Matrix containing the intensities for the selected XRD pattern
    %   composition: the composition by which the xrd pattern should be sorted
    %   scaling: choose between linear, sqrt, and log10 scaling
    [sComposition,ID] = sort(composition); %sort them according to the composition
    [x,y] = meshgrid(xAxis, sComposition); %create what is nessesary for surf plot
    
    if (scaling == 2)
        yAxis = sqrt(yAxis);
    end 
    if (scaling == 3)
        yAxis = log10(yAxis);
    end 
    
    surf(axesHandle, x,y,yAxis(:,ID).'); %plot the data
    xlabel(axesHandle, 'Angle'); 
    ylabel(axesHandle, 'Composition');
    shading(axesHandle, 'interp'); 
    axis(axesHandle, 'tight'); %this is to make it look good 
    view(axesHandle, 2);
    %view(2); %this is so ensure the correct view
end

