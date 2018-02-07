function [ F, behr_dir ] = list_behr_files( start_date, end_date, prof_mode, region )
%LIST_BEHR_FILES List all BEHR .mat files between two dates
%   [ F, BEHR_DIR ] = LIST_BEHR_FILES( START_DATE, END_DATE ) will list all
%   monthly profile, US BEHR files between START_DATE and END_DATE, which
%   must be date specifications understood by Matlab (strings or numbers).
%   Returns F, a structure from DIR(), and BEHR_DIR, the directory it
%   searched.
%
%   [ ___ ] = LIST_BEHR_FILES( ___, PROF_MODE )
%   [ ___ ] = LIST_BEHR_FILES( ___, PROF_MODE, REGION ) allows you to use
%   different profile mode BEHR files ('daily' or 'monthly') and different
%   regions ('us', or 'hk').

E = JLLErrors;

start_date = validate_date(start_date);
end_date = validate_date(end_date);

if ~exist('prof_mode', 'var')
    prof_mode = 'monthly';
elseif ~ischar(prof_mode)
    E.badinput('PROF_MODE must be a string');
end
if ~exist('region', 'var')
    region = 'us';
elseif ~ischar(region)
    E.badinput('REGION must be a string');
end

behr_dir = behr_paths.BEHRMatSubdir(region, prof_mode);
file_pattern = behr_filename('*', prof_mode, region, '.mat');
F = dir(fullfile(behr_dir, file_pattern));

dvec = datenum(regexp({F.name}, '\d\d\d\d\d\d\d\d', 'match', 'once'), 'yyyymmdd');
dd = dvec >= start_date & dvec <= end_date;

F(~dd) = [];

end

