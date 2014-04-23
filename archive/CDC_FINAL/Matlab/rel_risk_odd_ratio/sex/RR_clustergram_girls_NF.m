xlab={'2001', '2003', '2005', '2007', '2009', '2011'};

plot_mat=cell2mat(girls_RR_cell(:,2:7)); 
q=girls_RR_cell(:,1); 
indx2=find(isinf(plot_mat)==1); 
plot_mat(indx2)=-1; 
maxv=max(max(plot_mat)); 
plot_mat(indx2)=maxv; 

dim=size(plot_mat);
pcs=dim(1)*dim(2);
average=sum(plot_mat(:))/pcs;

av_mat=plot_mat-average;

cg=clustergram(av_mat,'RowLabels',q, 'ColumnLabels', xlab); 
fig=plot(cg); 
tightfig; 
print (gcf, '-dpng',['girls_clustergram.png']);