%chose any 2 races you want, will get relative risk of the first compared to second

race1='B'; %black
race2='W'; %white

%filename=[race1 '_' race2];
%quest_mat=importdata('Q4--NaN.txt');
%[race_RR_cell] = rel_risk_race (quest_mat, filename, race1, race2);

[race_RR_cell] = rel_risk_race_2 (race1, race2);

xlab={'2001', '2003', '2005', '2007', '2009', '2011'};

plot_mat=cell2mat(race_RR_cell(:,2:7)); 
q=race_RR_cell(:,1); 
indx2=find(isinf(plot_mat)==1); 
maxv=max(max(plot_mat)); 
plot_mat(indx2)=maxv; 
heatmap2(plot_mat,xlab,q,[],'Colormap','gray', 'ColorBar', 1, 'ShowAllTicks',1,'TickFontSize',8); 
print (gcf, '-dpng',[race1 '_' race2 '_RR_heatmap.png']); 