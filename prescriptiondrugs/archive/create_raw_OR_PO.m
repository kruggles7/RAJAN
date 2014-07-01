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

purple_grey=[99/255 86/255 136/255];
light_purple=[106/255 90/255 205/255];
green_blue=[67/255 205/255 128/255];
green=[0/255 205/255 102/255];
orange=[255/255 127/255 0/255];
blue=[24/255 116/255 205/255];
salmon=[205/255 51/255 51/255];
mauve=[205/255 96/255 144/255];
magenta=[205/255 41/255 144/255]; 
grey1=[192/255 192/255 192/255]; 
grey2=[97/255 97/255 97/255]; 
 
q1='Q79'; 

plot_mat=cell2mat(OR(:,2:5));  
plot_mat=rot90(plot_mat);
indx=find(isinf(plot_mat(1,:))==0); 
plot_mat2=plot_mat(:,indx); 
qlabel2=qlabel(indx,:); 
[r,c]=size(plot_mat2); 
x=[1 2 3 4]; 
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
set(gca,'XTick', [1 2 3 4]); 

cd programs
cd prescriptiondrugs
cd results

saveas (gcf,'PO_raw_OR_grades.fig'); 
plot_mat3=rot90(plot_mat2); 
plot_mat3=rot90(plot_mat3); 
plot_mat3=rot90(plot_mat3); 