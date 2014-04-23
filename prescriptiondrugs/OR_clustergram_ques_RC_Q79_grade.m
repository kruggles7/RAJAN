%make heatmaps out of the relative risk matrix 
cd ..
cd ..
cd matrices
load OR_79_grade
load qlabel_033014
cd ..
xlab={ '9th','10th', '11th', '12th'}; 
ques='Q79'; 
OR=odds_ratio_cell; 
[r,c]=size(OR); 
OR=OR(2:r,:); 
indx=find(strcmp(OR(:,1),'Q79')==0); 
OR=OR(indx,:); 
indx=find(strcmp(OR(:,1),'Q56')==0); 
OR=OR(indx,:); 
indx=find(strcmp(OR(:,1),'Q36')==0); 
OR=OR(indx,:); 
indx=find(strcmp(OR(:,1),'Q37')==0); 
OR=OR(indx,:); 
indx=find(strcmp(OR(:,1),'Q54')==0); 
OR=OR(indx,:); 
indx=find(strcmp(OR(:,1),'Q63')==0); 
OR=OR(indx,:); 
indx=find(strcmp(OR(:,1),'Q68')==0); 
OR=OR(indx,:); 
indx=find(strcmp(OR(:,1),'Q69')==0); 
OR=OR(indx,:); 
indx=find(strcmp(OR(:,1),'Q76')==0); 
OR=OR(indx,:);

[r,c]=size(OR); 

plot_mat=cell2mat(OR(:,2:5)); 
plot_mat=rot90(plot_mat);
[r,c]=size(plot_mat); 
plot_mat2=plot_mat;
%qqplot_figs(plot_mat2, [ q1 '_raw']); 
for j=1:r
    temp_mat=plot_mat(j,:); 
    noinf=temp_mat; 
    indx=find(isinf(noinf)==1); 
    noinf(indx)=-1; 
    maxv=max(noinf); 
    temp_mat(indx)=maxv; 
    plot_mat(j,:)=temp_mat; 
end
%median center
med=median(plot_mat,2); 
for j=1:r
    med=median(plot_mat(j,:)); 
    plot_mat(j,:)=plot_mat(j,:)/med; 
end 
log_rel_risk=log2(plot_mat); 
for j=1:r
    temp=log_rel_risk(j,:); 
    minv=min(temp); 
    indx3=find(log_rel_risk(j,:)<-100000); 
    log_rel_risk(j,indx3)=minv; 
end 
xlab=fliplr(xlab); 
cg=clustergram(log_rel_risk,'RowLabels', xlab, 'ColumnLabels',qlabel(:,1),'Cluster',2, 'Colormap','jet', 'DisplayRange',3, 'Symmetric','true'); 
%         fig=plot(cg); 
%         tightfig; 
%         print (gcf,'-dmeta',[q1 '_clustermap_OR_RC_LOG.emf']); 
%         cg=clustergram(plot_mat,'RowLabels',qlabel, 'ColumnLabels', xlab, 'ColorMap', 'jet'); 
%         fig=plot(cg); 
%         tightfig; 
%         print (gcf,'-dmeta',[q1 '_clustermap_OR_RC.emf']);
%hm=HeatMap(log_rel_risk,'RowLabels',q2_, 'ColumnLabels', xlab, 'ColorMap', 'jet'); 
