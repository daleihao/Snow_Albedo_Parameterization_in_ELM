close all
clear all



%% get ELM data

i = 1;
switch i
    case 1
        seasonname = 'Winter';
    case 2
        seasonname = 'winter';
    case 3
        seasonname = 'Summer';
    case 4
        seasonname = 'Autumn';
end

load(['ELMData_Seasons/ELMBC_TP_snowshape_1_iBC_eDUST_' seasonname '.mat']);


%% classify data into bin


data = [SurfaceAlbedos_all LatentHeatFluxes_all SensibleHeatFluxes_all SurfaceTemperatures_all ];
save('boxplot_R/winter_SPIRES_ELM_v4.mat','data');

filters = ~isnan(SnowCovers_annual_MODSCAG) & SnowCovers_annual_MODSCAG>0;
SnowCovers = [SnowCovers_annual_ELM(filters) SnowCovers_annual_MODSCAG(filters) ];
deltaAlbedos = [deltaAlbedos_annual_ELM(filters) deltaAlbedos_annual_MODSCAG(filters)];
SnowAlbedos = [SnowAlbedos_annual_ELM(filters) SnowAlbedos_annual_MODSCAG(filters) ];
GrainSizes = [GrainSizes_annual_ELM(filters) GrainSizes_annual_MODSCAG(filters) ];
load('elevations_TP.mat');
elevation_band = elevations;
elevation_band(elevation_band<1500) = 0;
elevation_band(elevation_band >= 1500 & elevation_band<2500) = 1;
elevation_band(elevation_band >= 2500 & elevation_band<3500) = 2;
elevation_band(elevation_band >= 3500 & elevation_band<4500) = 3;
elevation_band(elevation_band >= 4500 & elevation_band<5500) = 4;
elevation_band(elevation_band >= 5500) = 5;

elevation_band = elevation_band(filters);
data = [elevation_band SnowCovers GrainSizes deltaAlbedos SnowAlbedos];
save('boxplot_R/winter_MODSCAG_ELM.mat','data')