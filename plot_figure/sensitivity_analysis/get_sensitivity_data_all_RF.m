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
        
    SnowcoverData = [elevations(:) FSNO_shp1(:) FSNO_class(:) data_shp1(:) data_shp2(:) data_shp3(:) data_shp4(:) ...
        data_BC(:) data_dust(:) data_BC4(:) data_dust4(:)];
       
   
    %snow albedo change
    data_shp1 = Data_shp1s.SnowAlbedos_all;
    data_shp2 = Data_shp2s.SnowAlbedos_all;
    data_shp3 = Data_shp3s.SnowAlbedos_all;
    data_shp4 = Data_shp4s.SnowAlbedos_all;
    data_BC =  Data_BCs.SnowAlbedos_all;
    data_dust =  Data_dusts.SnowAlbedos_all;
    data_BC4 =  Data_BC_shp4s.SnowAlbedos_all;
    data_dust4 =  Data_dust_shp4s.SnowAlbedos_all;
    
    
    SnowalbedoData = [elevations(:) FSNO_shp1(:) FSNO_class(:) data_shp1(:) data_shp2(:) data_shp3(:) data_shp4(:) ...
        data_BC(:) data_dust(:) data_BC4(:) data_dust4(:)];
    
    %snow albedo change
    data_shp1 = Data_shp1s.deltaAlbedos_all;
    data_shp2 = Data_shp2s.deltaAlbedos_all;
    data_shp3 = Data_shp3s.deltaAlbedos_all;
    data_shp4 = Data_shp4s.deltaAlbedos_all;
    data_BC =  Data_BCs.deltaAlbedos_all;
    data_dust =  Data_dusts.deltaAlbedos_all;
    data_BC4 =  Data_BC_shp4s.deltaAlbedos_all;
    data_dust4 =  Data_dust_shp4s.deltaAlbedos_all;
    
    
            filter =  FSNO_shp1>=0.5;
        disp('aaaaaaaaa')
    nanmean(data_shp1(filter))
    nanmean(data_shp2(filter))
    nanmean(data_shp3(filter))
    nanmean(data_shp4(filter))
    nanmean(data_BC(filter))
    nanmean(data_dust(filter))
    nanmean(data_BC4(filter))
    nanmean(data_dust4(filter))
 


    
    DeltasnowalbedoData = [elevations(:) FSNO_shp1(:) FSNO_class(:) data_shp1(:) data_shp2(:) data_shp3(:) data_shp4(:) ...
        data_BC(:) data_dust(:) data_BC4(:) data_dust4(:)];
       
    %delta BC
    data_shp1 = Data_shp1s.deltaAlbedosByBCs_all;
    data_shp2 = Data_shp2s.deltaAlbedosByBCs_all;
    data_shp3 = Data_shp3s.deltaAlbedosByBCs_all;
    data_shp4 = Data_shp4s.deltaAlbedosByBCs_all;
    data_BC =  Data_BCs.deltaAlbedosByBCs_all;
    data_dust =  Data_dusts.deltaAlbedosByBCs_all;
    data_BC4 =  Data_BC_shp4s.deltaAlbedosByBCs_all;
    data_dust4 =  Data_dust_shp4s.deltaAlbedosByBCs_all;
    
    
    DeltasnowalbedobyBCData = [elevations(:) FSNO_shp1(:) FSNO_class(:) data_shp1(:) data_shp2(:) data_shp3(:) data_shp4(:) ...
        data_BC(:) data_dust(:) data_BC4(:) data_dust4(:)];
       
    %snow albedo change
    data_shp1 = Data_shp1s.deltaAlbedosByDusts_all;
    data_shp2 = Data_shp2s.deltaAlbedosByDusts_all;
    data_shp3 = Data_shp3s.deltaAlbedosByDusts_all;
    data_shp4 = Data_shp4s.deltaAlbedosByDusts_all;
    data_BC =  Data_BCs.deltaAlbedosByDusts_all;
    data_dust =  Data_dusts.deltaAlbedosByDusts_all;
    data_BC4 =  Data_BC_shp4s.deltaAlbedosByDusts_all;
    data_dust4 =  Data_dust_shp4s.deltaAlbedosByDusts_all;
    
    DeltasnowalbedobydustData = [elevations(:) FSNO_shp1(:) FSNO_class(:) data_shp1(:) data_shp2(:) data_shp3(:) data_shp4(:) ...
        data_BC(:) data_dust(:) data_BC4(:) data_dust4(:)];
       
    
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
    
    
    AerosolRFData = [elevations(:) FSNO_shp1(:) FSNO_class(:) data_shp1(:) data_shp2(:) data_shp3(:) data_shp4(:) ...
        data_BC(:) data_dust(:) data_BC4(:) data_dust4(:)];
       
       
    %BC forcing
    data_shp1 = Data_shp1s.BCForcings_all;
    data_shp2 = Data_shp2s.BCForcings_all;
    data_shp3 = Data_shp3s.BCForcings_all;
    data_shp4 = Data_shp4s.BCForcings_all;
    data_BC =  Data_BCs.BCForcings_all;
    data_dust =  Data_dusts.BCForcings_all;
    data_BC4 =  Data_BC_shp4s.BCForcings_all;
    data_dust4 =  Data_dust_shp4s.BCForcings_all;
    
    
    BCRFData = [elevations(:) FSNO_shp1(:) FSNO_class(:) data_shp1(:) data_shp2(:) data_shp3(:) data_shp4(:) ...
        data_BC(:) data_dust(:) data_BC4(:) data_dust4(:)];
       
    %SH
    data_shp1 = Data_shp1s.DustForcings_all;
    data_shp2 = Data_shp2s.DustForcings_all;
    data_shp3 = Data_shp3s.DustForcings_all;
    data_shp4 = Data_shp4s.DustForcings_all;
    data_BC =  Data_BCs.DustForcings_all;
    data_dust =  Data_dusts.DustForcings_all;
    data_BC4 =  Data_BC_shp4s.DustForcings_all;
    data_dust4 =  Data_dust_shp4s.DustForcings_all;
    
    
    DustRFData = [elevations(:) FSNO_shp1(:) FSNO_class(:) data_shp1(:) data_shp2(:) data_shp3(:) data_shp4(:) ...
        data_BC(:) data_dust(:) data_BC4(:) data_dust4(:)];

    
    %% save data
    save(['RF_all_data_' Seasonname '.mat'],'SnowalbedoData','SnowcoverData',...
        'DeltasnowalbedoData','DeltasnowalbedobyBCData','DeltasnowalbedobydustData',...
        'AerosolRFData','BCRFData','DustRFData'...
        );
end
