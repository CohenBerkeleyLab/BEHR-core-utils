function [  ] = plot_temp_profs( month_in )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
E = JLLErrors;
Grid = GlobeGrid(5,2);
if ~exist('month_in', 'var')
    month_in = ask_number('Enter the month', 'testfxn', @(x) isscalar(x) && x >= 1 && x <= 12);
elseif ~isscalar(month_in) || ~isnumeric(month_in)
    E.badinput('MONTH_IN must be a scalar number');
end

month_in = repmat(month_in, size(Grid.GridLon));

fileTmp = fullfile(behr_paths.amf_tools_dir,'nmcTmpYr.txt');
temp = rNmcTmp2(fileTmp, behr_pres_levels, Grid.GridLon, Grid.GridLat, month_in);
temp = permute(temp, [2 3 1]);
M = load('coast');
plot_slice_gui(temp, Grid.GridLon, Grid.GridLat, M.long, M.lat);
end

