%make heatmaps out of the relative risk matrix 
xlab={'2001', '2003', '2005', '2007', '2009', '2011'}; 
for i=1:70
    i_char=num2str(i); 
    q1=['Q' i_char]; 
    indx=find (strcmp(rel_risk_cell(:,1),q1)==1); 
    if isempty(indx)==0
        plot_mat=cell2mat(rel_risk_cell(indx,3:8)); 
        q2=rel_risk_cell(indx,2); 
        indx2=find(isinf(plot_mat)==1); 
		maxv=max(max(plot_mat)); 
        plot_mat(indx2)=maxv; 
        heatmap2(plot_mat,xlab,q2,[],'Colormap','gray', 'ColorBar', 1, 'ShowAllTicks',1,'TickFontSize',8); 
        print (gcf, '-dpng',[q1 '_RR_heatmap.png']); 
    end 
    close 
end 