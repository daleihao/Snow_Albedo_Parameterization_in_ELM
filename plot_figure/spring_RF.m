close all
clear all

load('IndusBasin.mat');

res_v = 0.125;
res_h = 0.125;
lon = (65+res_h/2):res_h: (108-res_h/2);
lat = (41-res_v/2):-res_v: (22 + res_v/2);
[lons,lats]=meshgrid(lon,lat);

radius = 6378137;
height = radius * 0.125*pi/180;
width1 = radius*cos(lats*pi/180) * 0.125*pi/180;
width2 = radius*(cos((lats-0.05)*pi/180)+cos((lats+0.05)*pi/180))/2 * 0.125*pi/180;
Area1 = width1.*height/1e6;
Area2 = width2.*height/1e6;


load('elevations_TP.mat');
% DEM = mean_DEM_0125( ((90 - res_v/2 - (41 - res_v/2))/0.125 + 1): ((90 - res_v/2 - (22 + res_v/2))/0.125 + 1),...
%     ((65 + res_h/2 + 180 - res_h/2)/0.125 + 1): ((108 - res_h/2 + 180 - res_h/2)/0.125 + 1) );
%% get ELM data
i = 1;
    switch i
        case 1
            seasonname = 'Winter';
        case 2
            seasonname = 'Spring';
        case 3
            seasonname = 'Summer';
        case 4
            seasonname = 'Autumn';
    end
    
    load(['ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_1_iBC_eDUST_' seasonname '.mat']);
        

AerosolForcings_all(elevations<=1500) = nan;
BCForcings_all(elevations<=1500) = nan;
DustForcings_all( elevations<=1500) = nan;

filter = ~isnan(AerosolForcings_all) & ~isnan(BCForcings_all) & ~isnan(DustForcings_all);
nansum(AerosolForcings_all(filter).*Area1(filter))/nansum(Area1(filter))
nansum(BCForcings_all(filter).*Area1(filter))/nansum(Area1(filter))
nansum(DustForcings_all(filter).*Area1(filter))/nansum(Area1(filter))

%% figue plot
figure;
set(gcf,'unit','normalized','position',[0.1,0.1,0.72,0.4]);
set(gca, 'Position', [0 0 1 1])
colors = flipud(brewermap(100, 'Spectral'));
colormap(colors)

subplot('position', [0.07 0.53 0.27 0.4])
%histogram(FSA_shp2(:) - FSA_shp1(:), [-40:1:40])
plot_global_map_RF(lats, lons, AerosolForcings_all, 0, 15, '', 0, 1,'(a)')

t = title('RF by all LAPs');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);

ylabel({'Winter',''},'fontsize',12,'fontweight','bold')
subplot('position', [0.35 0.53 0.27 0.4])
plot_global_map_RF(lats, lons, BCForcings_all, 0, 15, '', 0, 0,'(b)')

%ylabel({'RF by BC',''},'fontsize',12)
t = title('RF by BC');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);
subplot('position', [0.63 0.53 0.27 0.4])
plot_global_map_RF(lats, lons, DustForcings_all, 0, 15, '', 0, 0,'(c)')

%ylabel({'RF by dust',''},'fontsize',12)
t = title('RF by dust');
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

%% plot spring
%% get ELM data
i = 2;
    switch i
        case 1
            seasonname = 'Winter';
        case 2
            seasonname = 'Spring';
        case 3
            seasonname = 'Summer';
        case 4
            seasonname = 'Autumn';
    end
    
    load(['ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_1_iBC_eDUST_' seasonname '.mat']);
        

AerosolForcings_all(elevations<=1500) = nan;
BCForcings_all( elevations<=1500) = nan;
DustForcings_all( elevations<=1500) = nan;

filter =  ~isnan(AerosolForcings_all) & ~isnan(BCForcings_all) & ~isnan(DustForcings_all);
nansum(AerosolForcings_all(filter).*Area1(filter))/nansum(Area1(filter))
nansum(BCForcings_all(filter).*Area1(filter))/nansum(Area1(filter))
nansum(DustForcings_all(filter).*Area1(filter))/nansum(Area1(filter))

subplot('position', [0.07 0.08 0.27 0.4])
%histogram(FSA_shp2(:) - FSA_shp1(:), [-40:1:40])
plot_global_map_RF(lats, lons, AerosolForcings_all, 0, 15, '', 1, 1,'(d)')

% t = title('(d) RF by all Aerosols');
% set(t, 'horizontalAlignment', 'left');
% set(t, 'units', 'normalized');
% h1 = get(t, 'position');
% set(t, 'position', [0 h1(2) h1(3)]);

ylabel({'Spring',''},'fontsize',12,'fontweight','bold')
subplot('position', [0.35 0.08 0.27 0.4])
plot_global_map_RF(lats, lons, BCForcings_all, 0, 15, '', 1, 0,'(e)')

%ylabel({'RF by BC',''},'fontsize',12)
% t = title('(e) RF by BC');
% set(t, 'horizontalAlignment', 'left');
% set(t, 'units', 'normalized');
% h1 = get(t, 'position');
% set(t, 'position', [0 h1(2) h1(3)]);
subplot('position', [0.63 0.08 0.27 0.4])
plot_global_map_RF(lats, lons, DustForcings_all, 0, 15, '', 1, 0,'(f)')

%ylabel({'RF by dust',''},'fontsize',12)
% t = title('RF by dust');
% set(t, 'horizontalAlignment', 'left');
% set(t, 'units', 'normalized');
% h1 = get(t, 'position');
% set(t, 'position', [0 h1(2) h1(3)]);

hcb = colorbar;
hcb.Title.String = "W/m^2";
x = hcb.Position;
x(1) = 0.93;
%x(2) = 0.65;
%x(4) = 0.23;

hcb.Position = x;
hcb.FontSize = 12;

% %% snow cover
% figure;
print(gcf, '-dtiff', '-r300', ['spatial_map/model_RF_spring_winter_revise.tif'])

close all
