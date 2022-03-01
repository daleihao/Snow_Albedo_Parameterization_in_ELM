close all
clear all

load('IndusBasin.mat');

res_v = 0.125;
res_h = 0.125;
lon = (65+res_h/2):res_h: (108-res_h/2);
lat = (41-res_v/2):-res_v: (22 + res_v/2);
[lons,lats]=meshgrid(lon,lat);


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
        

deltaAlbedos_all(SnowCovers_all<=0.01) = nan;
deltaAlbedosByBCs_all(SnowCovers_all<=0.01) = nan;
deltaAlbedosByDusts_all(SnowCovers_all<=0.01) = nan;

%% figue plot
figure;
set(gcf,'unit','normalized','position',[0.1,0.1,0.72,0.4]);
set(gca, 'Position', [0 0 1 1])
colors = flipud(brewermap(100, 'Spectral'));
colormap(colors)

subplot('position', [0.07 0.53 0.27 0.4])
%histogram(FSA_shp2(:) - FSA_shp1(:), [-40:1:40])
plot_global_map_RF(lats, lons, deltaAlbedos_all, 0, 0.1, '', 0, 1,'(a)')

t = title('RF by all LAPs');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);

ylabel({'Winter',''},'fontsize',12,'fontweight','bold')
subplot('position', [0.35 0.53 0.27 0.4])
plot_global_map_RF(lats, lons, deltaAlbedosByBCs_all, 0, 0.1, '', 0, 0,'(b)')

%ylabel({'RF by BC',''},'fontsize',12)
t = title('RF by BC');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);
subplot('position', [0.63 0.53 0.27 0.4])
plot_global_map_RF(lats, lons, deltaAlbedosByDusts_all, 0, 0.1, '', 0, 0,'(c)')

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
        

deltaAlbedos_all(SnowCovers_all<=0.01) = nan;
deltaAlbedosByBCs_all(SnowCovers_all<=0.01) = nan;
deltaAlbedosByDusts_all(SnowCovers_all<=0.01) = nan;


subplot('position', [0.07 0.08 0.27 0.4])
%histogram(FSA_shp2(:) - FSA_shp1(:), [-40:1:40])
plot_global_map_RF(lats, lons, deltaAlbedos_all, 0, 0.1, '', 1, 1,'(d)')

% t = title('(d) RF by all Aerosols');
% set(t, 'horizontalAlignment', 'left');
% set(t, 'units', 'normalized');
% h1 = get(t, 'position');
% set(t, 'position', [0 h1(2) h1(3)]);

ylabel({'Spring',''},'fontsize',12,'fontweight','bold')
subplot('position', [0.35 0.08 0.27 0.4])
plot_global_map_RF(lats, lons, deltaAlbedosByBCs_all, 0, 0.1, '', 1, 0,'(e)')

%ylabel({'RF by BC',''},'fontsize',12)
% t = title('(e) RF by BC');
% set(t, 'horizontalAlignment', 'left');
% set(t, 'units', 'normalized');
% h1 = get(t, 'position');
% set(t, 'position', [0 h1(2) h1(3)]);
subplot('position', [0.63 0.08 0.27 0.4])
plot_global_map_RF(lats, lons, deltaAlbedosByDusts_all, 0, 0.1, '', 1, 0,'(f)')

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

elevations2 = elevations;
elevations2(elevations<4000) = nan;
figure;
subplot(121)
plot_global_map_RF(lats, lons, deltaAlbedosByDusts_all./(deltaAlbedos_all), 0, 0.5, '', 1, 0,'(f)')
subplot(122)
plot_global_map_RF(lats, lons, elevations2, 0,6000, '', 1, 0,'(f)')

% %% snow cover
% figure;
print(gcf, '-dtiff', '-r300', ['spatial_map/model_SAR_spring_winter.tif'])

close all
