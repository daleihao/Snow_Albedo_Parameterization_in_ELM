close all
clear all


res_v = 0.125;
res_h = 0.125;
lon = (65+res_h/2):res_h: (108-res_h/2);
lat = (41-res_v/2):-res_v: (22 + res_v/2);
[lons,lats]=meshgrid(lon,lat);

for Seasonname_i = {'spring'}
    Seasonname = Seasonname_i{1};
load(['ELM_Data_Season_11years\11years_ELMBC_TP_snowshape_1_iBC_eDUST_' Seasonname '.mat'])
Fsn_1_iBC_eDust_PP = NetSolarRadiations_all;
SnowCovers_PP = SnowCovers_all;
load(['ELM_Data_Season_11years\11years_ELMBC_TP_snowshape_4_iBC_eDUST_' Seasonname '.mat'])
Fsn_4_iBC_eDust_PP = NetSolarRadiations_all;

load(['ELM_Data_Season_11years\11years_ELMBC_TP_snowshape_1_eBC_eDUST_' Seasonname '.mat'])
Fsn_1_eBC_eDust_PP = NetSolarRadiations_all;
load(['ELM_Data_Season_11years\11years_ELMBC_TP_snowshape_4_eBC_eDUST_' Seasonname  '.mat'])
Fsn_4_eBC_eDust_PP = NetSolarRadiations_all;


load(['ELM_Data_Season_11years\11years_ELMBC_TP_snowshape_1_eBC_iDUST_'  Seasonname '.mat'])
Fsn_1_eBC_iDust_PP = NetSolarRadiations_all;
load(['ELM_Data_Season_11years\11years_ELMBC_TP_snowshape_4_eBC_iDUST_' Seasonname '.mat'])
Fsn_4_eBC_iDust_PP = NetSolarRadiations_all;

load(['ELM_Data_Season_11years\TOP_11years_ELMBC_TP_snowshape_1_eBC_iDUST_' Seasonname '.mat'])
Fsn_1_eBC_iDust_TOP = NetSolarRadiations_all;
load(['ELM_Data_Season_11years\TOP_11years_ELMBC_TP_snowshape_4_eBC_iDUST_' Seasonname '.mat'])
Fsn_4_eBC_iDust_TOP = NetSolarRadiations_all;

delta_shape_Koch = Fsn_4_iBC_eDust_PP - Fsn_1_iBC_eDust_PP;
delta_BC_Sphere = Fsn_1_iBC_eDust_PP - Fsn_1_eBC_eDust_PP;
delta_BC_Koch = Fsn_4_iBC_eDust_PP - Fsn_4_eBC_eDust_PP;
delta_Dust_Sphere = Fsn_1_eBC_iDust_PP - Fsn_1_eBC_eDust_PP;
delta_Dust_Koch = Fsn_4_eBC_iDust_PP - Fsn_4_eBC_eDust_PP;
delta_TOP_sphere = Fsn_1_eBC_iDust_TOP - Fsn_1_eBC_iDust_PP;
delta_TOP_Koch = Fsn_4_eBC_iDust_TOP - Fsn_4_eBC_iDust_PP;
delta_combined = Fsn_4_eBC_iDust_TOP - Fsn_1_iBC_eDust_PP;

load('elevations_TP.mat');

filter = elevations <=1500 | SnowCovers_PP<0.1;
delta_shape_Koch(filter) = nan;
delta_BC_Sphere(filter) = nan;
delta_BC_Koch(filter) = nan;
delta_Dust_Sphere(filter) = nan;
delta_Dust_Koch(filter) = nan;
delta_TOP_sphere(filter) = nan;
delta_TOP_Koch(filter) = nan;
delta_combined(filter) = nan;

%% figue plot

maxvalue = 20;
minvalue = -20;

figure;
set(gcf,'unit','normalized','position',[0.1,0.1,0.4,0.8]);
set(gca, 'Position', [0 0 1 1])
colors = flipud(brewermap(100, 'PRGN'));
colormap(colors)

subplot('position', [0.04 0.53 0.4 0.21])
%histogram(FSA_shp2(:) - FSA_shp1(:), [-40:1:40])
plot_global_map_RF(lats, lons, delta_combined, minvalue, maxvalue, '', 0, 1,'(a)')

t = title('Combined effects');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);

%ylabel({'Winter',''},'fontsize',12,'fontweight','bold')
subplot('position', [0.53 0.53 0.4 0.21])
plot_global_map_RF(lats, lons, delta_shape_Koch, minvalue, maxvalue, '', 0, 0,'(b)')

%ylabel({'RF by BC',''},'fontsize',12)
t = title('Koch Snowflake- Sphere');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);

subplot('position', [0.48 0.53 0.4 0.21])
plot_global_map_RF(lats, lons, delta_TOP_sphere, minvalue, maxvalue, '', 0, 0,'(c)')

%ylabel({'RF by dust',''},'fontsize',12)
t = title('Sphere: TOP - PP');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);

subplot('position', [0.70 0.53 0.4 0.21])
plot_global_map_RF(lats, lons, delta_TOP_Koch, minvalue, maxvalue, '', 0, 0,'(d)')

t = title('Koch: TOP - PP');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);

hcb = colorbar;
hcb.Title.String = "W/m^2";
x = hcb.Position;
x(1) = 0.93;
%x(2) = 0.65;
%x(4) = 0.23;

hcb.Position = x;
hcb.FontSize = 12;


colors2 = flipud(brewermap(100, 'PRGN'));
maxvalue = 5;
minvalue = -5;


subplot('position', [0.04 0.08 0.4 0.21])
%histogram(FSA_shp2(:) - FSA_shp1(:), [-40:1:40])
plot_global_map_RF(lats, lons, delta_BC_Sphere, minvalue, maxvalue, '', 1, 1,'(e)')
colormap(gca,colors2)
t = title('BC(Sphere): Internal - External');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);

%ylabel({'Spring',''},'fontsize',12,'fontweight','bold')
subplot('position', [0.26 0.08 0.4 0.21])
plot_global_map_RF(lats, lons, delta_BC_Koch,  minvalue, maxvalue, '', 1, 0,'(f)')
colormap(gca,colors2)

%ylabel({'RF by BC',''},'fontsize',12)
t = title('BC(Koch): Internal - External');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);
subplot('position', [0.48 0.08 0.4 0.21])
plot_global_map_RF(lats, lons, delta_Dust_Sphere, minvalue, maxvalue, '', 1, 0,'(g)')
colormap(gca,colors2)
t = title('Dust(Sphere): Internal - External');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);


%ylabel({'RF by dust',''},'fontsize',12)
subplot('position', [0.70 0.08 0.21 0.4])
plot_global_map_RF(lats, lons, delta_Dust_Koch, minvalue, maxvalue, '', 1, 0,'(h)')
colormap(gca,colors2)

t = title('Dust(Koch): Internal - External');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);

hcb = colorbar;
hcb.Title.String = "W/m^2";
x = hcb.Position;
x(1) = 0.93;
%x(2) = 0.65;
%x(4) = 0.23;

hcb.Position = x;
hcb.FontSize = 12;

print(gcf, '-dtiff', '-r300',[ 'spatial_map/TOP_' Seasonname '_comparison.tif'])

close all


%% plot data
load('elevations_TP.mat');


filters = elevations >=1500 & SnowCovers_PP > 0.01;
TOPData = [elevations(filters) SnowCovers_PP(filters) delta_shape_Koch(filters) delta_BC_Sphere(filters)  delta_BC_Koch(filters) ...
    delta_Dust_Sphere(filters)  delta_Dust_Koch(filters)  delta_TOP_sphere(filters) ...
    delta_TOP_Koch(filters)  delta_combined(filters)];

save(['TOP/TOP_' Seasonname '.mat'], 'TOPData')
end