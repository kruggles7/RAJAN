%make heatmaps out of the relative risk matrix  
lab='hispanic_girls'; 
years={'2003', '2005', '2007', '2009', '2011', '2013'}; 
cd ..
cd ..
cd matrices
load OR_2013_HISPANIC_GIRLS_MentalHealth 
load qlabel_090914.mat
load order_090914.mat
cd ..
cd programs
cd clustergrams

xlab={'2003', '2005', '2007', '2009', '2011', '2013'}; 

P2=odds_ratio_cell(:,4:9); 
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
plot_mat(plot_mat==-10000)=NaN; 
plot_mat(plot_mat==10000)=NaN; 
           
q2=odds_ratio_cell(:,2);
q2_=cell(length(q2)-1,1); 
for p=1:length(q2)-1
    s=q2{p,1}; 
    q2_{p,1}=s(2:3); 
end  

plot_mat=rot90(plot_mat);
plot_mat=flipud(plot_mat); 
indx=find(isinf(plot_mat(1,:))==0); 
plot_mat2=plot_mat(:,indx); 
qlabel2=qlabel(indx,:); 
[r,c]=size(plot_mat2); 
x=[2003 2005 2007 2009 2011 2013]; 
for j=1:c
    if min(plot_mat2(:,j))<1
        color=[97/255 97/255 97/255]; %grey2
    elseif min(plot_mat2(:,j))<2 
        color=[24/255 116/255 205/255]; %blue
    elseif min(plot_mat2(:,j))<5
        color=[0/255 205/255 102/255]; %green
    elseif min(plot_mat2(:,j))<10
        color=[255/255 127/255 0/255]; %orange
    else 
        color=[205/255 0/255 0/255]; %red
    end 
    plot(x, plot_mat2(:,j),'Marker','o', 'MarkerFaceColor', color, 'MarkerSize', 2, 'Color', color ); 
    hold on
end 
hold off
set(gca,'XTick', [2003 2005 2007 2009 2011 2013]); 
xlim([2003 2013]); 

print (gcf, '-dpng', 'raw_OR_mentalhealth_HG'); 
plot_mat3=rot90(plot_mat2); 
plot_mat3=rot90(plot_mat3); 
plot_mat_HG=rot90(plot_mat3); 
close all 

%ALL!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
years={'2003', '2005', '2007', '2009', '2011', '2013'}; 
cd ..
cd ..
cd matrices
load OR_2013_ALL_MentalHealth
load qlabel_090914.mat
load order_090914.mat
cd ..
cd programs
cd clustergrams

xlab={'2003', '2005', '2007', '2009', '2011', '2013'}; 

P2=odds_ratio_cell(:,4:9); 
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
plot_mat(plot_mat==-10000)=NaN; 
plot_mat(plot_mat==10000)=NaN; 
           
q2=odds_ratio_cell(:,2);
q2_=cell(length(q2)-1,1); 
for p=1:length(q2)-1
    s=q2{p,1}; 
    q2_{p,1}=s(2:3); 
end  

plot_mat=rot90(plot_mat);
plot_mat=flipud(plot_mat); 
indx=find(isinf(plot_mat(1,:))==0); 
plot_mat2=plot_mat(:,indx); 
qlabel2=qlabel(indx,:); 
[r,c]=size(plot_mat2); 
x=[2003 2005 2007 2009 2011 2013]; 
for j=1:c
    if min(plot_mat2(:,j))<1
        color=[97/255 97/255 97/255]; %grey2
    elseif min(plot_mat2(:,j))<2 
        color=[24/255 116/255 205/255]; %blue
    elseif min(plot_mat2(:,j))<5
        color=[0/255 205/255 102/255]; %green
    elseif min(plot_mat2(:,j))<10
        color=[255/255 127/255 0/255]; %orange
    else 
        color=[205/255 0/255 0/255]; %red
    end 
    plot(x, plot_mat2(:,j),'Marker','o', 'MarkerFaceColor', color, 'MarkerSize', 2, 'Color', color ); 
    hold on
end 
hold off
set(gca,'XTick', [2003 2005 2007 2009 2011 2013]); 
xlim([2003 2013]); 

print (gcf, '-dpng', 'raw_OR_mentalhealth_all'); 
plot_mat3=rot90(plot_mat2); 
plot_mat3=rot90(plot_mat3); 
plot_mat3=rot90(plot_mat3); 

%make a combination plot with both all and hispanic girls ---------------
%change the ranking based on most to least
median_OR=nanmedian(plot_mat_HG,2); 
[r,c]=size(plot_mat_HG); 
count=1; 
plot_mat_HG_=nan(r,c); 
plot_mat3_=nan(r,c); 
qlabels_=qlabel2;
for i=1:r
    max_=max(median_OR); 
    indx=find(median_OR==max_); 
    median_OR(indx)=0; 
    for j=1:numel(indx)
        plot_mat_HG_(count,:)=plot_mat_HG(indx(j),:); 
        plot_mat3_(count,:)=plot_mat3(indx(j),:); 
        qlabels_(count,:)=qlabel2(indx(j),:); 
        count=count+1; 
    end 
end 

[r,c]=size(plot_mat3_); 
n=1; 
for i=1:r
    x=[n n n n n n]; 
    scatter(x, plot_mat3_(i,:),7, 'b', 'fill'); 
    hold on
    n=n+1; x=[n n n n n n]; 
    scatter(x, plot_mat_HG_(i,:),7, 'm', 'fill'); 
    n=n+1;
    x=[n n]; 
    y=[0 100]; 
    plot (x,y, '-k'); 
    n=n+1; 
end 
ylim([0 50]); 
xticks_=1.5:3:r*3; 
set(gca, 'xtick', xticks_); 
set(gca, 'xticklabel', qlabels_(:,1)); 
rotateXLabels(gca,90)
