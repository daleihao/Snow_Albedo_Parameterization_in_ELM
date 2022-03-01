library(tidyverse)
library(R.matlab)
library(cowplot)
library(reshape2)
setwd('C:/Users/haod776/OneDrive - PNNL/Documents/work/E3SM/writting/black_carbon/writing/plot_figure/TOP/')

# import data
for (Season in c('Winter','Spring'))
{
  if (Season == 'Winter')
  {maxvalue = 10
  minvalue = -20}
  else
  {maxvalue = 20
  minvalue = -30}
  
  all_data_import <- readMat(paste0('TOP_',Season,'.mat'));
  all_datas <- as.data.frame(all_data_import['TOPData'])  
  colnames(all_datas) <- c('elevation','snow_filter', 'Koch', 'BC_mixing_1', 'BC_mixing_4', 'dust_1', 'dust_4','TOP_1','TOP_4','Combined')
  
  # surface albedo
  all_data <- all_datas %>% 
    filter(elevation>1500) %>%
    filter(snow_filter>0.01)
    
  
  plot_TOP1 <- all_data %>% 
    select('elevation','snow_filter','Combined', 'Koch','TOP_1','TOP_4') %>%
    melt(id = c('elevation','snow_filter'))  %>% 
    filter(snow_filter<0.5) %>%
    ggplot(aes(x =variable , y = value, fill = variable)) + 
    ylab(expression(bold(Delta~"in"~Net~solar~radiation~"(W/"*m^{2}*")"))) + 
    #xlab('Snow cover fraction')  +
    #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
    geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
    #geom_jitter(trim = FALSE) +
    stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
    #geom_boxplot(width=0.1) + 
    theme_classic() + 
    theme(plot.title = element_text(face="bold", color="black",size=11, angle=0),
          axis.title.x=element_blank(),
          axis.text.x = element_text(color="black",size=10, angle=0),
          axis.text.y = element_text( color="black", size=10, angle=0),
          axis.title.y = element_text(face="bold", color="black",size=7),
          axis.line = element_line(size = 0.5),
          legend.position = c(0.20,0.8), 
          legend.direction = "vertical",
          legend.title = element_blank()) +
    #scale_fill_manual() +
    scale_fill_brewer(palette = "Dark2", labels = c("All LAPs","BC","Dust")) +
    scale_x_discrete(labels = c("Combined effects","Koch-Sphere","TOP-PP(Sphere)","TOP-PP(Koch)")) + 
    ylim(c(minvalue,maxvalue)) +
    ggtitle('Snow cover fraction < 0.5')
  
  if (Season == 'Winter')
  {maxvalue = 8
  minvalue = -5}
  else
  {maxvalue = 8
  minvalue = -5}
  
  plot_TOP2 <- all_data %>% 
    select('elevation','snow_filter','BC_mixing_1', 'BC_mixing_4', 'dust_1', 'dust_4') %>%
    melt(id = c('elevation','snow_filter'))  %>% 
    filter(snow_filter<0.5) %>%
    ggplot(aes(x =variable , y = value, fill = variable)) + 
    ylab(expression(bold(Delta~"in"~Net~solar~radiation~"(W/"*m^{2}*")"))) + 
    #xlab('Snow cover fraction')  +
    #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
    geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
    #geom_jitter(trim = FALSE) +
    stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
    #geom_boxplot(width=0.1) + 
    theme_classic() + 
    theme(plot.title = element_text(face="bold", color="black",size=11, angle=0),
          axis.title.x=element_blank(),
          axis.text.x = element_text(color="black",size=10, angle=0),
          axis.text.y = element_text( color="black", size=10, angle=0),
          axis.title.y = element_text(face="bold", color="black",size=7),
          axis.line = element_line(size = 0.5),
          legend.position = c(0.20,0.8), 
          legend.direction = "vertical",
          legend.title = element_blank()) +
    #scale_fill_manual() +
    scale_fill_brewer(palette = "Dark2", labels = c("All LAPs","BC","Dust")) +
    scale_x_discrete(labels = c("BC(Sphere)","BC(Koch)","Dust(Sphere)","Dust(Koch)")) + 
    ylim(c(minvalue,maxvalue)) 
  
  if (Season == 'Winter')
  {maxvalue = 10
  minvalue = -20}
  else
  {maxvalue = 20
  minvalue = -30}
  
  plot_TOP3 <- all_data %>% 
    select('elevation','snow_filter','Combined', 'Koch','TOP_1','TOP_4') %>%
    melt(id = c('elevation','snow_filter'))  %>% 
    filter(snow_filter>=0.5) %>%
    ggplot(aes(x =variable , y = value, fill = variable)) + 
    ylab(expression(bold(Delta~"in"~Net~solar~radiation~"(W/"*m^{2}*")"))) + 
    #xlab('Snow cover fraction')  +
    #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
    geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
    #geom_jitter(trim = FALSE) +
    stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
    #geom_boxplot(width=0.1) + 
    theme_classic() + 
    theme(plot.title = element_text(face="bold", color="black",size=11, angle=0),
          axis.title.x=element_blank(),
          axis.text.x = element_text(color="black",size=10, angle=0),
          axis.text.y = element_text( color="black", size=10, angle=0),
          axis.title.y = element_text(face="bold", color="black",size=7),
          axis.line = element_line(size = 0.5),
          legend.position = c(0.20,0.8), 
          legend.direction = "vertical",
          legend.title = element_blank()) +
    #scale_fill_manual() +
    scale_fill_brewer(palette = "Dark2", labels = c("All LAPs","BC","Dust")) +
    scale_x_discrete(labels = c("Combined effects","Koch-Sphere","TOP-PP(Sphere)","TOP-PP(Koch)")) +
    ylim(c(minvalue,maxvalue)) + 
    ggtitle('Snow cover fraction >= 0.5')
  
  
  
  if (Season == 'Winter')
  {maxvalue = 8
  minvalue = -5}
  else
  {maxvalue = 8
  minvalue = -5}
  
  plot_TOP4 <- all_data %>% 
    select('elevation','snow_filter','BC_mixing_1', 'BC_mixing_4', 'dust_1', 'dust_4') %>%
    melt(id = c('elevation','snow_filter'))  %>% 
    filter(snow_filter>=0.5) %>%
    ggplot(aes(x =variable , y = value, fill = variable)) + 
    ylab(expression(bold(Delta~"in"~Net~solar~radiation~"(W/"*m^{2}*")"))) + 
    #xlab('Snow cover fraction')  +
    #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
    geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
    #geom_jitter(trim = FALSE) +
    stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
    #geom_boxplot(width=0.1) + 
    theme_classic() + 
    theme(plot.title = element_text(face="bold", color="black",size=11, angle=0),
          axis.title.x=element_blank(),
          axis.text.x = element_text(color="black",size=10, angle=0),
          axis.text.y = element_text( color="black", size=10, angle=0),
          axis.title.y = element_text(face="bold", color="black",size=7),
          axis.line = element_line(size = 0.5),
          legend.position = c(0.20,0.8), 
          legend.direction = "vertical",
          legend.title = element_blank()) +
    #scale_fill_manual() +
    scale_fill_brewer(palette = "Dark2", labels = c("All LAPs","BC","Dust")) +
    scale_x_discrete(labels = c("BC(Sphere)","BC(Koch)","Dust(Sphere)","Dust(Koch)")) +
    ylim(c(minvalue,maxvalue)) 
  
  
  plot_figure <- plot_grid(   plot_TOP1 + theme(legend.position="none"),plot_TOP3 + theme(legend.position="none"),
                              plot_TOP2 + theme(legend.position="none"),plot_TOP4 + theme(legend.position="none"),
                              labels = c("(a)", "(b)","(c)","(d)"),
                              #%vjust = 0,
                              label_size = 10,
                              nrow = 2, ncol = 2, align = 'v')
  ggsave(paste0(Season,"_TOP_comparison_TP.tiff"), plot = plot_figure, width = 25, height = 10, units = "cm", dpi = 300, limitsize = FALSE, compression = "lzw")
}