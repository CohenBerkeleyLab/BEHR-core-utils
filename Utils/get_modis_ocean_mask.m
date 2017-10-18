function [ is_ocean, lw_lon, lw_lat ] = get_modis_ocean_mask( lonlim, latlim )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if ~exist('cutdown', 'var')
    cutdown = 1;
end

% The land mask seems to be given at 30 arc second resolution
[lw_lon, lw_lat, lw_xx, lw_yy] = modis_cmg_latlon(1/120, lonlim, latlim, 'grid');

hdfi = hdfinfo(behr_paths.modis_land_mask);
lw_mask = hdfreadmodis(hdfi.Filename, hdfdsetname(hdfi, 1, 1, 'LW_MASK_UMD'), 'log_index', {lw_yy, lw_xx});

% According to the attribute "LW_Label" on the LW_MASK_UMD dataset, of the
% 7 labels, 0 = shallow ocean, 6 = moderate or continental ocean, and 7 =
% deep ocean. 1-5 are land, coastlines, lakes, or ephemeral wate.
is_ocean = lw_mask >= 6 | lw_mask == 0;
end

