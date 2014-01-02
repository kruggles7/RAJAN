%make heatmaps out of the relative risk matrix 
xlab={'2001', '2003', '2005', '2007', '2009', '2011'}; 
% cd matrices
% load rel_risk_RC_111413.mat
% load q_labels.mat
% cd ..

trends=double.empty; 
count=1; 
for i=1:80
    i_char=num2str(i); 
    q1_=i_char; 
    num2=i; 
    if length(i_char)<2
        i_char=['0' i_char]; 
    end 
    q1=['Q' i_char]; 
    indx=find (strcmp(odds_ratio_cell(:,1),q1)==1); 
    if isempty(indx)==0
        plot_mat=cell2mat(odds_ratio_cell(indx,3:8)); 
        q2=odds_ratio_cell(indx,2);
        q2_=cell(length(q2)-1,1); 
        for p=1:length(q2)-1
            s=q2{p,1}; 
            q2_{p,1}=s(2:3); 
        end  
        plot_mat=plot_mat(1:55,:); 
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
            
        %Complete the Trend analysis
        mat2001=plot_mat(6,:); 
        mat2011=plot_mat(1,:);
        mat2001=mat2001'; 
        mat2011=mat2011'; 
        delta(:,1)=mat2011(:,1)-mat2001(:,1); 
        for j=1:length(mat2001)
            delta(j,1)=delta(j,1)/mat2001(j,1); 
        end 
        d=delta(1:55,1)*100; 
        indxu=find(d>50); 
        indxd=find(d<-50); 
        n=1; 
        trends(:,count)=d; %NEED TO TAKE OUT ONE OF THE QUESTIONS (56,57)
        count=count+1; 
    end 
end

cg=clustergram(trends, 'ColorMap', 'jet', 'DisplayRange', 50, 'RowLabels',qlabel(:,1),'ColumnLabels',qlabel(:,1)); 






