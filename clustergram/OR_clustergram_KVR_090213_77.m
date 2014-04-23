%make heatmaps out of the relative risk matrix 
xlab={'2009', '2011'}; 
odds_ratio_cell=OR_cell; 

indx2=find(strcmp(odds_ratio_cell(:,2),'Q32')~=1 & strcmp(odds_ratio_cell(:,2),'Q16')~=1  & strcmp(odds_ratio_cell(:,2),'Q53')~=1 & strcmp(odds_ratio_cell(:,2),'Q17')~=1 & strcmp(odds_ratio_cell(:,2),'Q22')~=1 & strcmp(odds_ratio_cell(:,2),'Q55')~=1 & strcmp(odds_ratio_cell(:,2),'Q56')~=1 & strcmp(odds_ratio_cell(:,2),'Q68')~=1 & strcmp(odds_ratio_cell(:,2),'Q69')~=1);
odds_ratio_cell=odds_ratio_cell(indx2,:); 

indx2=find(strcmp(odds_ratio_cell(:,1),'Q32')~=1 & strcmp(odds_ratio_cell(:,1),'Q16')~=1  & strcmp(odds_ratio_cell(:,1),'Q53')~=1 & strcmp(odds_ratio_cell(:,1),'Q17')~=1 & strcmp(odds_ratio_cell(:,1),'Q22')~=1 & strcmp(odds_ratio_cell(:,1),'Q55')~=1 & strcmp(odds_ratio_cell(:,1),'Q56')~=1 & strcmp(odds_ratio_cell(:,1),'Q68')~=1 & strcmp(odds_ratio_cell(:,1),'Q69')~=1);
odds_ratio_cell=odds_ratio_cell(indx2,:); 

for i=77
    i_char=num2str(i); 
    q1_=i_char; 
    num2=i; 
    if (num2~=32 && num2~=16 && num2~=53 && num2~=17 && num2~=22 && num2~=55 && num2~=56 && num2~=68 && num2~=69);
        if length(i_char)<2
            i_char=['0' i_char]; 
        end 
        q1=['Q' i_char]; 
        indx=find (strcmp(odds_ratio_cell(:,1),q1)==1); 
        if isempty(indx)==0
            plot_mat=cell2mat(odds_ratio_cell(indx,3:4)); 
            q2=odds_ratio_cell(indx,2);
            q2_=cell(length(q2),1); 
            for p=1:length(q2)
                s=q2{p,1}; 
                q2_{p,1}=s(2:3); 
            end 
            indx2=find(isinf(plot_mat)==1); 
            plot_mat(indx2)=-1; 
            maxv=max(max(plot_mat)); 
            plot_mat(indx2)=maxv;
            log_rel_risk=log2(plot_mat); 
            indx3=find(log_rel_risk<-100000); 
            minv=min(min(log_rel_risk)); 
            log_rel_risk(indx3)=minv; 
            %cg=clustergram(log_rel_risk,'RowLabels',q2_, 'ColumnLabels', xlab, 'ColorMap', 'jet'); 
            fig=plot(cg); 
            tightfig; 
           % print (gcf,'-dmeta',[q1 '_clustermap_OR_090313.emf']); 
            %cg=clustergram(plot_mat,'RowLabels',q2_, 'ColumnLabels', xlab, 'ColorMap', 'jet'); 
            fig=plot(cg); 
            tightfig; 
            %print (gcf,'-dmeta',[q1 '_clustermap_OR_090313_nolog.emf']); 
            hm=HeatMap(log_rel_risk,'RowLabels',q2_,'ColumnLabels',xlab,'ColorMap','jet'); 
            %print (gcf, '-dmeta',[q1 '_heatmap_OR_090313.emf']); 
            %hm=HeatMap(plot_mat,'RowLabels',q2_,'ColumnLabels',xlab,'ColorMap','jet'); 
            %print (gcf, '-dmeta',[q1 '_heatmap_OR_090313_nolog.emf']); 
        end 
    end 
    close 
end 