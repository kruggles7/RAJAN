%make heatmaps out of the relative risk matrix 

cd .. 
cd .. 
cd matrices
load OR_2013_HISPANIC_GIRLS_MentalHealth 
load qlabel_090914.mat
cd ..
cd programs
cd clustergrams
cd results
xlab={'2013', '2011', '2009', '2007', '2005', '2003'}; 
ques={'Q11'; 'Q12'; 'Q13'; 'Q14'; 'Q15'; 'Q16'}; 


lab=odds_ratio_cell(:,2); 
P=odds_ratio_cell(:,4:9); 
P2=cell.empty; 
qlabel2=cell.empty; 
[rl,cl]=size(qlabel); 
counter=1; 
for j=1:rl
    Q=qlabel{j,2}; 
    indx1=find(strcmp(Q,lab)==1); 
    indx2=find(strcmp(Q,ques)==1); 
    if (numel(indx1)>0  && numel(indx2)==0)
        P2(counter,:)=P(indx1,:); 
        qlabel2(counter,:)=qlabel(j,:); 
        counter=counter+1; 
    end 

end 
%replace NaN with -10000
indx=find(strcmp(P2,'NaN')==1); 
for j=1:numel(indx)
    P2{indx(j)}=-10000; 
end 
indx=find(strcmp(P2,'Inf')==1); 
for j=1:numel(indx)
    P2{indx(j)}=10000; 
end 
emptycells=cellfun(@isempty, P2); 
[r,c]=size(emptycells); 
for j=1:r
    for k=1:c
        if (emptycells(j,k)==1)
            P2{j,k}=-10000; 
        end
    end
end
plot_mat=cell2mat(P2); 
[r,c]=size(plot_mat); 

q2=odds_ratio_cell(indx,2);
q2_=cell(length(q2)-1,1); 
for p=1:length(q2)-1
    s=q2{p,1}; 
    q2_{p,1}=s(2:3); 
end  
plot_mat=rot90(plot_mat);
[r,c]=size(plot_mat);
plot_mat(plot_mat==-10000)=NaN; 
plot_mat3=plot_mat; 
xlab_new=xlab; 
qlab_new=qlabel2(:,1); 

%create 3rd matrix without the maximum values 
[r,c]=size(plot_mat3); 
plot_mat3(isinf(plot_mat3)==1)=-10000 ; 
plot_mat3(plot_mat3==10000)=-10000; 
for j=1:r
    maxv=nanmax(plot_mat3(j,:)); 
    indx_inf=find(plot_mat3(j,:)==-10000); 
    if numel(indx_inf)>0
        plot_mat3(j,indx_inf)=maxv; 
    end 
end
%median center
for j=1:r
    med=nanmedian(plot_mat3(j,:)); 
    plot_mat3(j,:)=plot_mat3(j,:)/med; 
end 
log_rel_risk=log2(plot_mat3); 
for j=1:r
    temp=log_rel_risk(j,:); 
    minv=min(temp); 
    indx3=find(log_rel_risk(j,:)<-100000); 
    log_rel_risk(j,indx3)=minv; 
end 
for j=1:r
    for k=1:c
        if isnan(log_rel_risk(j,k))==1
            log_rel_risk(j,k)=nanmean(log_rel_risk(:,k)); 
        end 
    end 
end 
cg=clustergram(log_rel_risk,'RowLabels', xlab_new, 'ColumnLabels',qlab_new,'Cluster',2, 'Colormap','jet', 'DisplayRange',3, 'Symmetric','true'); 
fig=plot(cg); 
%tightfig; 
print (gcf,'-dpng','clustermap_OR_mentalhealth_HG.png'); 
saveas(gcf,'clustermap_OR_mentalhealth_HG.fig');
close all 

%%FOR ALL----------------------------------------------------------------
cd .. 
cd .. 
cd ..
cd matrices
load OR_2013_ALL_MentalHealth 
load qlabel_090914.mat
cd ..
cd programs
cd clustergrams
cd results
xlab={'2013', '2011', '2009', '2007', '2005', '2003'}; 
ques={'Q11'; 'Q12'; 'Q13'; 'Q14'; 'Q15'; 'Q16'}; 


lab=odds_ratio_cell(:,2); 
P=odds_ratio_cell(:,4:9); 
P2=cell.empty; 
qlabel2=cell.empty; 
[rl,cl]=size(qlabel); 
counter=1; 
for j=1:rl
    Q=qlabel{j,2}; 
    indx1=find(strcmp(Q,lab)==1); 
    indx2=find(strcmp(Q,ques)==1); 
    if (numel(indx1)>0  && numel(indx2)==0)
        P2(counter,:)=P(indx1,:); 
        qlabel2(counter,:)=qlabel(j,:); 
        counter=counter+1; 
    end 

end 
%replace NaN with -10000
indx=find(strcmp(P2,'NaN')==1); 
for j=1:numel(indx)
    P2{indx(j)}=-10000; 
end 
indx=find(strcmp(P2,'Inf')==1); 
for j=1:numel(indx)
    P2{indx(j)}=10000; 
end 
emptycells=cellfun(@isempty, P2); 
[r,c]=size(emptycells); 
for j=1:r
    for k=1:c
        if (emptycells(j,k)==1)
            P2{j,k}=-10000; 
        end
    end
end
plot_mat=cell2mat(P2); 
[r,c]=size(plot_mat); 

q2=odds_ratio_cell(indx,2);
q2_=cell(length(q2)-1,1); 
for p=1:length(q2)-1
    s=q2{p,1}; 
    q2_{p,1}=s(2:3); 
end  
plot_mat=rot90(plot_mat);
[r,c]=size(plot_mat);
plot_mat(plot_mat==-10000)=NaN; 
plot_mat3=plot_mat; 
xlab_new=xlab; 
qlab_new=qlabel2(:,1); 

%create 3rd matrix without the maximum values 
[r,c]=size(plot_mat3); 
plot_mat3(isinf(plot_mat3)==1)=-10000 ; 
plot_mat3(plot_mat3==10000)=-10000; 
for j=1:r
    maxv=nanmax(plot_mat3(j,:)); 
    indx_inf=find(plot_mat3(j,:)==-10000); 
    if numel(indx_inf)>0
        plot_mat3(j,indx_inf)=maxv; 
    end 
end
%median center
for j=1:r
    med=nanmedian(plot_mat3(j,:)); 
    plot_mat3(j,:)=plot_mat3(j,:)/med; 
end 
log_rel_risk=log2(plot_mat3); 
for j=1:r
    temp=log_rel_risk(j,:); 
    minv=min(temp); 
    indx3=find(log_rel_risk(j,:)<-100000); 
    log_rel_risk(j,indx3)=minv; 
end 
for j=1:r
    for k=1:c
        if isnan(log_rel_risk(j,k))==1
            log_rel_risk(j,k)=nanmean(log_rel_risk(:,k)); 
        end 
    end 
end 
cg=clustergram(log_rel_risk,'RowLabels', xlab_new, 'ColumnLabels',qlab_new,'Cluster',2, 'Colormap','jet', 'DisplayRange',3, 'Symmetric','true'); 
fig=plot(cg); 
%tightfig; 
print (gcf,'-dpng','clustermap_OR_mentalhealth_all.png'); 
saveas(gcf,'clustermap_OR_mentalhealth_all.fig');


