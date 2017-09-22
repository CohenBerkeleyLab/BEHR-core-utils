function [ lon, lat, xx, yy ] = modis_cmg_latlon( resolution, lonlim, latlim, as_grid )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if ~exist('lonlim', 'var')
    lonlim = [-180 180];
end
if ~exist('latlim', 'var')
    latlim = [-90 90];
end

if ~exist('as_grid', 'var')
    as_grid = false;
end

% 

lon = (-180 + resolution/2):resolution:(180 - resolution/2);
lat = (90 - resolution/2):-resolution:(-90 + resolution/2);

xx = lon >= min(lonlim) & lon <= max(lonlim);
yy = lat >= min(latlim) & lat <= max(latlim);

lon = lon(xx);
lat = lat(yy);

if as_grid
    [lon, lat] = meshgrid(lon, lat);
end

end

