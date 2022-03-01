clear all;
close all
clc
res_v = 0.125;
res_h = 0.125;
lon = (65+res_h/2):res_h: (108-res_h/2);
lat = (41-res_v/2):-res_v: (22 + res_v/2);
[lons,lats]=meshgrid(lon,lat);

load('elevations_TP.mat');
%% read data
%FSNO_shp1s = load('ELMBC_TP_snowshape_1_iBC_eDUST.elm.h0.2000-02-01-00000.nc','FSNO');
for Season_i = {'Winter','Spring'}
    Seasonname = Season_i{1};
    Data_shp1s = load(['../ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_1_iBC_eDUST_' Seasonname '.mat']);
    Data_shp2s = load(['../ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_2_iBC_eDUST_' Seasonname '.mat']);
    Data_shp3s = load(['../ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_3_iBC_eDUST_' Seasonname '.mat']);
    Data_shp4s = load(['../ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_4_iBC_eDUST_' Seasonname '.mat']);
    Data_BCs = load(['../ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_1_eBC_eDUST_' Seasonname '.mat']);
    Data_dusts = load(['../ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_1_eBC_iDUST_' Seasonname '.mat']);
    Data_BC_shp4s = load(['../ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_4_eBC_eDUST_' Seasonname '.mat']);
    Data_dust_shp4s = load(['../ELM_Data_Season_11years/11years_ELMBC_TP_snowshape_4_eBC_iDUST_' Seasonname '.mat']);
    
    FSNO_shp1 = Data_shp1s.SnowCovers_all;
    FSNO_class = FSNO_shp1;
    
    FSNO_class(FSNO_shp1>0.0 & FSNO_shp1<0.2) = 0;
    FSNO_class(FSNO_shp1>=0.2 & FSNO_shp1<0.4) = 1;
    FSNO_class(FSNO_shp1>=0.4 & FSNO_shp1<0.6) = 2;
    FSNO_class(FSNO_shp1>=0.6 & FSNO_shp1<0.8) = 3;
    FSNO_class(FSNO_shp1>=0.8) = 4;
    
    %% snow
    %snow cover
    data_shp1 = Data_shp1s.SnowCovers_all;
    data_shp2 = Data_shp2s.SnowCovers_all;
    data_shp3 = Data_shp3s.SnowCovers_all;
    data_shp4 = Data_shp4s.SnowCovers_all;
    data_BC =  Data_BCs.SnowCovers_all;
    data_dust =  Data_dusts.SnowCovers_all;
    data_BC4 =  Data_BC_shp4s.SnowCovers_all;
    data_dust4 =  Data_dust_shp4s.SnowCovers_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    SnowcoverData = [elevations(:) FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    %snow albedo
    data_shp1 = Data_shp1s.SnowAlbedos_all;
    data_shp2 = Data_shp2s.SnowAlbedos_all;
    data_shp3 = Data_shp3s.SnowAlbedos_all;
    data_shp4 = Data_shp4s.SnowAlbedos_all;
    data_BC =  Data_BCs.SnowAlbedos_all;
    data_dust =  Data_dusts.SnowAlbedos_all;
    data_BC4 =  Data_BC_shp4s.SnowAlbedos_all;
    data_dust4 =  Data_dust_shp4s.SnowAlbedos_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    SnowalbedoData = [elevations(:) FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    %SWE
    data_shp1 = Data_shp1s.SWEs_all;
    data_shp2 = Data_shp2s.SWEs_all;
    data_shp3 = Data_shp3s.SWEs_all;
    data_shp4 = Data_shp4s.SWEs_all;
    data_BC =  Data_BCs.SWEs_all;
    data_dust =  Data_dusts.SWEs_all;
    data_BC4 =  Data_BC_shp4s.SWEs_all;
    data_dust4 =  Data_dust_shp4s.SWEs_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    SWEData = [elevations(:)  FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    
    %snow depth
    data_shp1 = Data_shp1s.SnowDepths_all;
    data_shp2 = Data_shp2s.SnowDepths_all;
    data_shp3 = Data_shp3s.SnowDepths_all;
    data_shp4 = Data_shp4s.SnowDepths_all;
    data_BC =  Data_BCs.SnowDepths_all;
    data_dust =  Data_dusts.SnowDepths_all;
    data_BC4 =  Data_BC_shp4s.SnowDepths_all;
    data_dust4 =  Data_dust_shp4s.SnowDepths_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    SnowdepthData = [elevations(:)  FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    %grain size
    data_shp1 = Data_shp1s.GrainSizes_all;
    data_shp2 = Data_shp2s.GrainSizes_all;
    data_shp3 = Data_shp3s.GrainSizes_all;
    data_shp4 = Data_shp4s.GrainSizes_all;
    data_BC =  Data_BCs.GrainSizes_all;
    data_dust =  Data_dusts.GrainSizes_all;
    data_BC4 =  Data_BC_shp4s.GrainSizes_all;
    data_dust4 =  Data_dust_shp4s.GrainSizes_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    SnowgrainsizeData = [elevations(:) FSNO_shp1(:)  FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    %snow albedo change
    data_shp1 = Data_shp1s.deltaAlbedos_all;
    data_shp2 = Data_shp2s.deltaAlbedos_all;
    data_shp3 = Data_shp3s.deltaAlbedos_all;
    data_shp4 = Data_shp4s.deltaAlbedos_all;
    data_BC =  Data_BCs.deltaAlbedos_all;
    data_dust =  Data_dusts.deltaAlbedos_all;
    data_BC4 =  Data_BC_shp4s.deltaAlbedos_all;
    data_dust4 =  Data_dust_shp4s.deltaAlbedos_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    DeltasnowalbedoData = [elevations(:) FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    %delta BC
    data_shp1 = Data_shp1s.deltaAlbedosByBCs_all;
    data_shp2 = Data_shp2s.deltaAlbedosByBCs_all;
    data_shp3 = Data_shp3s.deltaAlbedosByBCs_all;
    data_shp4 = Data_shp4s.deltaAlbedosByBCs_all;
    data_BC =  Data_BCs.deltaAlbedosByBCs_all;
    data_dust =  Data_dusts.deltaAlbedosByBCs_all;
    data_BC4 =  Data_BC_shp4s.deltaAlbedosByBCs_all;
    data_dust4 =  Data_dust_shp4s.deltaAlbedosByBCs_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    DeltasnowalbedobyBCData = [elevations(:) FSNO_shp1(:)  FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    %snow albedo change
    data_shp1 = Data_shp1s.deltaAlbedosByDusts_all;
    data_shp2 = Data_shp2s.deltaAlbedosByDusts_all;
    data_shp3 = Data_shp3s.deltaAlbedosByDusts_all;
    data_shp4 = Data_shp4s.deltaAlbedosByDusts_all;
    data_BC =  Data_BCs.deltaAlbedosByDusts_all;
    data_dust =  Data_dusts.deltaAlbedosByDusts_all;
    data_BC4 =  Data_BC_shp4s.deltaAlbedosByDusts_all;
    data_dust4 =  Data_dust_shp4s.deltaAlbedosByDusts_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    DeltasnowalbedobydustData = [elevations(:) FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    
    %% radiative forcing
    %all aaerosol
    data_shp1 = Data_shp1s.AerosolForcings_all;
    data_shp2 = Data_shp2s.AerosolForcings_all;
    data_shp3 = Data_shp3s.AerosolForcings_all;
    data_shp4 = Data_shp4s.AerosolForcings_all;
    data_BC =  Data_BCs.AerosolForcings_all;
    data_dust =  Data_dusts.AerosolForcings_all;
    data_BC4 =  Data_BC_shp4s.AerosolForcings_all;
    data_dust4 =  Data_dust_shp4s.AerosolForcings_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    AerosolRFData = [elevations(:) FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    %BC forcing
    data_shp1 = Data_shp1s.BCForcings_all;
    data_shp2 = Data_shp2s.BCForcings_all;
    data_shp3 = Data_shp3s.BCForcings_all;
    data_shp4 = Data_shp4s.BCForcings_all;
    data_BC =  Data_BCs.BCForcings_all;
    data_dust =  Data_dusts.BCForcings_all;
    data_BC4 =  Data_BC_shp4s.BCForcings_all;
    data_dust4 =  Data_dust_shp4s.BCForcings_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    BCRFData = [elevations(:) FSNO_shp1(:)  FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    %SH
    data_shp1 = Data_shp1s.DustForcings_all;
    data_shp2 = Data_shp2s.DustForcings_all;
    data_shp3 = Data_shp3s.DustForcings_all;
    data_shp4 = Data_shp4s.DustForcings_all;
    data_BC =  Data_BCs.DustForcings_all;
    data_dust =  Data_dusts.DustForcings_all;
    data_BC4 =  Data_BC_shp4s.DustForcings_all;
    data_dust4 =  Data_dust_shp4s.DustForcings_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    DustRFData = [elevations(:) FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    %% energy cycle W/m2
    %FSA
    data_shp1 = Data_shp1s.NetSolarRadiations_all;
    data_shp2 = Data_shp2s.NetSolarRadiations_all;
    data_shp3 = Data_shp3s.NetSolarRadiations_all;
    data_shp4 = Data_shp4s.NetSolarRadiations_all;
    data_BC =  Data_BCs.NetSolarRadiations_all;
    data_dust =  Data_dusts.NetSolarRadiations_all;
    data_BC4 =  Data_BC_shp4s.NetSolarRadiations_all;
    data_dust4 =  Data_dust_shp4s.NetSolarRadiations_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    FSAData = [elevations(:) FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    %LH
    data_shp1 = Data_shp1s.LatentHeatFluxes_all;
    data_shp2 = Data_shp2s.LatentHeatFluxes_all;
    data_shp3 = Data_shp3s.LatentHeatFluxes_all;
    data_shp4 = Data_shp4s.LatentHeatFluxes_all;
    data_BC =  Data_BCs.LatentHeatFluxes_all;
    data_dust =  Data_dusts.LatentHeatFluxes_all;
    data_BC4 =  Data_BC_shp4s.LatentHeatFluxes_all;
    data_dust4 =  Data_dust_shp4s.LatentHeatFluxes_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    LHData = [elevations(:) FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    %SH
    data_shp1 = Data_shp1s.SensibleHeatFluxes_all;
    data_shp2 = Data_shp2s.SensibleHeatFluxes_all;
    data_shp3 = Data_shp3s.SensibleHeatFluxes_all;
    data_shp4 = Data_shp4s.SensibleHeatFluxes_all;
    data_BC =  Data_BCs.SensibleHeatFluxes_all;
    data_dust =  Data_dusts.SensibleHeatFluxes_all;
    data_BC4 =  Data_BC_shp4s.SensibleHeatFluxes_all;
    data_dust4 =  Data_dust_shp4s.SensibleHeatFluxes_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    SHData = [elevations(:) FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    % surface albedo
    data_shp1 = Data_shp1s.SurfaceAlbedos_all;
    data_shp2 = Data_shp2s.SurfaceAlbedos_all;
    data_shp3 = Data_shp3s.SurfaceAlbedos_all;
    data_shp4 = Data_shp4s.SurfaceAlbedos_all;
    data_BC =  Data_BCs.SurfaceAlbedos_all;
    data_dust =  Data_dusts.SurfaceAlbedos_all;
    data_BC4 =  Data_BC_shp4s.SurfaceAlbedos_all;
    data_dust4 =  Data_dust_shp4s.SurfaceAlbedos_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    SurfacealbedoData = [elevations(:) FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    % surface teperature
    data_shp1 = Data_shp1s.SurfaceTemperatures_all;
    data_shp2 = Data_shp2s.SurfaceTemperatures_all;
    data_shp3 = Data_shp3s.SurfaceTemperatures_all;
    data_shp4 = Data_shp4s.SurfaceTemperatures_all;
    data_BC =  Data_BCs.SurfaceTemperatures_all;
    data_dust =  Data_dusts.SurfaceTemperatures_all;
    data_BC4 =  Data_BC_shp4s.SurfaceTemperatures_all;
    data_dust4 =  Data_dust_shp4s.SurfaceTemperatures_all;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    SurfacetemperatureData = [elevations(:) FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    %% hydrological cycle mm d
    % real(R8),parameter :: SHR_CONST_LATVAP  = 2.501e6_R8      ! latent heat of evaporation ~ J/kg
    conversion_constant = 3600*24/2.501e6;
    data_shp1 = Data_shp1s.LatentHeatFluxes_all*conversion_constant;
    data_shp2 = Data_shp2s.LatentHeatFluxes_all*conversion_constant;
    data_shp3 = Data_shp3s.LatentHeatFluxes_all*conversion_constant;
    data_shp4 = Data_shp4s.LatentHeatFluxes_all*conversion_constant;
    data_BC =  Data_BCs.LatentHeatFluxes_all*conversion_constant;
    data_dust =  Data_dusts.LatentHeatFluxes_all*conversion_constant;
    data_BC4 =  Data_BC_shp4s.LatentHeatFluxes_all*conversion_constant;
    data_dust4 =  Data_dust_shp4s.LatentHeatFluxes_all*conversion_constant;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    ETData = [elevations(:) FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    % runoff
    conversion_constant = 3600*24;
    
    data_shp1 = Data_shp1s.Runoffs_all*conversion_constant;
    data_shp2 = Data_shp2s.Runoffs_all*conversion_constant;
    data_shp3 = Data_shp3s.Runoffs_all*conversion_constant;
    data_shp4 = Data_shp4s.Runoffs_all*conversion_constant;
    data_BC =  Data_BCs.Runoffs_all*conversion_constant;
    data_dust =  Data_dusts.Runoffs_all*conversion_constant;
    data_BC4 =  Data_BC_shp4s.Runoffs_all*conversion_constant;
    data_dust4 =  Data_dust_shp4s.Runoffs_all*conversion_constant;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    RunoffData = [elevations(:) FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    % snowmelt
    conversion_constant = 3600*24;
    
    data_shp1 = Data_shp1s.SnowMelts_all*conversion_constant;
    data_shp2 = Data_shp2s.SnowMelts_all*conversion_constant;
    data_shp3 = Data_shp3s.SnowMelts_all*conversion_constant;
    data_shp4 = Data_shp4s.SnowMelts_all*conversion_constant;
    data_BC =  Data_BCs.SnowMelts_all*conversion_constant;
    data_dust =  Data_dusts.SnowMelts_all*conversion_constant;
    data_BC4 =  Data_BC_shp4s.SnowMelts_all*conversion_constant;
    data_dust4 =  Data_dust_shp4s.SnowMelts_all*conversion_constant;
    
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;
    
    SnowmeltData = [elevations(:) FSNO_shp1(:) FSNO_class(:) difference_1(:) difference_2(:) difference_3(:) difference_4(:) difference_BC(:) difference_dust(:) difference_BC4(:) difference_dust4(:)];
    
    %% save data
    save(['all_data_' Seasonname '.mat'],'SnowalbedoData','SnowcoverData','SWEData','SnowdepthData','SnowgrainsizeData',...
        'DeltasnowalbedoData','DeltasnowalbedobyBCData','DeltasnowalbedobydustData',...
        'AerosolRFData','BCRFData','DustRFData',...
        'FSAData','LHData','SHData','SurfacealbedoData','SurfacetemperatureData',...
        'ETData','RunoffData','SnowmeltData'...
        );
end
