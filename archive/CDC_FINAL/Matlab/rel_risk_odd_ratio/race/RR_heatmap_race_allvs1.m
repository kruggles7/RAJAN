%chose any races you want, will get relative risk of that race compared to not that race (ie. any other race)

race='B'; %black  %%can be replaced by W B H or O

[race_RR_cell] = rel_risk_race_allvs1 (race);

xlab={'2001', '2003', '2005', '2007', '2009', '2011'};

plot_mat=cell2mat(race_RR_cell(:,2:7)); 
q=race_RR_cell(:,1); 
indx2=find(isinf(plot_mat)==1); 
maxv=max(max(plot_mat)); 
plot_mat(indx2)=maxv; 
heatmap2(plot_mat,xlab,q,[],'Colormap','gray', 'ColorBar', 1, 'ShowAllTicks',1,'TickFontSize',8); 
print (gcf, '-dpng',[race '_RR_heatmap.png']); 