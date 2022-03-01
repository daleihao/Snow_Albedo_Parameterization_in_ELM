load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\TOP_11years_ELMBC_TP_snowshape_1_iBC_eDUST_winter.mat')
a = NetSolarRadiations_all;
load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\TOP_11years_ELMBC_TP_snowshape_4_iBC_eDUST_winter.mat')
b = NetSolarRadiations_all;
load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\11years_ELMBC_TP_snowshape_1_iBC_eDUST_winter.mat')
c = NetSolarRadiations_all;
load('C:\Users\haod776\OneDrive - PNNL\Documents\work\E3SM\writting\black_carbon\writing\plot_figure\ELM_Data_Season_11years\11years_ELMBC_TP_snowshape_4_iBC_eDUST_winter.mat')
d = NetSolarRadiations_all;


figure;
subplot(221)
imagesc(a-c,[-20 20])
subplot(222)
imagesc(b-d,[-20 20])
subplot(223)
imagesc(a-b,[-20 20])
subplot(224)
imagesc(c-d,[-20 20])
subplot(224)
imagesc(b-c,[-20 20])



figure;
subplot(131)
imagesc(a-b,[-20 20])
subplot(132)
imagesc(c-d,[-20 20])
subplot(133)
imagesc(abs(a-b)-(c-d),[-5 5])





