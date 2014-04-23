%make heatmaps out of the relative risk matrix 
years={'2001', '2003', '2005', '2007', '2009', '2011'}; 

indx2=find(strcmp(odds_ratio_cell(:,2),'Q32')~=1 & strcmp(odds_ratio_cell(:,2),'Q16')~=1  & strcmp(odds_ratio_cell(:,2),'Q53')~=1 & strcmp(odds_ratio_cell(:,2),'Q17')~=1 & strcmp(odds_ratio_cell(:,2),'Q22')~=1 & strcmp(odds_ratio_cell(:,2),'Q55')~=1 & strcmp(odds_ratio_cell(:,2),'Q56')~=1 & strcmp(odds_ratio_cell(:,2),'Q68')~=1 & strcmp(odds_ratio_cell(:,2),'Q69')~=1);
odds_ratio_cell=odds_ratio_cell(indx2,:); 

indx2=find(strcmp(odds_ratio_cell(:,1),'Q32')~=1 & strcmp(odds_ratio_cell(:,1),'Q16')~=1  & strcmp(odds_ratio_cell(:,1),'Q53')~=1 & strcmp(odds_ratio_cell(:,1),'Q17')~=1 & strcmp(odds_ratio_cell(:,1),'Q22')~=1 & strcmp(odds_ratio_cell(:,1),'Q55')~=1 & strcmp(odds_ratio_cell(:,1),'Q56')~=1 & strcmp(odds_ratio_cell(:,1),'Q68')~=1 & strcmp(odds_ratio_cell(:,1),'Q69')~=1);
odds_ratio_cell=odds_ratio_cell(indx2,:); 

%remake cell for each year 
q1=odds_ratio_cell(:,1); 
q2=odds_ratio_cell(:,2);
q_num=q2(1:52,1);
xlab=q_num; 
%rel_risk=zeros(66,66); 
rel_risk=double.empty; 

for j=6
    for i=1:length(q_num)
        q_char=(q_num{i}) ;
        indx1=find(strcmp(q1(:),q_char)==1); 
        n=1; 
        for k=1:length(indx1)
            indx=indx1(k); 
            rel_risk(n,i)=odds_ratio_cell{indx,j+2}; 
            n=n+1; 
        end 
    end 
    rel_risk2=rel_risk; 
    indx2=find(isinf(rel_risk2)==1); 
    rel_risk2(indx2)=-1; 
    maxv=max(max(rel_risk2)); 
    rel_risk2(indx2)=maxv;
    log_rel_risk=log2(rel_risk2); 
    indx3=find(log_rel_risk<-100000); 
    minv=min(min(log_rel_risk)); 
    log_rel_risk(indx3)=minv; 
    cg2=clustergram(log_rel_risk,'RowLabels', xlab, 'ColumnLabels',xlab, 'Colormap','jet'); 
    fig2=plot(cg2); 
    tightfig; 
    print (gcf, '-dmeta', [years{j} '_clustergram_OR.emf']); 
    hm=HeatMap(log_rel_risk,'RowLabels',xlab, 'ColumnLabels', xlab, 'ColorMap', 'jet'); 
    %close
end 
