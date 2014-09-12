%make heatmaps out of the relative risk matrix 
cd .. 
cd .. 
cd matrices
load rel_risk_RC_010414.mat
load q_labels_010414.mat
cd ..
xlab={'2001', '2003', '2005', '2007', '2009', '2011'}; 

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

ques=input ('Enter in the question number you want to use (ex. Q01): ', 's'); 
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
            plot_mat=cell2mat(odds_ratio_cell(indx,3:8)); 
            q2=odds_ratio_cell(indx,2);
            q2_=cell(length(q2)-1,1); 
            for p=1:length(q2)-1
                s=q2{p,1}; 
                q2_{p,1}=s(2:3); 
            end  
            plot_mat=plot_mat(1:55,:); 
            plot_mat=rot90(plot_mat);
            plot_mat=flipud(plot_mat); 
            indx=find(isinf(plot_mat(1,:))==0); 
            plot_mat2=plot_mat(:,indx); 
            qlabel2=qlabel(indx,:); 
            [r,c]=size(plot_mat2); 
            x=[2001 2003 2005 2007 2009 2011]; 
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
            set(gca,'XTick', [2001 2003 2005 2007 2009 2011]); 
            xlim([2001 2011]); 
        end 
        %close 
    end 
end 

print (gcf, '-dpng', [ques '_raw_OR_plot']); 
plot_mat3=rot90(plot_mat2); 
plot_mat3=rot90(plot_mat3); 
plot_mat3=rot90(plot_mat3); 