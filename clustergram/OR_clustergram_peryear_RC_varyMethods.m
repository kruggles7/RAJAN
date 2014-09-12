%make heatmaps out of the relative risk matrix 
years={'2001', '2003', '2005', '2007', '2009', '2011'}; 
cd ..
cd ..
cd matrices
load rel_risk_RC_010414.mat 
load q_labels_010414.mat
load order.mat
cd ..

link={'average', 'centroid', 'complete', 'median', 'single', 'ward', 'weighted'}; 
dist={'euclidean', 'minkowski', 'chebychev', 'mahalanobis', 'cosine', 'correlation', 'spearman', 'hamming', 'jaccard'};
%remake cell for each year 
q1=odds_ratio_cell(:,1); 
q2=odds_ratio_cell(:,2);
q_num=q2(1:56,1);
xlab=q_num; 
rel_risk=double.empty; 
K=1; 

for j=6
    for L=1:numel(link)
        for D=1:numel(dist)
            for i=1:length(q_num)-1
                q_char=(q_num{i}) ;
                indx1=find(strcmp(q1(:),q_char)==1); 
                n=1; 
                for k=1:length(indx1)-1
                    indx=indx1(k); 
                    rel_risk(n,i)=odds_ratio_cell{indx,j+2}; 
                    n=n+1; 
                end 
            end 
            [r,c]=size(rel_risk); 
            rel_risk2=zeros(r,c);
            qlabel2=cell(r,1); 
            for i=1:length(order); 
                in=order(i); 
                rel_risk2(i,:)=rel_risk(in,:); %reorder by group
                qlabel2(i,1)=qlabel(in,1); 
            end  
            rel_risk3=rel_risk2; 
            rawOR=flipud(rel_risk3); 
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
            for i=1:r
                med=median(rel_risk2(i,:)); 
                rel_risk2(i,:)=rel_risk2(i,:)/med; 
            end 
            log_rel_risk=log2(rel_risk2);
            normOR=flipud(log_rel_risk); 
            for i=1:r
                temp=log_rel_risk(i,:); 
                minv=min(temp); 
                indx3=find(log_rel_risk(i,:)<-100000); 
                log_rel_risk(i,indx3)=minv; 
            end 
            clust{K,1}=link{L}; 
            clust{K,2}=dist{D}; 
            d=pdist(log_rel_risk,dist{D}); 
            Z=linkage(log_rel_risk, link{L}); 
            clust{K,3}=cluster(Z, 'cutoff', 1.151); 
            K=K+1; 

        end 
    end 
end 

r=zeros(63,56); 
for i=1:63
    a=clust{i,3}; 
    for j=1:56
        r(i,j)=a(j); 
    end 
end 
