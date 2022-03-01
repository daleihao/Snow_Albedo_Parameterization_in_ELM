clc;
clear all;
close all;

res_h = 0.125;
res_v = 0.125;
lat_top = 41;
lat_bottom = 22;
lon_left = 65;
lon_right = 108;

lon = (lon_left+res_h/2):res_h: (lon_right-res_h/2);
lat = (lat_top-res_v/2):-res_v: (lat_bottom+res_v/2);
[long_region,lati_region]=meshgrid(lon,lat);

[rows, cols] = size(long_region);
melts_TP = nan(rows, cols);
swes_TP = nan(rows, cols);

%% get lat/lon info
load('SPIRESlatlon.mat');

%%parpool(24)
%% define file info
for year_i = 2001:1:2011
    filename = ['../SWE_SPIRES/reconstruction_Indus_' num2str(year_i) '.h5'];
    location = '/Grid/';
    rastersize = [1703 3636];
    info = h5info(filename);
    
    % day_start = [275 274 274 274 275 274 274 274 275 274 274];
    
    dayofyear = 1;
    %% first get monthly value
    for tmp_i = 1:12
        
        
        datetime1 = datetime(year_i - 1, tmp_i - 1 + 10, 1);
        year_cal = year(datetime1);
        month_cal = month(datetime1);
        
        daynum = daycal(year_cal, month_cal);
        
        %indices = dayofyear:(dayofyear+daynum-1);
        %% get snow fraction
        if(~exist(['mat/SWE/SPIRES_' num2str(year_cal) '_' num2str(month_cal) '_v4.mat'],'file'))
            tic
            melts =h5read(filename, [location '/melt'],[1 1 dayofyear],[Inf Inf daynum]);
            melts = double(melts)/100;
            melts(melts>4e3 | melts<0)=nan;
            
            swes =h5read(filename, [location '/swe'],[1 1 dayofyear],[Inf Inf daynum]);
            swes = double(swes);
            swes(swes>4e3 | swes<0)=nan; %um
                           
            melts_monthly = nanmean(melts,3);
            swes_monthly =nanmean(swes,3);
            
            save(['mat/SPIRES_' num2str(year_cal) '_' num2str(month_cal) '_v4.mat'],'swes_monthly','melts_monthly');
            
            clear swes melts
            %% remap
            filters =  swes_monthly>=0;
            lon_tmp = lons(filters);
            lat_tmp = lats(filters);
            melts_monthly = melts_monthly(filters);
            swes_monthly = swes_monthly(filters);
            
            max_lat = max(lat_tmp);
            min_lat = min(lat_tmp);
            max_lon = max(lon_tmp);
            min_lon = min(lon_tmp);
            
            disp('start remap')
            tic
            for row_i = 1:rows
                
                for col_j = 1:cols
                    
                    if(long_region(row_i, col_j)>max_lon || long_region(row_i, col_j)<min_lon || ...
                            lati_region(row_i, col_j)>max_lat || lati_region(row_i, col_j)<min_lat)
                        continue;
                    end
                    
                    filter_dis = abs(lon_tmp - long_region(row_i, col_j))<=0.125/2 & abs(lat_tmp - lati_region(row_i, col_j))<=0.125/2;
                    
                    if (sum(filter_dis)>0)
			melts_TP(row_i, col_j) = nanmean(melts_monthly(filter_dis));
			swes_TP(row_i, col_j) = nanmean(swes_monthly(filter_dis));
                        
                    end
                    
                end
            end
            toc
            
            save(['mat/SWE/SPIRES_' num2str(year_cal) '_' num2str(month_cal) '_v4.mat'],'swes_TP','melts_TP','-append');
            
            toc
        end
        dayofyear = dayofyear+daynum;
        
    end
end

