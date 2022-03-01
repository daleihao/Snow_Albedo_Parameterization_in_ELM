library(tidyverse)
library(R.matlab)
library(cowplot)
library(reshape2)
setwd('C:/Users/haod776/OneDrive - PNNL/Documents/work/E3SM/writting/black_carbon/writing/plot_figure/sensitivity_analysis/')

# import data
for (Season in c('Winter','Spring'))
{
all_data_import <- readMat(paste0('all_data_',Season,'.mat'));

all_datas <- as.data.frame(all_data_import['SurfacealbedoData'])  
colnames(all_datas) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')

# surface albedo
all_data <- all_datas %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>%
  select('snow_cover', 'shape2', 'shape3', 'shape4') %>%
  melt(id=c("snow_cover"))

plot_1 <- all_data %>%
  ggplot(aes(x =snow_cover , y = value, fill = variable)) + 
  ylab(expression(bold(Delta))) + 
  xlab('Snow cover fraction')  +
  ggtitle(expression(italic(alpha)["sur"])) + 
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0,hjust = 0.5),
        axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=10, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=8),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.25,0.8), 
        legend.direction = "vertical",
        plot.margin = unit(c(0.3, 0, 0, 0), "cm")) +
  #scale_fill_manual() +
  scale_fill_brewer(palette = "Dark2", labels = c("Spheroid - Sphere", "Hexagonal Plate - Sphere","Koch Snowflake - Sphere"),name = "Non-spherical effects") +
  scale_x_discrete(labels = c('0.0-0.2','0.2-0.4','0.4-0.6','0.6-0.8','0.8~1.0')) + 
  ylim(c(0,0.1))

# net solar radiation
all_datas <- as.data.frame(all_data_import['FSAData'])  
colnames(all_datas) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')


all_data <- all_datas %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>%
  select('snow_cover', 'shape2', 'shape3', 'shape4') %>%
  melt(id=c("snow_cover"))

plot_2 <- all_data %>%
  ggplot(aes(x =snow_cover , y = value, fill = variable)) + 
  ylab(expression(bold(Delta~"(W/"*m^{2}*")"))) + 
  xlab('Snow cover fraction')  +
  ggtitle(expression(italic(R)["net"]^S)) + 
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0,hjust = 0.5),
        axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=10, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=8),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.15,0.4), 
        legend.direction = "vertical",
        legend.title = element_blank(),
        plot.margin = unit(c(0.3, 0, 0, 0), "cm")) +
  #scale_fill_manual() +
  scale_fill_brewer(palette = "Dark2", labels = c("Spheroid", "Hexagonal Plate","Koch Snowflake")) +
  scale_x_discrete(labels = c('0.0-0.2','0.2-0.4','0.4-0.6','0.6-0.8','0.8~1.0')) + 
  ylim(c(-30,0))

# surface temperature
all_datas <- as.data.frame(all_data_import['SurfacetemperatureData'])  
colnames(all_datas) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')


all_data <- all_datas %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>%
  select('snow_cover', 'shape2', 'shape3', 'shape4') %>%
  melt(id=c("snow_cover"))

plot_3 <- all_data %>%
  ggplot(aes(x =snow_cover , y = value, fill = variable)) + 
  ylab(expression(bold(Delta~(K)))) + 
  xlab('Snow cover fraction')  +
  ggtitle(expression(italic(T)["sur"])) + 
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0,hjust = 0.5),
        axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=10, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=8),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.15,0.4), 
        legend.direction = "vertical",
        legend.title = element_blank(),
        plot.margin = unit(c(0.3, 0, 0, 0), "cm")) +
  #scale_fill_manual() +
  scale_fill_brewer(palette = "Dark2", labels = c("Spheroid", "Hexagonal Plate","Koch Snowflake")) +
  scale_x_discrete(labels = c('0.0-0.2','0.2-0.4','0.4-0.6','0.6-0.8','0.8~1.0')) + 
  ylim(c(-2.1,0))

# import data latent heat flux
all_datas <- as.data.frame(all_data_import['LHData'])  
colnames(all_datas) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')


all_data <- all_datas %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>%
  select('snow_cover', 'shape2', 'shape3', 'shape4') %>%
  melt(id=c("snow_cover"))

plot_4 <- all_data %>%
  ggplot(aes(x =snow_cover , y = value, fill = variable)) + 
  ylab(expression(bold(Delta~"(W/"*m^{2}*")"))) + 
  xlab(expression(italic(f)["sno"])) +
  ggtitle(expression(italic(F)["lat"])) + 
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0,hjust = 0.5),
        axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=10, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=8),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.2,0.2), 
        legend.direction = "horizontal",
        legend.title = element_blank(),
        plot.margin = unit(c(0.3, 0, 0, 0), "cm")) +
  #scale_fill_manual(labels = c("shape1", "shape","shape2","BC","dust")) +
  scale_fill_brewer(palette = "Dark2") +
  scale_x_discrete(labels = c('0.0-0.2','0.2-0.4','0.4-0.6','0.6-0.8','0.8~1.0'))+ 
  ylim(c(-15,0))

# import data
all_datas <- as.data.frame(all_data_import['SHData'])  
colnames(all_datas) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')

all_data <- all_datas %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>%
  select('snow_cover', 'shape2', 'shape3', 'shape4') %>%
  melt(id=c("snow_cover"))

plot_5 <- all_data %>%
  ggplot(aes(x =snow_cover , y = value, fill = variable)) + 
  ylab(expression(bold(Delta~"(W/"*m^{2}*")"))) + 
  xlab(expression(italic(f)["sno"]))  +
  ggtitle(expression(italic(F)["sen"])) + 
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0,hjust = 0.5),
        #axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=10, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=8),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.2,0.2), 
        legend.direction = "horizontal",
        legend.title = element_blank(),
        plot.margin = unit(c(0.3, 0, 0, 0), "cm")) +
  # scale_fill_manual(labels = c("shape1", "shape","shape2","BC","dust")) +
  scale_fill_brewer(palette = "Dark2") +
  scale_x_discrete(labels = c('0.0-0.2','0.2-0.4','0.4-0.6','0.6-0.8','0.8~1.0'))+  
  ylim(c(-15,0))

plot_legend <- get_legend(
  plot_1 + 
    guides(color = guide_legend(nrow = 1)) +
    theme(legend.position = "bottom")
)

plot_figure <- plot_grid(   plot_1 + theme(legend.position="none"),plot_2,plot_3,
                            plot_4,plot_5,plot_legend,
                            labels = c("(a)", "(b)","(c)","(d)","(e)"),
                            #vjust = ,
                            label_size = 12,
                            
                            nrow = 3, ncol = 2, align = 'v')

ggsave(paste0(Season,"_Energy_shape_comparison_TP_revise.tiff"), plot = plot_figure, width = 18, height = 15, units = "cm", dpi = 300, limitsize = FALSE, compression = "lzw")




#################################################
## plot Internal and Externa;

#####################################
# surface albedo
all_datas <- as.data.frame(all_data_import['SurfacealbedoData'])  
colnames(all_datas) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')


all_data <- all_datas %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>%
  select('snow_cover','BC', 'dust','BC4','dust4') %>%
  melt(id=c("snow_cover"))

plot_1 <- all_data %>%
  ggplot(aes(x =snow_cover , y = value, fill = variable)) + 
  ylab(expression(bold(Delta))) + 
  xlab('Snow cover fraction')  +
  ggtitle(expression(italic(alpha)["sur"])) + 
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = T, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0,hjust = 0.5),
        axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=10, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=8),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.25,0.8), 
        legend.direction = "vertical",
        plot.margin = unit(c(0.3, 0, 0, 0), "cm")) +
  #scale_fill_manual() +
  scale_fill_brewer(palette = "Dark2", labels = c("BC (Sphere)", "Dust (Sphere)","BC (Koch Snowflake)",'Dust (Koch Snowflake)'),name = "LAP mixing state effects (Internal - External)") +
  scale_x_discrete(labels = c('0.0-0.2','0.2-0.4','0.4-0.6','0.6-0.8','0.8~1.0')) + 
  ylim(c(-0.02,0.01))

# net solar radiation
all_datas <- as.data.frame(all_data_import['FSAData'])  
colnames(all_datas) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')


all_data <- all_datas %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>%
  select('snow_cover','BC', 'dust','BC4','dust4') %>%
  melt(id=c("snow_cover"))

plot_2 <- all_data %>%
  ggplot(aes(x =snow_cover , y = value, fill = variable)) + 
  ylab(expression(bold(Delta~"(W/"*m^{2}*")"))) + 
  xlab('Snow cover fraction')  +
  ggtitle(expression(italic(R)["net"]^S)) + 
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0,hjust = 0.5),
        axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=10, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=8),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.15,0.4), 
        legend.direction = "vertical",
        legend.title = element_blank(),
        plot.margin = unit(c(0.3, 0, 0, 0), "cm")) +
  #scale_fill_manual() +
  scale_fill_brewer(palette = "Dark2", labels = c("Spheroid", "Hexagonal Plate","Koch Snowflake")) +
  scale_x_discrete(labels = c('0.0-0.2','0.2-0.4','0.4-0.6','0.6-0.8','0.8~1.0')) + 
  ylim(c(-1,5))

# surface temperature
all_datas <- as.data.frame(all_data_import['SurfacetemperatureData'])  
colnames(all_datas) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')


all_data <- all_datas %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>%
  select('snow_cover', 'BC', 'dust','BC4','dust4') %>%
  melt(id=c("snow_cover"))

plot_3 <- all_data %>%
  ggplot(aes(x =snow_cover , y = value, fill = variable)) + 
  ylab(expression(bold(Delta~(K)))) + 
  xlab('Snow cover fraction')  +
  ggtitle(expression(italic(T)["sur"])) + 
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0,hjust = 0.5),
        axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=10, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=8),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.15,0.4), 
        legend.direction = "vertical",
        legend.title = element_blank(),
        plot.margin = unit(c(0.3, 0, 0, 0), "cm")) +
  #scale_fill_manual() +
  scale_fill_brewer(palette = "Dark2", labels = c("Spheroid", "Hexagonal Plate","Koch Snowflake")) +
  scale_x_discrete(labels = c('0.0-0.2','0.2-0.4','0.4-0.6','0.6-0.8','0.8~1.0')) + 
  ylim(c(-0.1,0.5))

# import data latent heat flux
all_datas <- as.data.frame(all_data_import['LHData'])  
colnames(all_datas) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')


all_data <- all_datas %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>%
  select('snow_cover', 'BC', 'dust','BC4','dust4') %>%
  melt(id=c("snow_cover"))

plot_4 <- all_data %>%
  ggplot(aes(x =snow_cover , y = value, fill = variable)) + 
  ylab(expression(bold(Delta~"(W/"*m^{2}*")"))) + 
  xlab(expression(italic(f)["sno"])) +
  ggtitle(expression(italic(F)["lat"])) + 
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0,hjust = 0.5),
        axis.title.x=element_blank(),
        axis.text.x = element_text(color="black",size=10, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=8),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.2,0.2), 
        legend.direction = "horizontal",
        legend.title = element_blank(),
        plot.margin = unit(c(0.3, 0, 0, 0), "cm")) +
  #scale_fill_manual(labels = c("shape1", "shape","shape2","BC","dust")) +
  scale_fill_brewer(palette = "Dark2") +
  scale_x_discrete(labels = c('0.0-0.2','0.2-0.4','0.4-0.6','0.6-0.8','0.8~1.0'))+ 
  ylim(c(-0.5,2.5))

# import data
all_datas <- as.data.frame(all_data_import['SHData'])  
colnames(all_datas) <- c('elevation','snow_filter','snow_cover', 'shape1', 'shape2', 'shape3', 'shape4', 'BC', 'dust','BC4','dust4')

all_data <- all_datas %>% 
  mutate(snow_cover = factor(snow_cover)) %>%
  filter(elevation>1500) %>%
  filter(snow_filter>0.01) %>%
  select('snow_cover', 'BC', 'dust','BC4','dust4') %>%
  melt(id=c("snow_cover"))

plot_5 <- all_data %>%
  ggplot(aes(x =snow_cover , y = value, fill = variable)) + 
  ylab(expression(bold(Delta~"(W/"*m^{2}*")"))) + 
  xlab(expression(italic(f)["sno"]))  +
  ggtitle(expression(italic(F)["sen"])) + 
  #stat_boxplot(geom ='errorbar', width = 0.6, size = 0.5, show.legend = FALSE) +
  geom_boxplot(size = 0.3, show.legend = F, width = 0.6, outlier.shape = 1,outlier.size = 0.1, outlier.alpha = 0, position = position_dodge(width = 0.75)) + 
  #geom_jitter(trim = FALSE) +
  stat_summary(fun=mean, geom="point", size=1, color="red", show.legend = FALSE,position = position_dodge(width = 0.75)) + 
  #geom_boxplot(width=0.1) + 
  theme_classic() + 
  theme(plot.title = element_text(face="bold", color="black",size=11, angle=0,hjust = 0.5),
        axis.title.x=element_text(color="black",size=10, angle=0),
        axis.text.x = element_text(color="black",size=10, angle=0),
        axis.text.y = element_text( color="black", size=10, angle=0),
        axis.title.y = element_text(face="bold", color="black",size=8),
        axis.line = element_line(size = 0.5),
        legend.position = c(0.2,0.2), 
        legend.direction = "horizontal",
        legend.title = element_blank(),
        plot.margin = unit(c(0.3, 0, 0, 0), "cm")) +
  # scale_fill_manual(labels = c("shape1", "shape","shape2","BC","dust")) +
  scale_fill_brewer(palette = "Dark2") +
  scale_x_discrete(labels = c('0.0-0.2','0.2-0.4','0.4-0.6','0.6-0.8','0.8~1.0'))+  
  ylim(c(-0.5,2.5))

plot_legend <- get_legend(
  plot_1 + 
    guides(color = guide_legend(nrow = 1)) +
    theme(legend.position = "bottom")
)

plot_figure <- plot_grid(   plot_1 + theme(legend.position="none"),plot_2,plot_3,
                            plot_4,plot_5,plot_legend,
                            labels = c("(a)", "(b)","(c)","(d)","(e)"),
                            #%vjust = 0,
                            label_size = 12,
                            
                            nrow = 3, ncol = 2, align = 'v')

ggsave(paste0(Season,"_Energy_mixing_comparison_TP_revise.tiff"), plot = plot_figure, width = 18, height = 15, units = "cm", dpi = 300, limitsize = FALSE, compression = "lzw")

}
