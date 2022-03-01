close all
clear all

load('elevations_TP.mat');

res_v = 0.125;
res_h = 0.125;
lon = (65+res_h/2):res_h: (108-res_h/2);
lat = (41-res_v/2):-res_v: (22 + res_v/2);
[lons,lats]=meshgrid(lon,lat);


%% figue plot
figure;
set(gcf,'unit','normalized','position',[0.1,0.1,0.4,0.3]);
set(gca, 'Position', [0.08 0.08 0.85 0.85])
colors = flipud(brewermap(1000, 'Spectral'));
colormap(colors)

%histogram(FSA_shp2(:) - FSA_shp1(:), [-40:1:40])
plot_global_map_elevation(lats, lons, elevations, 0, 6000, '', 1, 1,'')

hcb = colorbar;
hcb.Title.String = "m";
% %% snow cover
% figure;
print(gcf, '-dtiff', '-r300', ['spatial_map/elevation_TP.tif'])

close all
