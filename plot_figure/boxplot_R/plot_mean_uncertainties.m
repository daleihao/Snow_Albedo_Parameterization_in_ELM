%5.8% and 5.1%


figure; 

subplot(121)
hold on
plot(1,fsno_winter(1),'ko','MarkerSize',10,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','k')

errorbar(0.95,fsno_winter(2),5.8/100/2,'s','MarkerSize',10,...
    'MarkerEdgeColor','red','MarkerFaceColor','red','color','red','CapSize',15,'linewidth',1)
errorbar(1.05,fsno_winter(3),5.1/100/2,'s','MarkerSize',10,...
    'MarkerEdgeColor','blue','MarkerFaceColor','blue','color','blue','CapSize',15,'linewidth',1)

plot(1.5,fsno_spring(1),'ko','MarkerSize',10,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','k')
errorbar(1.45,fsno_spring(2),5.8/100/2,'s','MarkerSize',10,...
    'MarkerEdgeColor','red','MarkerFaceColor','red','color','red','CapSize',15,'linewidth',1)
errorbar(1.55,fsno_spring(3),5.1/100/2,'s','MarkerSize',10,...
    'MarkerEdgeColor','blue','MarkerFaceColor','blue','color','blue','CapSize',15,'linewidth',1)
box on

ylabel('\itf\rm_{sno}')
text(0.82, 0.005*6,'(a)','fontsize',12,'fontweight','bold')

xlim([0.8 1.7])
ylim([0 0.6])
set(gca, 'linewidth',1,'fontsize',12,'xtick', [1 1.5],'xticklabel',{'Winter','Spring'})

subplot(122)
hold on
plot(1,delta_albedo_winter(1),'ko','MarkerSize',10,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','k')

errorbar(0.95,delta_albedo_winter(2),3.6/100/2*0.63,'s','MarkerSize',10,...
    'MarkerEdgeColor','red','MarkerFaceColor','red','color','red','CapSize',15,'linewidth',1)
errorbar(1.05,delta_albedo_winter(3),3.6/100/2*0.63,'s','MarkerSize',10,...
    'MarkerEdgeColor','blue','MarkerFaceColor','blue','color','blue','CapSize',15,'linewidth',1)

plot(1.5,delta_albedo_spring(1),'ko','MarkerSize',10,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','k')
errorbar(1.45,delta_albedo_spring(2),3.6/100/2*0.63,'s','MarkerSize',10,...
    'MarkerEdgeColor','red','MarkerFaceColor','red','color','red','CapSize',15,'linewidth',1)
errorbar(1.55,delta_albedo_spring(3),3.6/100/2*0.63,'s','MarkerSize',10,...
    'MarkerEdgeColor','blue','MarkerFaceColor','blue','color','blue','CapSize',15,'linewidth',1)

text(0.82, 0.005,'(b)','fontsize',12,'fontweight','bold')
legend('ELM','MODSCAG/MODDRFS','SPIReS','fontsize',8)
ylabel('SAR')
box on
xlim([0.8 1.7])
ylim([0 0.1])

set(gca, 'linewidth',1,'fontsize',12,'xtick', [1 1.5],'xticklabel',{'Winter','Spring'})

print(gcf, '-dtiff', '-r300', 'area_mean_uncertainty.tif')

close all

