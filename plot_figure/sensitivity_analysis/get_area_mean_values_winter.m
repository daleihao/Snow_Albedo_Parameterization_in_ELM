
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

deltaAlbedos_annual_ELM(SnowCovers_annual_ELM<=0.01) = nan;
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

deltaAlbedos_annual_MODSCAG(SnowCovers_annual_MODSCAG<=0.01) = nan;

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

deltaAlbedos_annual_SPIRES(SnowCovers_annual_SPIRES<=0.01) = nan;



%% save data
load('elevations_TP.mat');
filters = IsIndusArea & SnowCovers_annual_SPIRES>=0 & SnowCovers_annual_MODSCAG>=0 & SnowCovers_annual_ELM>=0 & elevations>1500;

SnowCovers_filter = [SnowCovers_annual_ELM(filters) SnowCovers_annual_MODSCAG(filters) SnowCovers_annual_SPIRES(filters)];
deltaAlbedos_filter = [deltaAlbedos_annual_ELM(filters) deltaAlbedos_annual_MODSCAG(filters) deltaAlbedos_annual_SPIRES(filters)];
SnowAlbedos_filter = [SnowAlbedos_annual_ELM(filters) SnowAlbedos_annual_MODSCAG(filters) SnowAlbedos_annual_SPIRES(filters)];
GrainSizes_filter = [GrainSizes_annual_ELM(filters) GrainSizes_annual_MODSCAG(filters) GrainSizes_annual_SPIRES(filters)];

area_tmp = Area1(filters);

fsno_winter = nansum(SnowCovers_filter.*area_tmp)/nansum(area_tmp);
delta_albedo_winter = nansum(deltaAlbedos_filter.*area_tmp)/nansum(area_tmp);


