library(tidyverse)
library(R.matlab)
library(cowplot)
library(reshape2)
setwd('C:/Users/haod776/OneDrive - PNNL/Documents/work/E3SM/writting/black_carbon/writing/plot_figure/boxplot_R/')

# import data
  all_datas <- readMat(paste0('revise_winter_MODSCAG_ELM.mat'));
  
  all_datas <- as.data.frame(all_datas['data'])  
  colnames(all_datas) <- c('Elevation_band','SnowCovers_ELM','SnowCovers_MODSCAG', 'GrainSizes_ELM', 'GrainSizes_MODSCAG', 'deltaAlbedos_ELM', 'deltaAlbedos_MODSCAG', 'SnowAlbedos_ELM', 'SnowAlbedos_MODSCAG')
  
  all_datas <-  all_datas %>% 
    filter(SnowCovers_ELM>0.01, SnowCovers_MODSCAG>0.01)
 
  all_data <- all_datas %>% 
    select(Elevation_band, SnowCovers_ELM,SnowCovers_MODSCAG ) %>% 
    filter(Elevation_band>=1) %>%
    mutate(Elevation = factor(Elevation_band)) %>%
    select(Elevation, SnowCovers_ELM,SnowCovers_MODSCAG ) %>%
    filter(!is.na(SnowCovers_ELM),!is.na(SnowCovers_MODSCAG)) %>%
    melt(id=c("Elevation"))
    
    plot_1 <- all_data %>%
    ggplot(aes(x =Elevation , y = value, fill = variable)) + 
    ylab(expression(italic(f)["sno"])) + 
    #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
    geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
    #geom_jitter(trim = FALSE) +
    stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
    #geom_boxplot(width=0.1) + 
    theme_classic() + 
    theme(plot.title = element_text(face="bold", color="black",size=15, angle=0,hjust = 0.5),
          axis.title.x=element_blank(),
          axis.text.x = element_text(color="black",size=15, angle=0),
          axis.text.y = element_text( color="black", size=15, angle=0),
          axis.title.y = element_text(face="bold", color="black",size=15),
          axis.line = element_line(size = 0.5),
          legend.position = c(0.15,0.9), 
          legend.direction = "vertical",
          legend.title = element_blank(),
          plot.margin = unit(c(1, 0, 0, 0), "cm")) +
      scale_fill_manual(labels = c("ELM", "MODSCAG/MODDRFS"), values = c("#999999", "#E69F00")) +
    #scale_fill_brewer(palette="YlGn") +
    scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) + 
   ylim(c(0,1.2)) +
      ggtitle('Winter')
     
  

    all_data <- all_datas %>% 
      select(Elevation_band, deltaAlbedos_ELM,deltaAlbedos_MODSCAG ) %>% 
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      select(Elevation, deltaAlbedos_ELM,deltaAlbedos_MODSCAG ) %>%
      filter(!is.na(deltaAlbedos_ELM),!is.na(deltaAlbedos_MODSCAG)) %>%
      melt(id=c("Elevation"))
    
    plot_2 <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      ylab('SAR') + 
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=15, angle=0),
            #axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=15, angle=0),
            axis.text.y = element_text( color="black", size=15, angle=0),
            axis.title.y = element_text(face="bold", color="black",size=15),
            axis.title.x = element_text(face="bold", color="black",size=15),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.35,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank(),
            legend.text = element_text(color="black",size=15, angle=0),
            plot.margin = unit(c(1, 0, 0, 0), "cm")) +
     
      scale_fill_manual(labels = c("ELM", "MODSCAG/MODDRFS"), values = c("#999999", "#E69F00")) +
      #scale_fill_brewer(palette="YlGn") +
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) + 
    ylim(c(0, 0.15)) +
      xlab('Elevation (km)')  

    all_data <- all_datas %>% 
      select(Elevation_band, GrainSizes_ELM,GrainSizes_MODSCAG ) %>% 
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      select(Elevation, GrainSizes_ELM,GrainSizes_MODSCAG ) %>%
      filter(!is.na(GrainSizes_ELM),!is.na(GrainSizes_MODSCAG)) %>%
      melt(id=c("Elevation"))
    
    plot_3 <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      ylab('Grain size') + 
      xlab('Elevation (km)')  +
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=15, angle=0),
            axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=15, angle=0),
            axis.text.y = element_text( color="black", size=15, angle=0),
            axis.title.y = element_text(face="bold", color="black",size=15),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.15,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank(),
            plot.margin = unit(c(1, 0, 0, 0), "cm")) +
      scale_fill_manual(labels = c("ELM", "MODSCAG/MODDRFS"), values = c("#999999", "#E69F00")) +
      #scale_fill_brewer(palette="YlGn") +
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) + 
    ylim(c(0,1000))
    
    
    all_data <- all_datas %>% 
      select(Elevation_band, SnowAlbedos_ELM,SnowAlbedos_MODSCAG ) %>% 
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      select(Elevation, SnowAlbedos_ELM,SnowAlbedos_MODSCAG ) %>%
      filter(!is.na(SnowAlbedos_ELM),!is.na(SnowAlbedos_MODSCAG)) %>%
      melt(id=c("Elevation"))
    
    plot_snow <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      ylab('Snow albedo') + 
      xlab('Elevation (km)')  + ggtitle('(a)') +
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=15, angle=0),
            #axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=15, angle=0),
            axis.text.y = element_text( color="black", size=15, angle=0),
            axis.title.y = element_text(face="bold", color="black",size=15),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.15,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank(),
            plot.margin = unit(c(1, 0, 0, 0), "cm")) +
      scale_fill_manual(labels = c("ELM", "MODSCAG/MODDRFS"), values = c("#999999", "#E69F00")) +
      #scale_fill_brewer(palette="YlGn") +
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) #+ 
    # ylim(c(-0.2,0.2))
    
    
    ##########################################################
    # import data
    all_datas <- readMat(paste0('revise_winter_SPIRES_ELM_v4.mat'));
    
    all_datas <- as.data.frame(all_datas['data'])  
    colnames(all_datas) <- c('Elevation_band','SnowCovers_ELM','SnowCovers_MODSCAG','SnowCovers_SPIRES', 'GrainSizes_ELM', 'GrainSizes_MODSCAG','GrainSizes_SPIRES', 'deltaAlbedos_ELM', 'deltaAlbedos_MODSCAG','deltaAlbedos_SPIRES', 'SnowAlbedos_ELM', 'SnowAlbedos_MODSCAG','SnowAlbedos_SPIRES')
    
    all_datas <-  all_datas %>% 
      filter(SnowCovers_ELM>0.01, SnowCovers_MODSCAG>0.01,SnowCovers_SPIRES>0.01)
    
    all_data <- all_datas %>%
      select('Elevation_band','SnowCovers_ELM','SnowCovers_MODSCAG','SnowCovers_SPIRES') %>%
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      rename(ELM = SnowCovers_ELM, MODSCAG = SnowCovers_MODSCAG, SPIReS = SnowCovers_SPIRES) %>%
      filter(!is.na(ELM),!is.na(MODSCAG),!is.na(SPIReS)) %>%
      select(Elevation, ELM, MODSCAG,SPIReS) %>%
      melt(id=c("Elevation")) 
    
    
    plot_4 <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      ylab(expression(italic(f)["sno"])) + 
      # xlab('Elevation (km)')  +
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=15, angle=0,hjust = 0.5),
            axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=15, angle=0),
            axis.text.y = element_text( color="black", size=15, angle=0),
            axis.title.y = element_text(face="bold", color="black",size=15),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.15,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank(),
            plot.margin = unit(c(1, 0, 0, 0), "cm"))  +
      scale_fill_manual(values = c("#999999", "#E69F00","#F37735")) +
      ylim(c(0,1.2)) +
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5'))   +
      ggtitle('Winter')
    
    all_data <- all_datas %>%
      select('Elevation_band','GrainSizes_ELM', 'GrainSizes_MODSCAG','GrainSizes_SPIRES')  %>%
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      rename(ELM = GrainSizes_ELM, MODSCAG = GrainSizes_MODSCAG, SPIReS = GrainSizes_SPIRES) %>%
      filter(!is.na(ELM),!is.na(MODSCAG),!is.na(SPIReS)) %>%
      select(Elevation, ELM, MODSCAG,SPIReS) %>%
      melt(id=c("Elevation")) 
    
    plot_5 <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      ylab('Grain size (um)') + 
      #xlab('Elevation (km)')  +
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=15, angle=0),
            # axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=15, angle=0),
            axis.text.y = element_text( color="black", size=15, angle=0),
            axis.title.y = element_text(face="bold", color="black",size=15),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.15,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank(),
            plot.margin = unit(c(1, 0, 0, 0), "cm"))  +
      scale_fill_manual(values = c("#999999", "#E69F00","#F37735"))+
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) + 
      xlab('Elevation (km)')
    
    all_data <- all_datas %>%
      select('Elevation_band','deltaAlbedos_ELM', 'deltaAlbedos_MODSCAG','deltaAlbedos_SPIRES')  %>%
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      rename(ELM = deltaAlbedos_ELM, MODSCAG = deltaAlbedos_MODSCAG, SPIReS = deltaAlbedos_SPIRES) %>%
      filter(!is.na(ELM),!is.na(MODSCAG),!is.na(SPIReS)) %>%
      select(Elevation, ELM, MODSCAG,SPIReS) %>%
      melt(id=c("Elevation")) 
    
    plot_6 <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      ylab('SAR') + 
      #xlab('Elevation (km)')  +
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=15, angle=0),
            #axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=15, angle=0),
            axis.text.y = element_text( color="black", size=15, angle=0),
            axis.title.y = element_text(face="bold", color="black",size=15),
            axis.title.x = element_text(face="bold", color="black",size=15),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.35,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank(),
            legend.text = element_text(color="black",size=15, angle=0),
            plot.margin = unit(c(1, 0, 0, 0), "cm")) +
      scale_fill_manual(labels = c("ELM", "MODSCAG/MODDRFS","SPIReS"), values = c("#999999", "#E69F00","#F37735")) +
      
      ylim(c(0,0.15))+
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) + 
      xlab('Elevation (km)')
    
    #+
    #scale_fill_manual(labels = c("ELM", "MODSCAG"), values = c("#999999", "#E69F00")) +
    #scale_fill_brewer(palette="YlGn") +
    #scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) #+ 
    # ylim(c(-0.2,0.2))
    
    
    
    ########################################
    ## 22
    
    # import data
    all_datas <- readMat(paste0('revise_spring_MODSCAG_ELM.mat'));
    
    all_datas <- as.data.frame(all_datas['data'])  
    colnames(all_datas) <- c('Elevation_band','SnowCovers_ELM','SnowCovers_MODSCAG', 'GrainSizes_ELM', 'GrainSizes_MODSCAG', 'deltaAlbedos_ELM', 'deltaAlbedos_MODSCAG', 'SnowAlbedos_ELM', 'SnowAlbedos_MODSCAG')
    
    
    all_data <- all_datas %>% 
      select(Elevation_band, SnowCovers_ELM,SnowCovers_MODSCAG ) %>% 
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      select(Elevation, SnowCovers_ELM,SnowCovers_MODSCAG ) %>%
      filter(!is.na(SnowCovers_ELM),!is.na(SnowCovers_MODSCAG)) %>%
      melt(id=c("Elevation"))
    
    plot_1_spring <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      #ylab(expression(italic(f)~[sno])) + 
      #xlab('Elevation (km)')  +
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=15, angle=0,hjust = 0.5),
            axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=15, angle=0),
            axis.text.y = element_text( color="black", size=15, angle=0),
            axis.title.y = element_blank(),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.15,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank(),
            plot.margin = unit(c(1, 0, 0, 0), "cm")) +
      scale_fill_manual(labels = c("ELM", "MODSCAG/MODDRFS"), values = c("#999999", "#E69F00")) +
      #scale_fill_brewer(palette="YlGn") +
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) +
      ylim(c(0,1.2)) +
      ggtitle('Spring')
    # ylim(c(-0.2,0.2))
    
    
    all_data <- all_datas %>% 
      select(Elevation_band, deltaAlbedos_ELM,deltaAlbedos_MODSCAG ) %>% 
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      select(Elevation, deltaAlbedos_ELM,deltaAlbedos_MODSCAG ) %>%
      filter(!is.na(deltaAlbedos_ELM),!is.na(deltaAlbedos_MODSCAG)) %>%
      melt(id=c("Elevation"))
    
    plot_2_spring <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      ylab('SAR') + 
      xlab('Elevation (km)') +
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=15, angle=0),
            #axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=15, angle=0),
            axis.text.y = element_text( color="black", size=15, angle=0),
            axis.title.y = element_blank(),
            axis.title.x = element_text(face="bold", color="black",size=15),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.15,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank(),
            plot.margin = unit(c(1, 0, 0, 0), "cm")) +
      scale_fill_manual(labels = c("ELM", "MODSCAG/MODDRFS"), values = c("#999999", "#E69F00")) +
      #scale_fill_brewer(palette="YlGn") +
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) +
      ylim(c(0,0.15))
    # ylim(c(-0.2,0.2))
    
    all_data <- all_datas %>% 
      select(Elevation_band, GrainSizes_ELM,GrainSizes_MODSCAG ) %>% 
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      select(Elevation, GrainSizes_ELM,GrainSizes_MODSCAG ) %>%
      filter(!is.na(GrainSizes_ELM),!is.na(GrainSizes_MODSCAG)) %>%
      melt(id=c("Elevation"))
    
    plot_3_spring <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      ylab('Grain size') + 
      xlab('Elevation (km)')  +
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=15, angle=0),
            axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=15, angle=0),
            axis.text.y = element_text( color="black", size=15, angle=0),
            axis.title.y = element_text(face="bold", color="black",size=15),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.15,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank(),
            plot.margin = unit(c(1, 0, 0, 0), "cm")) +
      scale_fill_manual(labels = c("ELM", "MODSCAG/MODDRFS"), values = c("#999999", "#E69F00")) +
      #scale_fill_brewer(palette="YlGn") +
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) #+ 
    # ylim(c(-0.2,0.2))
    
    
    all_data <- all_datas %>% 
      select(Elevation_band, SnowAlbedos_ELM,SnowAlbedos_MODSCAG ) %>% 
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      select(Elevation, SnowAlbedos_ELM,SnowAlbedos_MODSCAG ) %>%
      filter(!is.na(SnowAlbedos_ELM),!is.na(SnowAlbedos_MODSCAG)) %>%
      melt(id=c("Elevation"))
    
    plot_snow_spring <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      ylab('Snow cover fraction') + 
      xlab('Elevation (km)')  + ggtitle('(a)') +
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=15, angle=0),
            #axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=15, angle=0),
            axis.text.y = element_text( color="black", size=15, angle=0),
            axis.title.y = element_text(face="bold", color="black",size=15),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.15,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank(),
            plot.margin = unit(c(1, 0, 0, 0), "cm")) +
      scale_fill_manual(labels = c("ELM", "MODSCAG/MODDRFS"), values = c("#999999", "#E69F00")) +
      #scale_fill_brewer(palette="YlGn") +
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) #+ 
    # ylim(c(-0.2,0.2))
    
    
    ######################
    
    # import data
    all_datas <- readMat(paste0('revise_spring_SPIRES_ELM_v4.mat'));
    
    all_datas <- as.data.frame(all_datas['data'])  
    colnames(all_datas) <- c('Elevation_band','SnowCovers_ELM','SnowCovers_MODSCAG','SnowCovers_SPIRES', 'GrainSizes_ELM', 'GrainSizes_MODSCAG','GrainSizes_SPIRES', 'deltaAlbedos_ELM', 'deltaAlbedos_MODSCAG','deltaAlbedos_SPIRES', 'SnowAlbedos_ELM', 'SnowAlbedos_MODSCAG','SnowAlbedos_SPIRES')
    
    
    all_data <- all_datas %>%
      select('Elevation_band','SnowCovers_ELM','SnowCovers_MODSCAG','SnowCovers_SPIRES') %>%
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      rename(ELM = SnowCovers_ELM, MODSCAG = SnowCovers_MODSCAG, SPIReS = SnowCovers_SPIRES) %>%
      filter(!is.na(ELM),!is.na(MODSCAG),!is.na(SPIReS)) %>%
      select(Elevation, ELM, MODSCAG,SPIReS) %>%
      melt(id=c("Elevation")) 
    
    plot_4_spring <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      ylab(expression(italic(f)["sno"])) + 
      # xlab('Elevation (km)')  +
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=15, angle=0,hjust = 0.5),
            axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=15, angle=0),
            axis.text.y = element_text( color="black", size=15, angle=0),
            axis.title.y = element_blank(),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.15,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank(),
            plot.margin = unit(c(1, 0, 0, 0), "cm"))  +
      scale_fill_manual(values = c("#999999", "#E69F00","#F37735")) +
      ylim(c(0,1.2))+
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) +
      ggtitle('Spring')
    
    all_data <- all_datas %>%
      select('Elevation_band','GrainSizes_ELM', 'GrainSizes_MODSCAG','GrainSizes_SPIRES')  %>%
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      rename(ELM = GrainSizes_ELM, MODSCAG = GrainSizes_MODSCAG, SPIReS = GrainSizes_SPIRES) %>%
      filter(!is.na(ELM),!is.na(MODSCAG),!is.na(SPIReS)) %>%
      select(Elevation, ELM, MODSCAG,SPIReS) %>%
      melt(id=c("Elevation")) 
    
    plot_5_spring <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      ylab('Grain size (um)') + 
      #xlab('Elevation (km)')  +
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=15, angle=0),
            #axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=15, angle=0),
            axis.text.y = element_text( color="black", size=15, angle=0),
            axis.title.y = element_text(face="bold", color="black",size=15),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.15,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank(),
            plot.margin = unit(c(1, 0, 0, 0), "cm"))  +
      scale_fill_manual(values = c("#999999", "#E69F00","#F37735"))+
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) + 
      xlab('Elevation (km)')
    
    all_data <- all_datas %>%
      select('Elevation_band','deltaAlbedos_ELM', 'deltaAlbedos_MODSCAG','deltaAlbedos_SPIRES')  %>%
      filter(Elevation_band>=1) %>%
      mutate(Elevation = factor(Elevation_band)) %>%
      rename(ELM = deltaAlbedos_ELM, MODSCAG = deltaAlbedos_MODSCAG, SPIReS = deltaAlbedos_SPIRES) %>%
      filter(!is.na(ELM),!is.na(MODSCAG),!is.na(SPIReS)) %>%
      select(Elevation, ELM, MODSCAG,SPIReS) %>%
      melt(id=c("Elevation")) 
    
    plot_6_spring <- all_data %>%
      ggplot(aes(x =Elevation , y = value, fill = variable)) + 
      ylab('SAR') + 
      xlab('Elevation (km)')  +
      #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
      geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
      #geom_jitter(trim = FALSE) +
      stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
      #geom_boxplot(width=0.1) + 
      theme_classic() + 
      theme(plot.title = element_text(face="bold", color="black",size=15, angle=0),
            #axis.title.x=element_blank(),
            axis.text.x = element_text(color="black",size=15, angle=0),
            axis.text.y = element_text( color="black", size=15, angle=0),
            axis.title.y = element_blank(),
            axis.title.x = element_text(face="bold", color="black",size=15),
            axis.line = element_line(size = 0.5),
            legend.position = c(0.15,0.9), 
            legend.direction = "vertical",
            legend.title = element_blank(),
            plot.margin = unit(c(1, 0, 0, 0), "cm")) +
      scale_fill_manual(values = c("#999999", "#E69F00","#F37735")) +
      ylim(c(0,0.15))+
      scale_x_discrete(labels = c('1.5-2.5','2.5-3.5','3.5-4.5','4.5-5.5','>5.5')) + 
      xlab('Elevation (km)')
    
plot_figure <- plot_grid(   plot_4,plot_4_spring,plot_6,
                            plot_6_spring,
                            labels = c("(a)", "(b)","(c)",'(d)'),
                            label_size = 18,
                             nrow = 2, ncol = 2, align = 'v')

ggsave(paste0("revise_all_comparison_TP_3data.tiff"), plot = plot_figure, width = 28, height = 18, units = "cm", dpi = 300, limitsize = FALSE, compression = "lzw")

plot_figure <- plot_grid(   plot_1,plot_1_spring,plot_2,plot_2_spring,
                            labels = c("(a)", "(b)","(c)",'(d)'),
                            label_size = 18,
                            nrow = 2, ncol = 2, align = 'v')

ggsave(paste0("revise_all_comparison_TP_2data.tiff"), plot = plot_figure, width = 28, height = 18, units = "cm", dpi = 300, limitsize = FALSE, compression = "lzw")
