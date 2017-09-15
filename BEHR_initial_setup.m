function [  ] = BEHR_initial_setup( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[behr_repo_path, myname] = fileparts(mfilename('fullpath'));

make_paths_file();

    function make_paths_file
        % Check that behr_paths.m does not already exist anywhere. If there's one
        % in the right place, then ask if we want to overwrite it. If there's one
        % somewhere else, the user will need to move or delete it so that we don't
        % get two behr_paths.m files.
        paths_filename = 'behr_paths.m';
        paths_file = fullfile(behr_repo_path,'Utils','Constants',paths_filename);
        
        if exist(paths_file,'file')
            user_ans = input(sprintf('A %s file already exists in BEHR/Utils/Constants. Replace it? (y to replace, any other key to abort): ', paths_filename), 's');
            if ~(strcmpi(user_ans,'Yes') || strcmpi(user_ans, 'y'))
                error('BEHR_setup:user_cancel','A %s file already exists and you have chosen not to overwrite it.', paths_filename);
            end
        elseif ~isempty(which(paths_filename))
            error('BEHR_setup:file_exists','%s exists on your Matlab search path, but at %s, not at BEHR/Utils/Constants. Please delete or move that version to BEHR/Utils/Constants.',paths_filename, which(paths_filename));
        end
        
        % This defines all the paths that should exist in that file. The
        % field name is the name the property will be given, the 'comment'
        % subfield is the explanatory comment, and the 'default' subfield
        % is what the default will be. If either field is omitted, that is
        % fine. A generic comment will be inserted and a blank path will be
        % inserted. Including the subfield "no_quote" at all will cause it
        % not to automatically quote the default path, which is useful if
        % you need to allow for multiple paths in a cell array.
        
        sat_file_server = '128.32.208.13';
        wrf_file_server = 'cohenwrfnas.dyn.berkeley.edu';
        
        % Local repos/folders
        paths.classes.comment = sprintf('The Matlab classes repository; it should contain at least the class JLLErrors. May be cloned from share-sat/SAT/BEHR/BEHR_MatlabClasses_GitRepo.git on the file server at %s.', sat_file_server);
        paths.classes.default = fullfile(behr_repo_path, '..', 'Classes');
        paths.utils.comment = sprintf('The directory of the general Matlab Utils repository (not the one inside the BEHR repo). May be cloned from share-sat/SAT/BEHR/MiscUtils.git on the file server at %s.', sat_file_server);
        paths.utils.default = fullfile(behr_repo_path, '..', 'Utils');
        paths.amf_tools_dir.comment = 'The AMF_tools directory in the BEHR repository on your computer. It should contain the files damf.txt and nmcTmpYr.txt';
        paths.amf_tools_dir.default = fullfile(behr_repo_path, 'AMF_tools');
        
        % Matlab file folders
        paths.sp_mat_dir.comment = sprintf('The default path where OMI_SP_vX-YZ_yyyymmdd.mat files will be saved and read from. For UC Berkeley users, is it on the file server at %s which should be mounted on your computer.',sat_file_server);
        paths.sp_mat_dir.default = fullfile(sat_folder, 'SAT', 'BEHR', 'SP_Files_2014');
        paths.behr_mat_dir.comment = sprintf('The default path where OMI_BEHR_vX-YZ_yyyymmdd.mat files will be saved and read from. For UC Berkeley users, is it on the file server at %s which should be mounted on your computer.',sat_file_server);
        paths.behr_mat_dir.default = fullfile(sat_folder, 'SAT', 'BEHR', 'BEHR_Files_2014');
        
        % OMI and ancillary data folders
        paths.omno2_dir.comment = sprintf('This should contain folders organized by year and month with OMI-Aura_L2-OMNO2 files in them. For UC Berkeley users, is it on the file server at %s which should be mounted on your computer.',sat_file_server);
        paths.omno2_dir.default = fullfile(sat_folder, 'SAT', 'OMI', 'OMNO2', 'version_3_3_0');
        paths.ompixcor_dir.comment = sprintf('This should contain folders organized by year and month with OMI-Aura_L2-OMNPIXCOR files in them. For UC Berkeley users, is it on the file server at %s which should be mounted on your computer.',sat_file_server);
        paths.ompixcor_dir.default = fullfile(sat_folder, 'SAT', 'OMI', 'OMPIXCOR', 'version_003');
        paths.myd06_dir.comment = sprintf('This should contain folders for each year with MYD06_L2 files in them. For UC Berkeley users, is it on the file server at %s which should be mounted on your computer.',sat_file_server);
        paths.myd06_dir.default = fullfile(sat_folder, 'SAT', 'MODIS', 'MYD06_L2');
        paths.mcd43c1_dir.comment = sprintf('This should contain folders for each year with MCD43C1 files in them. For UC Berkeley users, is it on the file server at %s which should be mounted on your computer.',sat_file_server);
        paths.mcd43c1_dir.default = fullfile(sat_folder, 'SAT', 'MODIS', 'MCD43C1');
        paths.modis_land_mask.comment = sprintf('This is the "Land_Water_Mask_7Classes_UMD file, available from ftp://rsftp.eeos.umb.edu/data02/Gapfilled/ (as of 21 Sept 2017). For UC Berkeley users, is it on the file server at %s which should be mounted on your computer.',sat_file_server);
        paths.modis_land_mask.default = fullfile(sat_folder, 'SAT', 'MODIS', 'Land_Water_Mask_7Classes_UMD.hdf');
        paths.modis_land_mask.isfile = true;
        paths.globe_dir.comment = sprintf('This is the folder with the GLOBE database, available from https://www.ngdc.noaa.gov/mgg/topo/gltiles.html (as of 21 Sept 2017). It should contain files a10g through p10g and their .hdr files. For UC Berkeley users, is it on the file server at %s which should be mounted on your computer.',sat_file_server);
        paths.globe_dir.default = fullfile(sat_folder, 'SAT', 'BEHR','GLOBE_Database');

        paths.website_staging_dir.comment = sprintf('The directory where data should be staged before being put on the folders visible to the website. Also on the file server at %s which should be mounted on your computer.', sat_file_server);
        paths.website_staging_dir.default = fullfile(sat_folder,'SAT','BEHR','WEBSITE','staging');
        
        % WRF data is spread across multiple volumes locally. It's just too
        % big.
        paths.wrf_monthly_profiles.comment = sprintf('The path that contains the WRF_BEHR*.nc monthly profile files. This should be on the file server at %s.', wrf_file_server);
        paths.wrf_monthly_profiles.default = fullfile('share-wrf1','MonthlyProfiles');
        
        paths.wrf_profiles.comment = sprintf('Add all paths that contain WRF profiles. These should be folders that are organized by year and month, with wrfout_d01 files in them. These will be found on the file server at %s, all volumes must be mounted on your computer.', wrf_file_server);
        paths.wrf_profiles.default = sprintf('{''%s'', ''%s''}', fullfile('share-wrf1', 'Output'), fullfile('share-wrf2', 'Output'));
        paths.wrf_profiles.no_quote = true;
        
        %%%%%%%%%%%%%%%%%%
        % Write the file %
        %%%%%%%%%%%%%%%%%%
        fid = fopen(paths_file, 'w');
        fns = fieldnames(paths);
        
        % The opening class definition and comment block
        [~, name_no_ext] = fileparts(paths_filename);
        fprintf(fid,'classdef %s\n', name_no_ext);
        fprintf(fid,'%% behr_paths: paths used in the BEHR algorithm.\n%%\tAutomatically generated by %s on %s\n',myname,datestr(today,29));
        fprintf(fid,'%%\tValid path names to request are:\n');
        for a=1:numel(fns)
            fprintf(fid,'%%\t\t%s\n',fns{a});
        end
        fprintf(fid,'%%\n%%\tEach of these paths are stored in this class as constant properties\n%%\tthat can be accessed directly from the class without an instance.\n');
        fprintf(fid,'%%\n%%\tNote that this function should not be added to the BEHR git repo, as\n%%\tit must be specific to each person''s computer\n\n');
        
        % A little introductory comment block
        intro_comment = ['Each of the following paths needs to be a local path on your computer. ',...
                         'For the code repositories, you will want to clone those from the file ',...
                         'server onto your computer and point the path to that cloned repository. ',...
                         'For the data directories that are on the file server, you will need to ',...
                         'mount the file server as a network drive on your computer and point the ',...
                         'paths below to that mounted path. Network drives mapped on windows have ',...
                         'the drive letter you assign when you map it; on Macs, they are usually ',...
                         'found under the /Volumes path. If you are working on a Linux computer ',...
                         'you''ll usually create mount points under /mnt or similar - that is how ',...
                         'the satellite download computer is set up.'];
        intro_comment_2 = ['If you''re working with BEHR on a cluster, you likely won''t need to deal ',...
                           'with networked drives, and everything will have a straightforward path.'];
                     
        fprintf(fid, wrap_comment(intro_comment, 0));
        fprintf(fid, '%%\n');
        fprintf(fid, wrap_comment(intro_comment_2, 0));
        fprintf(fid, '%%\n');
        
        % The properties block with will hold each path
        fprintf(fid,'\tproperties(Constant=true)\n');
        for a=1:numel(fns)
            if isfield(paths.(fns{a}), 'comment');
                this_comment = wrap_comment(paths.(fns{a}).comment, 2);
            else
                this_comment = wrap_comment(fns{a}, 2);
            end
            fprintf(fid, this_comment);
            
            if isfield(paths.(fns{a}), 'default')
                this_default = paths.(fns{a}).default;
            else
                this_default = '';
            end
            
            if isfield(paths.(fns{a}), 'no_quote')
                fprintf(fid, '\t\t%s = %s;\n\n', fns{a}, this_default);
            else
                fprintf(fid, '\t\t%s = ''%s'';\n\n', fns{a}, this_default);
            end
        end
        fprintf(fid, '\tend\n');
        fprintf(fid, 'end');
        fclose(fid);
        
        fprintf('\n!!! Defaults %s file created at %s. Review it and edit the paths as needed. !!!\n\n', paths_filename, paths_file);
    end

    
end

function str_out = wrap_comment(comment, indent_level)
% Assume each line is 76 characters long, allow 4 spaces for tabs and 2
% characters for the "% " at the beginning
nchars = 76 - 4*indent_level - 2;
tabs = repmat('\t', 1, indent_level);
i = 1;
str_out = '';
while i < length(comment)
    % Find the last space before the end of the line
    if length(comment) - i > nchars
    i2 = min(length(comment), i+nchars);
    j = strfind(comment(i:i2), ' ');
    j = j(end);
    else
        j = length(comment) - i + 1;
    end
    str_out = [str_out, tabs, '%% ', strtrim(comment(i:i+j-1)), '\n'];
    %str_out{end+1} = sprintf('%% %s\n',strtrim(comment(i:i+j-1)));
    i = i+j;
end
end

function write_paths(paths, fid)
fns = fieldnames(paths);
for a=1:numel(fns)
    if isfield(paths.(fns{a}), 'comment');
        this_comment = wrap_comment(paths.(fns{a}).comment, 2);
    else
        this_comment = wrap_comment(fns{a}, 2);
    end
    fprintf(fid, this_comment);
    
    if isfield(paths.(fns{a}), 'default')
        this_default = paths.(fns{a}).default;
    else
        this_default = '';
    end
    
    if isfield(paths.(fns{a}), 'no_quote')
        fprintf(fid, '\t\t%s = %s;\n\n', fns{a}, this_default);
    else
        fprintf(fid, '\t\t%s = ''%s'';\n\n', fns{a}, this_default);
    end
end
end

function write_is_file_struct(paths, fid)
is_file_fxn = @(path_struct) isfield(path_struct, 'isfile');
write_bool_structure(paths, fid, 'is_field_file', is_file_fxn);
end

function write_iscodedir_structs(paths, fid)
iscodedir_fxn = @(path_struct) isfield(path_struct, 'is_code_dir');
do_genpath_fxn = @(path_struct) isfield(path_struct, 'is_code_dir') && ~strcmpi(path_struct.is_code_dir, 'norecurse');

write_bool_structure(paths, fid, 'is_code_dir', iscodedir_fxn);
fprintf(fid, '\n');
write_bool_structure(paths, fid, 'do_genpath', do_genpath_fxn);
end

function write_bool_structure(paths, fid, struct_name, bool_fxn)
% Write a structure containing each of the paths as fields with a boolean
% value. "paths" must be the paths structure, fid an open file identifier,
% struct_name the name you want the struct to have a bool_fxn a handle to a
% functions that, when given the value of a field in paths returns the
% boolean value you want stored in the struct for that field.
bool_struct = struct;
fns = fieldnames(paths);
for a=1:numel(fns)
    if bool_fxn(paths.(fns{a}))
        bool_struct.(fns{a}) = 'true';
    else
        bool_struct.(fns{a}) = 'false';
    end
end

fprintf(fid, '\t\t%s = struct(', struct_name);
for a=1:numel(fns)
    if a < numel(fns)
        fprintf(fid,'''%s'', %s,...\n\t\t\t', fns{a}, bool_struct.(fns{a}));
    else
        fprintf(fid,'''%s'', %s);\n', fns{a}, bool_struct.(fns{a}));
    end
end
end