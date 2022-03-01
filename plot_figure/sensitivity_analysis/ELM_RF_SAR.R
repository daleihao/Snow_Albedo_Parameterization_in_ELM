library(tidyverse)
library(R.matlab)
library(cowplot)
library(reshape2)
setwd('C:/Users/haod776/OneDrive - PNNL/Documents/work/E3SM/writting/black_carbon/writing/plot_figure/sensitivity_analysis/')

# import data
for (Season in c('Winter','Spring'))
{
  if (Season == 'Winter')
  {maxvalue = 10}
  else
    {maxvalue = 20}
  
all_data_import <- readMat(paste0('RF_all_data_',Season,'.mat'));
all_datas_1 <- as.data.frame(all_data_import['AerosolRFData'])  
colnames(all_datas_1) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')
all_datas_2 <- as.data.frame(all_data_import['BCRFData'])  
colnames(all_datas_2) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')
all_datas_3 <- as.data.frame(all_data_import['DustRFData'])  
colnames(all_datas_3) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')

# surface albedo
all_data_1 <- all_datas_1 %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>% 
  mutate(code = 1) 

all_data_2 <- all_datas_2 %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>% 
  mutate(code = 2)

all_data_3 <- all_datas_3 %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>% 
  mutate(code = 3) %>%
  mutate(code = factor(code))

all_data_123 <- do.call("rbind", list(all_data_1, all_data_2, all_data_3)) %>%
  melt(id=c("snow_cover","elevation","snow_filter","code"))

plot_RF1 <- all_data_123 %>% 
  filter(snow_filter<0.5) %>%
  ggplot(aes(x =variable , y = value, fill = code)) + 
  ylab(expression(bold(RF~"(W/"*m^{2}*")"))) + 
  #xlab('Snow cover fraction')  +
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0,hjust = 0.5),
        axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=8, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=8),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.10,0.8), 
        legend.direction = "vertical",
        legend.title = element_blank()) +
  #scale_fill_manual() +
  scale_fill_brewer(palette = "Dark2", labels = c("All LAPs","BC","Dust")) +
  scale_x_discrete(labels = c("Sph_BCInt_DExt","Sphd_BCInt_DExt","Hex_BCInt_DExt","Koc_BCInt_DExt","Sph_BCExt_DExt","Sph_BCExt_DInt","Koc_BCExt_DExt","Koc_BCExt_DInt")) + 
  ylim(c(0,maxvalue)) +
  ggtitle(expression(italic(f)["sno"]~" < 0.5"))

plot_RF2 <- all_data_123 %>% 
  filter(snow_filter>=0.5) %>%
  ggplot(aes(x =variable , y = value, fill = code)) + 
  ylab(expression(bold(RF~"(W/"*m^{2}*")"))) + 
  #xlab('Snow cover fraction')  +
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0,hjust = 0.5),
        axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=8, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=8),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.20,0.8), 
        legend.direction = "vertical",
        legend.title = element_blank()) +
  #scale_fill_manual() +
  scale_fill_brewer(palette = "Dark2", labels = c("All LAPs","BC","Dust")) +
  scale_x_discrete(labels = c("Sph_BCInt_DExt","Sphd_BCInt_DExt","Hex_BCInt_DExt","Koc_BCInt_DExt","Sph_BCExt_DExt","Sph_BCExt_DInt","Koc_BCExt_DExt","Koc_BCExt_DInt")) + 
  ylim(c(0,maxvalue)) + 
  ggtitle(expression(italic(f)["sno"]~' '>=" 0.5"))

##############################
# albedo reduction
if (Season == 'Winter')
{maxvalue = 0.1}
else
{maxvalue = 0.1}

all_data_import <- readMat(paste0('RF_all_data_',Season,'.mat'));
all_datas_1 <- as.data.frame(all_data_import['DeltasnowalbedoData'])  
colnames(all_datas_1) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')
all_datas_2 <- as.data.frame(all_data_import['DeltasnowalbedobyBCData'])  
colnames(all_datas_2) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')
all_datas_3 <- as.data.frame(all_data_import['DeltasnowalbedobydustData'])  
colnames(all_datas_3) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')

# surface albedo
all_data_1 <- all_datas_1 %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>% 
  mutate(code = 1) 

all_data_2 <- all_datas_2 %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>% 
  mutate(code = 2)

all_data_3 <- all_datas_3 %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>% 
  mutate(code = 3) %>%
  mutate(code = factor(code))

all_data_123 <- do.call("rbind", list(all_data_1, all_data_2, all_data_3)) %>%
  melt(id=c("snow_cover","elevation","snow_filter","code"))



plot_Albedo1 <- all_data_123 %>% 
  filter(snow_filter<0.5) %>%
  ggplot(aes(x =variable , y = value, fill = code)) + 
  ylab("SAR")+ 
  #xlab('Snow cover fraction')  +
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0,hjust = 0.5),
        axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=8, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=8),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.10,0.8), 
        legend.direction = "vertical",
        legend.title = element_blank()) +
  #scale_fill_manual() +
  scale_fill_brewer(palette = "Dark2", labels = c("All LAPs","BC","Dust")) +
  scale_x_discrete(labels = c("Sph_BCInt_DExt","Sphd_BCInt_DExt","Hex_BCInt_DExt","Koc_BCInt_DExt","Sph_BCExt_DExt","Sph_BCExt_DInt","Koc_BCExt_DExt","Koc_BCExt_DInt")) + 
  ylim(c(0,maxvalue)) +
  ggtitle(expression(italic(f)["sno"]~" < 0.5"))

plot_Albedo2 <- all_data_123 %>% 
  filter(snow_filter>=0.5) %>%
  ggplot(aes(x =variable , y = value, fill = code)) + 
  ylab("SAR") + 
  #xlab('Snow cover fraction')  +
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0,hjust = 0.5),
        axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=8, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=8),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.20,0.8), 
        legend.direction = "vertical",
        legend.title = element_blank()) +
  #scale_fill_manual() +
  scale_fill_brewer(palette = "Dark2", labels = c("All LAPs","BC","Dust")) +
  scale_x_discrete(labels = c("Sph_BCInt_DExt","Sphd_BCInt_DExt","Hex_BCInt_DExt","Koc_BCInt_DExt","Sph_BCExt_DExt","Sph_BCExt_DInt","Koc_BCExt_DExt","Koc_BCExt_DInt")) + 
  ylim(c(0,maxvalue)) + 
  ggtitle(expression(italic(f)["sno"]~' '>=" 0.5"))



plot_figure <- plot_grid(   
                            plot_Albedo1,plot_Albedo2 + theme(legend.position="none"),
                            plot_RF1+ theme(legend.position="none") ,plot_RF2 + theme(legend.position="none"),
                            labels = c("(a)", "(b)","(c)", "(d)"),
                            #%vjust = 0,
                            label_size = 10,
                            nrow = 4, ncol = 1, align = 'v')
ggsave(paste0(Season,"_RF_SAR_comparison_TP.tiff"), plot = plot_figure, width = 22, height = 22, units = "cm", dpi = 300, limitsize = FALSE, compression = "lzw")
}
