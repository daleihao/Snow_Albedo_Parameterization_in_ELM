load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\TOP_11years_ELMBC_TP_snowshape_1_iBC_eDUST_winter.mat')
a = SnowCovers_all;
load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\TOP_11years_ELMBC_TP_snowshape_4_iBC_eDUST_winter.mat')
b = SnowCovers_all;
load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\11years_ELMBC_TP_snowshape_1_iBC_eDUST_winter.mat')
c = SnowCovers_all;
load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\11years_ELMBC_TP_snowshape_4_iBC_eDUST_winter.mat')
d = SnowCovers_all;


figure;
colors = flipud(brewermap(100, 'Spectral'));
colormap(colors)
colors2 = flipud(brewermap(100, 'Spectral'));

subplot(231)
imagesc(a-c,[-0.1 0.1])
title('Sphere: TOP-PP')
colorbar
subplot(232)
imagesc(b-d,[-0.1 0.1])
title('Koch snowflake: TOP-PP')
colorbar
subplot(233)
imagesc((a-c) - (b-d),[-0.1 0.1])
title('Sphere - Koch snowflake')
colorbar

cb = subplot(234)
imagesc(b-a,[-0.1 0.1]);
colormap(cb, colors2);
colorbar
title('TOP: Koch-Sphere')

cb = subplot(235)
imagesc(d-c,[-0.1 0.1])
colormap(cb, colors2);
colorbar
title('PP: Koch-Sphere')

cb = subplot(236)
imagesc((b-a) - (d-c),[-0.1 0.1])
colormap(cb, colors2);
colorbar
title('TOP - PP')



figure;
colors = flipud(brewermap(100, 'Spectral'));
colormap(colors)
colors2 = flipud(brewermap(100, 'Spectral'));

subplot(231)
imagesc(a-c,[-0.1 0.1])
title('Sphere: TOP-PP')
colorbar
subplot(232)
imagesc(b-d,[-0.1 0.1])
title('Koch snowflake: TOP-PP')
colorbar
subplot(233)
imagesc((a-c) - (b-d),[-0.1 0.1])
title('Sphere - Koch snowflake')
colorbar

cb = subplot(234)
imagesc(b-a,[-0.1 0.1]);
colormap(cb, colors2);
colorbar
title('TOP: Koch-Sphere')

cb = subplot(235)
imagesc(d-c,[-0.1 0.1])
colormap(cb, colors2);
colorbar
title('PP: Koch-Sphere')

cb = subplot(236)
imagesc((b-a) - (d-c),[-0.1 0.1])
colormap(cb, colors2);
colorbar
title('TOP - PP')








