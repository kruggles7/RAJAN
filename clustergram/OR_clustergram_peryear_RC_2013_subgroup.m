%make heatmaps out of the relative risk matrix  
lab='hispanic_girls'; 
years={'2001', '2003', '2005', '2007', '2009', '2011', '2013'}; 
cd ..
cd ..
cd matrices
load OR_2013_HISPANIC_GIRLS.mat 
load qlabel_090914.mat
load order_090914.mat
cd ..
cd programs
cd clustergrams

%remake cell for each year 
q1=odds_ratio_cell(:,1); 
q2=odds_ratio_cell(:,2);
q_num=q2(1:64,1);
xlab=q_num; 
rel_risk=double.empty; 
xlab_=cell.empty; 

for j=7
    for i=1:length(q_num)
        q_char=(q_num{i}) ;
        indx1=find(strcmp(q1(:),q_char)==1); 
        n=1; 
        for k=1:length(indx1)
            indx=indx1(k); 
            if isempty(odds_ratio_cell{indx,j+2})==0
                rel_risk(n,i)=odds_ratio_cell{indx,j+2};  
            end 
            n=n+1;
        end 
    end 
    sum_column=sum(rel_risk); 
    indx_0=find(sum_column>0); 
    rel_risk_=rel_risk(indx_0, indx_0); 
    xlab_=xlab(indx_0); 
    qlabel_=qlabel(indx_0,:); 
    
    [r,c]=size(rel_risk_); 
    rel_risk2=zeros(r,c);
    qlabel2=cell(r,1); 
    m=1; 
    for i=1:length(order); 
        in=find(strcmp(qlabel_(:,2),order{i})==1); 
        if numel(in)>0
            rel_risk2(m,:)=rel_risk_(in,:); %reorder by group
            qlabel2(m,1)=qlabel_(in,1); 
            m=m+1; 
        end
    end  
    rel_risk3=rel_risk2; 
    rawOR=flipud(rel_risk3); 
%     T=rel_risk2; 
%     indx=find(isinf(T)==1); 
%     T(indx)=-1; 
%     maxv=max(max(T)); 
%     rel_risk2(indx)=maxv; 
    for i=1:r
        temp_mat=rel_risk2(i,:); 
        noinf=temp_mat; 
        indx=find(isinf(noinf)==1); 
        noinf(indx)=-1; 
        maxv=max(noinf); 
        temp_mat(indx)=maxv; 
        rel_risk2(i,:)=temp_mat;  
    end 
    [r,c]=size(rel_risk2);
    %med=median(rel_risk_2,2); 
    for i=1:r
        med=median(rel_risk2(i,:)); 
        rel_risk2(i,:)=rel_risk2(i,:)/med; 
        %indx2=find(isinf(rel_risk2(:,i))==1); 
        %rel_risk2(indx2,i)=maxv(i); 
    end 
    log_rel_risk=log2(rel_risk2);
    normOR=flipud(log_rel_risk); 
    qlab=qlabel_(:,1);
    for i=1:r
        temp=log_rel_risk(i,:); 
        minv=min(temp); 
        indx3=find(log_rel_risk(i,:)<-100000); 
        log_rel_risk(i,indx3)=minv; 
        indx3=find(isinf(log_rel_risk(i,:))==1); 
        log_rel_risk(i,indx3)=maxv; 
    end 
    names=flipud(qlabel2); 
    cg2=clustergram(log_rel_risk,'ColumnLabels',qlab,'Cluster',2, 'Colormap','jet', 'DisplayRange',3); 
    fig2=plot(cg2); 
    set(gcf, 'Renderer', 'Painters');
    print (gcf, '-dpdf', [years{j} '_clustergram_OR_' lab]); 
    saveas (gcf, [years{j} '_clustergram_OR_' lab '.fig']); 
end 
