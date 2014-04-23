%make heatmaps out of the relative risk matrix 
years={'2001', '2003', '2005', '2007', '2009', '2011'}; 

%remake cell for each year 
q1=rel_risk_cell(:,1); 
q2=rel_risk_cell(:,2); 
q_num=q2(1:66,1);
xlab=q2(1:66); 
rel_risk=zeros(66,66); 

for j=6%:6
    for i=1:length(q_num)
        q_char=str2double(q_num{i}); 
        indx1=find(strcmp(q1(:),q_num{i})==1); 
        n=1; 
        for k=1:length(indx1)
            indx=indx1(k); 
            rel_risk(n,i)=rel_risk_cell{indx,j+2}; 
            n=n+1; 
        end 
    end 
    rel_risk2=rel_risk; 
    indx2=find(isinf(rel_risk2)==1); 
    rel_risk2(indx2)=-1; 
    maxv=max(max(rel_risk2)); 
    rel_risk2(indx2)=maxv; 
    dim=size(rel_risk2); 
    pcs=dim(1)*dim(2); 
    average=sum(rel_risk2(:))/pcs; 
    av_mat=rel_risk2-average; 
%     cg=clustergram(av_mat,'RowLabels',xlab, 'ColumnLabels',xlab); 
%     fig=plot(cg); 
%     tightfig; 
     year1=years{j}; 
%     print (gcf,'-dpng',[year '_clustergram.png']); 
%     close
    log_rel_risk=log2(rel_risk2); 
    indx2=find(isinf(log_rel_risk)==1); 
    log_rel_risk(indx2)=-1;
    maxv=max(max(log_rel_risk)); 
    log_rel_risk(indx2)=maxv; 
    indx3=find(log_rel_risk<-100000); 
    log_rel_risk(indx3)=-1;
    minv=min(min(log_rel_risk)); 
    log_rel_risk(indx3)=minv; 
    cg2=clustergram(log_rel_risk,'RowLabels', xlab, 'ColumnLabels',xlab, 'Colormap','jet'); 
    %fig2=plot(cg2); 
    %tightfig; 
    %colorbar('NorthOutside'); 
    %set(cg2, 'Dendrogram', 1)
    print (gcf, '-dmeta', [year1 '_clustergram2.emf']); 
    %close
end 
