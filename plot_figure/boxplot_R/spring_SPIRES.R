library(tidyverse)
library(R.matlab)
library(cowplot)
library(reshape2)
library(stringr)
setwd('C:/Users/haod776/OneDrive - PNNL/Documents/work/E3SM/writting/black_carbon/writing/plot_figure/boxplot_R/')

# import data
all_datas <- readMat(paste0('spring_SPIRES_ELM_v4.mat'));

all_datas <- as.data.frame(all_datas['data'])  
colnames(all_datas) <- c('SnowCovers_ELM','SnowCovers_MODSCAG','SnowCovers_SPIRES', 'GrainSizes_ELM', 'GrainSizes_MODSCAG','GrainSizes_SPIRES', 'deltaAlbedos_ELM', 'deltaAlbedos_MODSCAG','deltaAlbedos_SPIRES', 'SnowAlbedos_ELM', 'SnowAlbedos_MODSCAG','SnowAlbedos_SPIRES')


all_data <- all_datas %>%
  select('SnowCovers_ELM','SnowCovers_MODSCAG','SnowCovers_SPIRES') %>%
  rename(ELM = SnowCovers_ELM, MODSCAG = SnowCovers_MODSCAG, SPIRES = SnowCovers_SPIRES) %>%
  filter(!is.na(ELM),!is.na(MODSCAG),!is.na(SPIRES)) %>%
  melt() 

plot_1 <- all_data %>%
  ggplot(aes(x =variable , y = value, fill = variable)) + 
  ylab('Snow cover fraction') + 
  # xlab('Elevation (km)')  +
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0),
        axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=10, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=10),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.15,0.9), 
        legend.direction = "vertical",
        legend.title = element_blank())  +
  scale_fill_brewer(palette="YlGn")

all_data <- all_datas %>%
  select('GrainSizes_ELM', 'GrainSizes_MODSCAG','GrainSizes_SPIRES')  %>%
  rename(ELM = GrainSizes_ELM, MODSCAG = GrainSizes_MODSCAG, SPIRES = GrainSizes_SPIRES) %>%
  filter(!is.na(ELM),!is.na(MODSCAG),!is.na(SPIRES)) %>%
  melt() 

plot_2 <- all_data %>%
  ggplot(aes(x =variable , y = value, fill = variable)) + 
  ylab('Grain size (um)') + 
  #xlab('Elevation (km)')  +
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0),
        axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=10, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=10),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.15,0.9), 
        legend.direction = "vertical",
        legend.title = element_blank())  +
  scale_fill_brewer(palette="YlGn")

all_data <- all_datas %>%
  select('deltaAlbedos_ELM', 'deltaAlbedos_MODSCAG','deltaAlbedos_SPIRES')  %>%
  rename(ELM = deltaAlbedos_ELM, MODSCAG = deltaAlbedos_MODSCAG, SPIRES = deltaAlbedos_SPIRES) %>%
  filter(!is.na(ELM),!is.na(MODSCAG),!is.na(SPIRES)) %>%
  melt() 

plot_3 <- all_data %>%
  ggplot(aes(x =variable , y = value, fill = variable)) + 
  ylab('Snow albedo reduction') + 
  #xlab('Elevation (km)')  +
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0),
        axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=10, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=10),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.15,0.9), 
        legend.direction = "vertical",
        legend.title = element_blank()) +
  scale_fill_brewer(palette="YlGn")

#+
#scale_fill_manual(labels = c("ELM", "MODSCAG"), values = c("#999999", "#E69F00")) +
#scale_fill_brewer(palette="YlGn") +
#scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) #+ 
# ylim(c(-0.2,0.2))

plot_figure <- plot_grid(   plot_1,plot_2,plot_3,
                            
                            labels = c("a", "b","c"),
                            label_size = 20,
                            nrow = 1, ncol = 3, align = 'v')

ggsave(paste0("spring_comparison_Indus.tiff"), plot = plot_figure, width = 28, height = 8, units = "cm", dpi = 300, limitsize = FALSE, compression = "lzw")
