%make heatmaps out of the relative risk matrix 
xlab={'2001', '2003', '2005', '2007', '2009', '2011'}; 

for i=1:70
    i_char=num2str(i); 
    q1=['Q' i_char]; 
    indx=find (strcmp(rel_risk_cell(:,1),i_char)==1); 
    if isempty(indx)==0
        plot_mat=cell2mat(rel_risk_cell(indx,3:8)); 
        q2=rel_risk_cell(indx,2); 
        indx2=find(isinf(plot_mat)==1); 
		plot_mat(indx2)=-1; 
		maxv=max(max(plot_mat)); 
        plot_mat(indx2)=maxv;
		
		dim=size(plot_mat);
		pcs=dim(1)*dim(2);
		average=sum(plot_mat(:))/pcs;
		
		av_mat=plot_mat-average;
        cg=clustergram(av_mat,'RowLabels',q2, 'ColumnLabels', xlab); 
        fig=plot(cg); 
        tightfig; 
        print (gcf,'-dpng',[q1 '_clustermap.png']); 
    end 
    close 
end 