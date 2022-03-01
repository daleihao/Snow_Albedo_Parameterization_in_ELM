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
GrainSizes_annual = nan(152, 344, 4);
SnowAlbedos_annual = nan(152, 344, 4);
SnowCovers_annual = nan(152, 344, 4);
deltaAlbedos_annual = nan(152, 344, 4);
AerosolForings_annual = nan(152, 344, 4);

for i = 1
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
    
    load(['ELM_Data_Season_11years_match_MODIS/Match_MOD_11years_ELMBC_TP_snowshape_1_iBC_eDUST_' seasonname '.mat']);
    
    
    GrainSizes_annual(:,:,i) = GrainSizes_all;
    SnowAlbedos_annual(:,:,i) = SnowAlbedos_all;
    SnowCovers_annual(:,:,i) = SnowCovers_all;
    deltaAlbedos_annual(:,:,i) = deltaAlbedos_all;
    %AerosolForings_annual(:,:,i) = AerosolForcings_all;
    
end

GrainSizes_annual_ELM = nanmean(GrainSizes_annual, 3);
SnowAlbedos_annual_ELM = nanmean(SnowAlbedos_annual, 3);
SnowCovers_annual_ELM = nanmean(SnowCovers_annual, 3);
deltaAlbedos_annual_ELM = nanmean(deltaAlbedos_annual, 3);
%AerosolForings_annual_ELM = nanmean(AerosolForings_annual, 3);

%deltaAlbedos_annual_ELM(SnowCovers_annual_ELM<=0.01) = nan;
%% get MODISACG data
files = dir('MODIS/modscag/MODSCAG_*v5.mat');
num = size(files, 1);

GrainSizes_annual = nan(152, 344, num);
SnowCovers_annual = nan(152, 344, num);
deltaAlbedos_annual = nan(152, 344, num);
SnowAlbedos_annual = nan(152, 344, num);
for i = 1:num
    
    filename_i = files(i).name;
    substrs = split(filename_i, '_');
    year_i = str2num(substrs{2});
    month_i = str2num(substrs{3});
    if(year_i <=2000 | year_i>2010 | ~(month_i<3 | month_i==12))
        continue;
    end
    load(['MODIS/modscag/' files(i).name]);
    
%     grainsizes_TP(fsnos_TP<=0.01) = nan;
%     deltaAlbedos_TP(fsnos_TP<=0.01) = nan;
%     snowAlbedos_TP(fsnos_TP<=0.01) = nan;
    
    GrainSizes_annual(:,:,i) = grainsizes_TP;
    SnowCovers_annual(:,:,i) = fsnos_TP;
    deltaAlbedos_annual(:,:,i) = deltaAlbedos_TP;
    SnowAlbedos_annual(:,:,i) = snowAlbedos_TP;
end

GrainSizes_annual_MODSCAG = nanmean(GrainSizes_annual, 3);
SnowCovers_annual_MODSCAG = nanmean(SnowCovers_annual, 3);
deltaAlbedos_annual_MODSCAG = nanmean(deltaAlbedos_annual, 3);
SnowAlbedos_annual_MODSCAG= nanmean(SnowAlbedos_annual, 3);

%deltaAlbedos_annual_MODSCAG(SnowCovers_annual_MODSCAG<=0.01) = nan;

%% get MODIS SPIRES
files = dir('MODIS/spires/SPIRES_*.mat');
num = size(files, 1);

GrainSizes_annual = nan(152, 344, num);
SnowCovers_annual = nan(152, 344, num);
deltaAlbedos_annual = nan(152, 344, num);
SnowAlbedos_annual = nan(152, 344, num);

for i = 1:num
    
     filename_i = files(i).name;
    substrs = split(filename_i, '_');
    year_i = str2num(substrs{2});
    month_i = str2num(substrs{3});
    if(year_i <=2000 | year_i>2010 | ~(month_i<3 | month_i==12))
        continue;
    end
    
    load(['MODIS/spires/' files(i).name]);
    
%     grainsizes_TP(fsnos_TP<=0) = nan;
%     deltaAlbedos_TP(fsnos_TP<=0) = nan;
%     snowAlbedos_TP(fsnos_TP<=0) = nan;
    
    GrainSizes_annual(:,:,i) = grainsizes_TP;
    SnowCovers_annual(:,:,i) = fsnos_TP;
    SnowAlbedos_annual(:,:,i) = snowAlbedos_TP;
    
    deltaAlbedos_annual(:,:,i) = deltaAlbedos_TP;
end

GrainSizes_annual_SPIRES = nanmean(GrainSizes_annual, 3);
SnowCovers_annual_SPIRES = nanmean(SnowCovers_annual, 3);
deltaAlbedos_annual_SPIRES = nanmean(deltaAlbedos_annual, 3);
SnowAlbedos_annual_SPIRES = nanmean(SnowAlbedos_annual, 3);

%deltaAlbedos_annual_SPIRES(SnowCovers_annual_SPIRES<=0.01) = nan;


%% for spring
%% get ELM data
GrainSizes_annual = nan(152, 344, 4);
SnowAlbedos_annual = nan(152, 344, 4);
SnowCovers_annual = nan(152, 344, 4);
deltaAlbedos_annual = nan(152, 344, 4);
AerosolForings_annual = nan(152, 344, 4);

for i = 2
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
    
    load(['ELM_Data_Season_11years_match_MODIS/Match_MOD_11years_ELMBC_TP_snowshape_1_iBC_eDUST_' seasonname '.mat']);
    
    
    GrainSizes_annual(:,:,i) = GrainSizes_all;
    SnowAlbedos_annual(:,:,i) = SnowAlbedos_all;
    SnowCovers_annual(:,:,i) = SnowCovers_all;
    deltaAlbedos_annual(:,:,i) = deltaAlbedos_all;
    %AerosolForings_annual(:,:,i) = AerosolForcings_all;
    
end

GrainSizes_annual_ELM_spr = nanmean(GrainSizes_annual, 3);
SnowAlbedos_annual_ELM_spr = nanmean(SnowAlbedos_annual, 3);
SnowCovers_annual_ELM_spr = nanmean(SnowCovers_annual, 3);
deltaAlbedos_annual_ELM_spr = nanmean(deltaAlbedos_annual, 3);
%AerosolForings_annual_ELM = nanmean(AerosolForings_annual, 3);

%deltaAlbedos_annual_ELM_spr(SnowCovers_annual_ELM_spr<=0.01) = nan;
%% get MODISACG data
files = dir('MODIS/modscag/MODSCAG_*v5.mat');
num = size(files, 1);

GrainSizes_annual = nan(152, 344, num);
SnowCovers_annual = nan(152, 344, num);
deltaAlbedos_annual = nan(152, 344, num);
SnowAlbedos_annual = nan(152, 344, num);
for i = 1:num
    
    filename_i = files(i).name;
    substrs = split(filename_i, '_');
    year_i = str2num(substrs{2});
    month_i = str2num(substrs{3});
    if(year_i <=2000 | year_i>2010 | ~(month_i>2 & month_i<6))
        continue;
    end
    load(['MODIS/modscag/' files(i).name]);
    
%     grainsizes_TP(fsnos_TP<=0) = nan;
%     deltaAlbedos_TP(fsnos_TP<=0) = nan;
%     snowAlbedos_TP(fsnos_TP<=0) = nan;
%     
    GrainSizes_annual(:,:,i) = grainsizes_TP;
    SnowCovers_annual(:,:,i) = fsnos_TP;
    deltaAlbedos_annual(:,:,i) = deltaAlbedos_TP;
    SnowAlbedos_annual(:,:,i) = snowAlbedos_TP;
end

GrainSizes_annual_MODSCAG_spr = nanmean(GrainSizes_annual, 3);
SnowCovers_annual_MODSCAG_spr = nanmean(SnowCovers_annual, 3);
deltaAlbedos_annual_MODSCAG_spr = nanmean(deltaAlbedos_annual, 3);
SnowAlbedos_annual_MODSCAG_spr= nanmean(SnowAlbedos_annual, 3);

%deltaAlbedos_annual_MODSCAG_spr(SnowCovers_annual_MODSCAG_spr<=0.01) = nan;

%% get MODIS SPIRES
files = dir('MODIS/spires/SPIRES_*.mat');
num = size(files, 1);

GrainSizes_annual = nan(152, 344, num);
SnowCovers_annual = nan(152, 344, num);
deltaAlbedos_annual = nan(152, 344, num);
SnowAlbedos_annual = nan(152, 344, num);

for i = 1:num
    
     filename_i = files(i).name;
    substrs = split(filename_i, '_');
    year_i = str2num(substrs{2});
    month_i = str2num(substrs{3});
    if(year_i <=2000 | year_i>2010 | ~(month_i>2 & month_i<6))
        continue;
    end
    
    load(['MODIS/spires/' files(i).name]);
    
%     grainsizes_TP(fsnos_TP<=0) = nan;
%     deltaAlbedos_TP(fsnos_TP<=0) = nan;
%     snowAlbedos_TP(fsnos_TP<=0) = nan;
    
    GrainSizes_annual(:,:,i) = grainsizes_TP;
    SnowCovers_annual(:,:,i) = fsnos_TP;
    SnowAlbedos_annual(:,:,i) = snowAlbedos_TP;
    
    deltaAlbedos_annual(:,:,i) = deltaAlbedos_TP;
end

GrainSizes_annual_SPIRES_spr = nanmean(GrainSizes_annual, 3);
SnowCovers_annual_SPIRES_spr = nanmean(SnowCovers_annual, 3);
deltaAlbedos_annual_SPIRES_spr = nanmean(deltaAlbedos_annual, 3);
SnowAlbedos_annual_SPIRES_spr = nanmean(SnowAlbedos_annual, 3);

%deltaAlbedos_annual_SPIRES_spr(SnowCovers_annual_SPIRES_spr<=0.01) = nan;


%% figue plot
figure;
set(gcf,'unit','normalized','position',[0.1,0.1,0.72,0.43]);
set(gca, 'Position', [0 0 1 1])
colors = (brewermap(100, 'Greens'));
colormap(colors)

% MODIS
subplot('position', [0.07 0.49 0.27 0.4])
%histogram(FSA_shp2(:) - FSA_shp1(:), [-40:1:40])
plot_global_map(lats, lons, SnowCovers_annual_ELM, 0, 1, 'ELM', 0, 1,'(a)')

ylabel({'Winter',''},'fontsize',10,'fontweight','bold')

subplot('position', [0.07 0.08 0.27 0.4])
plot_global_map(lats, lons, SnowCovers_annual_ELM_spr, 0, 1, '', 1, 1,'(d)')

ylabel({'Spring',''},'fontsize',10,'fontweight','bold')

% MODSCAG
subplot('position', [0.35 0.49 0.27 0.4])
%histogram(FSA_shp2(:) - FSA_shp1(:), [-40:1:40])
plot_global_map(lats, lons, SnowCovers_annual_MODSCAG, 0, 1, 'MODSCAG/MODDRFS', 0, 0,'(b)')


subplot('position', [0.35 0.08 0.27 0.4])
plot_global_map(lats, lons, SnowCovers_annual_MODSCAG_spr, 0, 1, '', 1, 0,'(e)')

% SPIRES
subplot('position', [0.63 0.49 0.27 0.4])
%histogram(FSA_shp2(:) - FSA_shp1(:), [-40:1:40])
plot_global_map(lats, lons, SnowCovers_annual_SPIRES, 0, 1, 'SPIReS', 0, 0,'(c)')
hcb = colorbar;
hcb.Title.String = "Unitless";
x = hcb.Position;
x(1) = 0.93;
x(2) = 0.52;
x(4) = 0.3;

hcb.Position = x;
hcb.FontSize = 12;

subplot('position', [0.63 0.08 0.27 0.4])
plot_global_map(lats, lons, SnowCovers_annual_SPIRES_spr, 0, 1, '', 1, 0,'(f)')
hcb = colorbar;
hcb.Title.String = "Unitless";
x = hcb.Position;
x(1) = 0.93;
x(2) = 0.10;
x(4) = 0.3;

hcb.Position = x;
hcb.FontSize = 12;




% %% snow cover
% figure;
print(gcf, '-dtiff', '-r300', 'spatial_map/elm_modis_fsno_comparison.tif')


%% figue plot
figure;
set(gcf,'unit','normalized','position',[0.1,0.1,0.72,0.43]);
set(gca, 'Position', [0 0 1 1])
colors = (brewermap(100, 'Greens'));
colormap(colors)

% MODIS
subplot('position', [0.07 0.49 0.27 0.4])
%histogram(FSA_shp2(:) - FSA_shp1(:), [-40:1:40])
plot_global_map(lats, lons, deltaAlbedos_annual_ELM, 0, 0.1, 'ELM', 0, 1,'(a)')

ylabel({'Winter',''},'fontsize',10,'fontweight','bold')

subplot('position', [0.07 0.08 0.27 0.4])
plot_global_map(lats, lons, deltaAlbedos_annual_ELM_spr, 0, 0.1, '', 1, 1,'(d)')

ylabel({'Spring',''},'fontsize',10,'fontweight','bold')

% MODSCAG
subplot('position', [0.35 0.49 0.27 0.4])
%histogram(FSA_shp2(:) - FSA_shp1(:), [-40:1:40])
plot_global_map(lats, lons, deltaAlbedos_annual_MODSCAG, 0, 0.1, 'MODSCAG/MODDRFS', 0, 0,'(b)')


subplot('position', [0.35 0.08 0.27 0.4])
plot_global_map(lats, lons, deltaAlbedos_annual_MODSCAG_spr, 0, 0.1, '', 1, 0,'(e)')

% SPIRES
subplot('position', [0.63 0.49 0.27 0.4])
%histogram(FSA_shp2(:) - FSA_shp1(:), [-40:1:40])
plot_global_map(lats, lons, deltaAlbedos_annual_SPIRES, 0, 0.1, 'SPIReS', 0, 0,'(c)')
hcb = colorbar;
hcb.Title.String = "Unitless";
x = hcb.Position;
x(1) = 0.93;
x(2) = 0.52;
x(4) = 0.3;

hcb.Position = x;
hcb.FontSize = 12;

subplot('position', [0.63 0.08 0.27 0.4])
plot_global_map(lats, lons, deltaAlbedos_annual_SPIRES_spr, 0, 0.1, '', 1, 0,'(f)')
hcb = colorbar;
hcb.Title.String = "Unitless";
x = hcb.Position;
x(1) = 0.93;
x(2) = 0.10;
x(4) = 0.3;

hcb.Position = x;
hcb.FontSize = 12;




% %% snow cover
% figure;
print(gcf, '-dtiff', '-r300', 'spatial_map/elm_modis_sar_comparison.tif')

close all


