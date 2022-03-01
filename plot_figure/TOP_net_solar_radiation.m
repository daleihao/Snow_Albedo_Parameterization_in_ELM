load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\TOP_11years_ELMBC_TP_snowshape_1_iBC_eDUST_winter.mat')
a = NetSolarRadiations_all;
load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\TOP_11years_ELMBC_TP_snowshape_4_iBC_eDUST_winter.mat')
b = NetSolarRadiations_all;
load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\11years_ELMBC_TP_snowshape_1_iBC_eDUST_winter.mat')
c = NetSolarRadiations_all;
load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\11years_ELMBC_TP_snowshape_4_iBC_eDUST_winter.mat')
d = NetSolarRadiations_all;

maxvalue = 20;
figure;
colors = flipud(brewermap(100, 'Spectral'));
colormap(colors)
colors2 = flipud(brewermap(100, 'Spectral'));

subplot(231)
imagesc(a-c,[-maxvalue maxvalue])
title('Sphere: TOP-PP')
colorbar
subplot(232)
imagesc(b-d,[-maxvalue maxvalue])
title('Koch snowflake: TOP-PP')
colorbar
subplot(233)
imagesc((a-c) - (b-d),[-maxvalue maxvalue])
title('Sphere - Koch snowflake')
colorbar

cb = subplot(234)
imagesc(b-a,[-maxvalue maxvalue]);
colormap(cb, colors2);
colorbar
title('TOP: Koch-Sphere')

cb = subplot(235)
imagesc(d-c,[-maxvalue maxvalue])
colormap(cb, colors2);
colorbar
title('PP: Koch-Sphere')

cb = subplot(236)
imagesc((b-a) - (d-c),[-maxvalue maxvalue])
colormap(cb, colors2);
colorbar
title('TOP - PP')


%%

figure
colormap(colors)

subplot(131)
imagesc(d-c,[-maxvalue maxvalue])
colorbar
title('PP Koch - PP Sphere')
subplot(132)
imagesc(b-d,[-maxvalue maxvalue])
colorbar
title('TOP Koch - PP Koch')

subplot(133)
imagesc(b-c,[-maxvalue maxvalue])
colorbar
title('TOP Koch - PP Sphere')


%%

figure
colormap(colors)

subplot(221)
imagesc(a,[0 200])
colorbar
title('TOP Sphere')
subplot(222)
imagesc(b,[0 200])
colorbar
title('TOP Koch')

subplot(223)
imagesc(c,[0 200])
colorbar
title('PP Sphere')

subplot(224)
imagesc(d,[0 200])
colorbar
title('PP Koch')


load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\TOP_11years_ELMBC_TP_snowshape_1_iBC_eDUST_spring.mat')
a = NetSolarRadiations_all;
load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\TOP_11years_ELMBC_TP_snowshape_4_iBC_eDUST_spring.mat')
b = NetSolarRadiations_all;
load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\11years_ELMBC_TP_snowshape_1_iBC_eDUST_spring.mat')
c = NetSolarRadiations_all;
load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\11years_ELMBC_TP_snowshape_4_iBC_eDUST_spring.mat')
d = NetSolarRadiations_all;


figure;
colors = flipud(brewermap(100, 'Spectral'));
colormap(colors)
colors2 = flipud(brewermap(100, 'Spectral'));

subplot(231)
imagesc(a-c,[-maxvalue maxvalue])
title('Sphere: TOP-PP')
colorbar
subplot(232)
imagesc(b-d,[-maxvalue maxvalue])
title('Koch snowflake: TOP-PP')
colorbar
subplot(233)
imagesc((a-c) - (b-d),[-maxvalue maxvalue])
title('Sphere - Koch snowflake')
colorbar

cb = subplot(234)
imagesc(b-a,[-maxvalue maxvalue]);
colormap(cb, colors2);
colorbar
title('TOP: Koch-Sphere')

cb = subplot(235)
imagesc(d-c,[-maxvalue maxvalue])
colormap(cb, colors2);
colorbar
title('PP: Koch-Sphere')

cb = subplot(236)
imagesc((b-a) - (d-c),[-maxvalue maxvalue])
colormap(cb, colors2);
colorbar
title('TOP - PP')


%%

figure
colormap(colors)

subplot(131)
imagesc(d-c,[-maxvalue maxvalue])
colorbar
title('PP Koch - PP Sphere')
subplot(132)
imagesc(b-d,[-maxvalue maxvalue])
colorbar
title('TOP Koch - PP Koch')

subplot(133)
imagesc(b-c,[-maxvalue maxvalue])
colorbar
title('TOP Koch - PP Sphere')


figure
colormap(colors)

subplot(221)
imagesc(a,[0 300])
colorbar
title('TOP Sphere')
subplot(222)
imagesc(b,[0 300])
colorbar
title('TOP Koch')

subplot(223)
imagesc(c,[0 300])
colorbar
title('PP Sphere')

subplot(224)
imagesc(d,[0 300])
colorbar
title('PP Koch')


