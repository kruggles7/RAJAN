%make heatmaps out of the relative risk matrix 
cd .. 
cd ..
cd matrices
load OR_79_20
load qlabel_031214
cd ..
cd programs
cd prescriptiondrugs
cd results
xlab={ '2009', '2011'}; 
odds_ratio_cell=OR_79; 
ques='Q79'; 
for i=1:80
    i_char=num2str(i); 
    q1_=i_char; 
    num2=i; 
    if length(i_char)<2
        i_char=['0' i_char]; 
    end 
    q1=['Q' i_char]; 
    if strcmp(q1,ques)==1
        indx=find (strcmp(odds_ratio_cell(:,1),q1)==1); 
        if isempty(indx)==0
            plot_mat=cell2mat(odds_ratio_cell(indx,3:4)); 
            q2=odds_ratio_cell(indx,2);
            q2_=cell(length(q2)-1,1); 
            for p=1:length(q2)-1
                s=q2{p,1}; 
                q2_{p,1}=s(2:3); 
            end  
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
            %qqplot_figs(log_rel_risk, [ q1 '_log']); 
            cg=clustergram(log_rel_risk,'RowLabels', xlab, 'ColumnLabels',qlabel(:,1),'Cluster',2, 'Colormap','jet', 'DisplayRange',3, 'Symmetric','true'); 
    %         fig=plot(cg); 
    %         tightfig; 
    %         print (gcf,'-dmeta',[q1 '_clustermap_OR_RC_LOG.emf']); 
    %         cg=clustergram(plot_mat,'RowLabels',qlabel, 'ColumnLabels', xlab, 'ColorMap', 'jet'); 
    %         fig=plot(cg); 
    %         tightfig; 
    %         print (gcf,'-dmeta',[q1 '_clustermap_OR_RC.emf']);
            %hm=HeatMap(log_rel_risk,'RowLabels',q2_, 'ColumnLabels', xlab, 'ColorMap', 'jet'); 
        end 
        %close 
    end 
end 