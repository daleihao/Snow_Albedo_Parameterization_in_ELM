library(tidyverse)
library(R.matlab)
library(cowplot)
library(reshape2)
setwd('C:/Users/haod776/OneDrive - PNNL/Documents/work/E3SM/writting/black_carbon/writing/plot_figure/boxplot_R/')

# import data
  all_datas <- readMat(paste0('winter_MODSCAG_ELM.mat'));
  
  all_datas <- as.data.frame(all_datas['data'])  
  colnames(all_datas) <- c('Elevation_band','SnowCovers_ELM','SnowCovers_MODSCAG', 'GrainSizes_ELM', 'GrainSizes_MODSCAG', 'deltaAlbedos_ELM', 'deltaAlbedos_MODSCAG', 'SnowAlbedos_ELM', 'SnowAlbedos_MODSCAG')
  
 
  all_data <- all_datas %>% 
    select(Elevation_band, SnowCovers_ELM,SnowCovers_MODSCAG ) %>% 
    filter(Elevation_band>=1) %>%
    mutate(Elevation = factor(Elevation_band)) %>%
    select(Elevation, SnowCovers_ELM,SnowCovers_MODSCAG ) %>%
    melt(id=c("Elevation"))
    
    plot_1 <- all_data %>%
    ggplot(aes(x =Elevation , y = value, fill = variable)) + 
    ylab('Snow cover fraction') + 
    xlab('Elevation (km)')  +
    #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
    geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
    #geom_jitter(trim = FALSE) +
    stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
    #geom_boxplot(width=0.1) + 
    theme_classic() + 
    theme(plot.title = element_text(face="bold", color="black",size=11, angle=0),
          #axis.title.x=element_blank(),
          axis.text.x = element_text(color="black",size=10, angle=0),
          axis.text.y = element_text( color="black", size=10, angle=0),
          axis.title.y = element_text(face="bold", color="black",size=10),
          axis.line = element_line(size = 0.5),
          legend.position = c(0.15,0.9), 
          legend.direction = "vertical",
          legend.title = element_blank()) +
      scale_fill_manual(labels = c("ELM", "MODSCAG"), values = c("#999999", "#E69F00")) +
    #scale_fill_brewer(palette="YlGn") +
    scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) #+ 
   # ylim(c(-0.2,0.2))
  

    all_data <- all_datas %>% 
      select(Elevation_band, deltaAlbedos_ELM,deltaAlbedos_MODSCAG ) %>% 
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      select(Elevation, deltaAlbedos_ELM,deltaAlbedos_MODSCAG ) %>%
      melt(id=c("Elevation"))
    
    plot_2 <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      ylab('snow albedo reduction') + 
      xlab('Elevation (km)') +
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=11, angle=0),
            #axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=10, angle=0),
            axis.text.y = element_text( color="black", size=10, angle=0),
            axis.title.y = element_text(face="bold", color="black",size=10),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.15,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank()) +
      scale_fill_manual(labels = c("ELM", "MODSCAG"), values = c("#999999", "#E69F00")) +
      #scale_fill_brewer(palette="YlGn") +
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) #+ 
    # ylim(c(-0.2,0.2))

    all_data <- all_datas %>% 
      select(Elevation_band, GrainSizes_ELM,GrainSizes_MODSCAG ) %>% 
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      select(Elevation, GrainSizes_ELM,GrainSizes_MODSCAG ) %>%
      melt(id=c("Elevation"))
    
    plot_3 <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      ylab('Grain size') + 
      xlab('Elevation (km)')  +
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=11, angle=0),
            #axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=10, angle=0),
            axis.text.y = element_text( color="black", size=10, angle=0),
            axis.title.y = element_text(face="bold", color="black",size=10),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.15,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank()) +
      scale_fill_manual(labels = c("ELM", "MODSCAG"), values = c("#999999", "#E69F00")) +
      #scale_fill_brewer(palette="YlGn") +
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) #+ 
    # ylim(c(-0.2,0.2))
    
    
    all_data <- all_datas %>% 
      select(Elevation_band, SnowAlbedos_ELM,SnowAlbedos_MODSCAG ) %>% 
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      select(Elevation, SnowAlbedos_ELM,SnowAlbedos_MODSCAG ) %>%
      melt(id=c("Elevation"))
    
    plot_4 <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      ylab('Snow cover fraction') + 
      xlab('Elevation (km)')  + ggtitle('(a)') +
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=11, angle=0),
            #axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=10, angle=0),
            axis.text.y = element_text( color="black", size=10, angle=0),
            axis.title.y = element_text(face="bold", color="black",size=10),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.15,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank()) +
      scale_fill_manual(labels = c("ELM", "MODSCAG"), values = c("#999999", "#E69F00")) +
      #scale_fill_brewer(palette="YlGn") +
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) #+ 
    # ylim(c(-0.2,0.2))
    
plot_figure <- plot_grid(   plot_1,plot_3,plot_2,
                                
                            labels = c("a", "b","c"),
                            label_size = 20,
                             nrow = 1, ncol = 3, align = 'v')

ggsave(paste0("winter_comparison_TP.tiff"), plot = plot_figure, width = 20, height = 14, units = "cm", dpi = 300, limitsize = FALSE, compression = "lzw")
