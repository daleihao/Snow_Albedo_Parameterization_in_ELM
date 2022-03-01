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
for i = [3]
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
    data_shp1 = Data_shp1s.SnowCovers_all;
    data_shp2 = Data_shp2s.SnowCovers_all;
    data_shp3 = Data_shp3s.SnowCovers_all;
    data_shp4 = Data_shp4s.SnowCovers_all;
    data_BC =  Data_BCs.SnowCovers_all;
    data_dust =  Data_dusts.SnowCovers_all;
    data_BC4 =  Data_BC_shp4s.SnowCovers_all;
    data_dust4 =  Data_dust_shp4s.SnowCovers_all;
    
    
    %% nan
    difference_1 = data_shp1 - data_shp1;
    difference_2 = data_shp2 - data_shp1;
    difference_3 = data_shp3 - data_shp1;
    difference_4 = data_shp4 - data_shp1;
    difference_BC = data_shp1 - data_BC;
    difference_dust = data_dust - data_BC;
    difference_BC4 = data_shp4 - data_BC4;
    difference_dust4 = data_dust4 - data_BC4;  

%% figue plot
figure;
set(gcf,'unit','normalized','position',[0.1,0.1,0.85,0.4]);
set(gca, 'Position', [0 0 1 1])
colors = flipud(brewermap(100, 'Spectral'));
colormap(colors)

subplot('position', [0.04 0.53 0.21 0.4])
%histogram(FSA_shp2(:) - FSA_shp1(:), [-40:1:40])
plot_global_map_RF(lats, lons, difference_2, 0, 0.2, '', 0, 1,'(a)')

t = title('Non-spherical effect (Spheroid)');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);

%ylabel({'Winter',''},'fontsize',12,'fontweight','bold')
subplot('position', [0.26 0.53 0.21 0.4])
plot_global_map_RF(lats, lons, difference_3, 0, 0.2, '', 0, 0,'(b)')

%ylabel({'RF by BC',''},'fontsize',12)
t = title('Non-spherical effect (Hexagonal)');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);

subplot('position', [0.48 0.53 0.21 0.4])
plot_global_map_RF(lats, lons, difference_4, 0, 0.2, '', 0, 0,'(c)')

%ylabel({'RF by dust',''},'fontsize',12)
t = title('Non-spherical effect (Koch)');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);

% subplot('position', [0.70 0.53 0.21 0.4])
% plot_global_map_RF(lats, lons, difference_4, 0, 0.2, '', 0, 0,'(e)')
% 
% %ylabel({'RF by dust',''},'fontsize',12)
% t = title('RF by dust');
% set(t, 'horizontalAlignment', 'left');
% set(t, 'units', 'normalized');
% h1 = get(t, 'position');
% set(t, 'position', [0 h1(2) h1(3)]);

hcb = colorbar;
hcb.Title.String = "Unitless";
x = hcb.Position;
x(1) = 0.71;
%x(2) = 0.65;
%x(4) = 0.23;

hcb.Position = x;
hcb.FontSize = 12;


colors2 = (brewermap(100, 'Spectral'));


subplot('position', [0.04 0.08 0.21 0.4])
%histogram(FSA_shp2(:) - FSA_shp1(:), [-40:1:40])
plot_global_map_RF(lats, lons, difference_BC, -0.04,0, '', 1, 1,'(d)')
colormap(gca,colors2)
t = title('BC mixing state effect (Sphere)');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);

%ylabel({'Spring',''},'fontsize',12,'fontweight','bold')
subplot('position', [0.26 0.08 0.21 0.4])
plot_global_map_RF(lats, lons, difference_dust,  -0.04,0, '', 1, 0,'(e)')
colormap(gca,colors2)

%ylabel({'RF by BC',''},'fontsize',12)
t = title('Dust mixing state effect (Sphere)');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);
subplot('position', [0.48 0.08 0.21 0.4])
plot_global_map_RF(lats, lons, difference_BC4, -0.04,0, '', 1, 0,'(f)')
colormap(gca,colors2)
t = title('BC mixing state effect (Koch)');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);


%ylabel({'RF by dust',''},'fontsize',12)
subplot('position', [0.70 0.08 0.21 0.4])
plot_global_map_RF(lats, lons, difference_dust4, -0.04,0, '', 1, 0,'(g)')
colormap(gca,colors2)

t = title('Dust mixing state effect (Koch)');
set(t, 'horizontalAlignment', 'left');
set(t, 'units', 'normalized');
h1 = get(t, 'position');
set(t, 'position', [0 h1(2) h1(3)]);

hcb = colorbar;
hcb.Title.String = "Unitless";
x = hcb.Position;
x(1) = 0.93;
%x(2) = 0.65;
%x(4) = 0.23;

hcb.Position = x;
hcb.FontSize = 12;

% %% snow cover
% figure;
print(gcf, '-dtiff', '-r300', ['spatial_map/' Seasonname '_model_snow_cover_difference.tif'])

close all
end
