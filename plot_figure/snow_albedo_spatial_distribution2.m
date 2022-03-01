close all
clear all

load('IndusBasin.mat');

res_v = 0.125;
res_h = 0.125;
lon = (65+res_h/2):res_h: (108-res_h/2);
lat = (41-res_v/2):-res_v: (22 + res_v/2);
[lons,lats]=meshgrid(lon,lat);

load('elevations_TP.mat');
% DEM = mean_DEM_0125( ((90 - res_v/2 - (41 - res_v/2))/0.125 + 1): ((90 - res_v/2 - (22 + res_v/2))/0.125 + 1),...
%     ((65 + res_h/2 + 180 - res_h/2)/0.125 + 1): ((108 - res_h/2 + 180 - res_h/2)/0.125 + 1) );
%% get ELM data
for i = [2]
    switch i
        case 1
            Seasonname = 'Winter';
        case 2
            Seasonname = 'Spring';
        case 3
            Seasonname = 'Summer';
        case 4
            Seasonname = 'Autumn';
    end
    
    Data_shp1s = load(['ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_1_iBC_eDUST_' Seasonname '.mat']);
    Data_shp2s = load(['ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_2_iBC_eDUST_' Seasonname '.mat']);
    Data_shp3s = load(['ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_3_iBC_eDUST_' Seasonname '.mat']);
    Data_shp4s = load(['ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_4_iBC_eDUST_' Seasonname '.mat']);
    Data_BCs = load(['ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_1_eBC_eDUST_' Seasonname '.mat']);
    Data_dusts = load(['ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_1_eBC_iDUST_' Seasonname '.mat']);
    Data_BC_shp4s = load(['ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_4_eBC_eDUST_' Seasonname '.mat']);
    Data_dust_shp4s = load(['ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_4_eBC_iDUST_' Seasonname '.mat']);
    
    FSNO_shp1 = Data_shp1s.SnowCovers_all;
    FSNO_class = FSNO_shp1;
    
    FSNO_class(FSNO_shp1>0.0 & FSNO_shp1<0.2) = 0;
    FSNO_class(FSNO_shp1>=0.2 & FSNO_shp1<0.4) = 1;
    FSNO_class(FSNO_shp1>=0.4 & FSNO_shp1<0.6) = 2;
    FSNO_class(FSNO_shp1>=0.6 & FSNO_shp1<0.8) = 3;
    FSNO_class(FSNO_shp1>=0.8) = 4;
    
    %% snow
    %snow cover
    data_shp1 = Data_shp1s.SnowAlbedos_all;
    data_shp2 = Data_shp2s.SnowAlbedos_all;
    data_shp3 = Data_shp3s.SnowAlbedos_all;
    data_shp4 = Data_shp4s.SnowAlbedos_all;
    data_BC =  Data_BCs.SnowAlbedos_all;
    data_dust =  Data_dusts.SnowAlbedos_all;
    data_BC4 =  Data_BC_shp4s.SnowAlbedos_all;
    data_dust4 =  Data_dust_shp4s.SnowAlbedos_all;
    
    
    %% nan
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;  

    filters = elevations<=1500 | FSNO_shp1<0.01;
    difference_1(filters) = nan;
    difference_2(filters) = nan;
    difference_3(filters) = nan;
    difference_4(filters) = nan;
    difference_BC(filters) = nan;
    difference_dust(filters) = nan;
    difference_BC4(filters) = nan;
    difference_dust4(filters) = nan;
  
end
