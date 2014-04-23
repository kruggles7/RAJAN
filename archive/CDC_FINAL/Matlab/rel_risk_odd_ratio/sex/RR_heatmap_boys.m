xlab={'2001', '2003', '2005', '2007', '2009', '2011'};

plot_mat=cell2mat(boys_RR_cell(:,2:7)); 
q=boys_RR_cell(:,1); 
indx2=find(isinf(plot_mat)==1); 
maxv=max(max(plot_mat)); 
plot_mat(indx2)=maxv; 
heatmap2(plot_mat,xlab,q,[],'Colormap','gray', 'ColorBar', 1, 'ShowAllTicks',1,'TickFontSize',8); 
print (gcf, '-dpng',['boys_heatmap.png']); 