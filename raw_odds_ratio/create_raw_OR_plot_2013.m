%make heatmaps out of the relative risk matrix 
cd .. 
cd .. 
cd matrices
load OR_2013.mat
load qlabel_090914.mat
cd ..
xlab={'2001', '2003', '2005', '2007', '2009', '2011', '2013'}; 

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
for i=1:82
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
            lab=odds_ratio_cell(indx,2); 
            P=odds_ratio_cell(indx,3:9); 
            P2=cell.empty; 
            qlabel2=cell.empty; 
            [rl,cl]=size(qlabel); 
            counter=1; 
            for j=1:rl
                indx=find(strcmp(qlabel{j,2},lab)==1); 
                if numel(indx)>0
                    P2(counter,:)=P(indx,:); 
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
            plot_mat(plot_mat==-10000)=NaN; 
            plot_mat(plot_mat==10000)=NaN; 
           
            q2=odds_ratio_cell(indx,2);
            q2_=cell(length(q2)-1,1); 
            for p=1:length(q2)-1
                s=q2{p,1}; 
                q2_{p,1}=s(2:3); 
            end  
            plot_mat=rot90(plot_mat);
            plot_mat=flipud(plot_mat); 
            indx=find(isinf(plot_mat(1,:))==0); 
            plot_mat2=plot_mat(:,indx); 
            qlabel3=qlabel2(indx,:); 
            [r,c]=size(plot_mat2); 
            x=[2001 2003 2005 2007 2009 2011 2013]; 
            for j=1:c
                if min(plot_mat2(:,j))<1
                    color=[97/255 97/255 97/255]; %grey2
                elseif min(plot_mat2(:,j))<2 
                    color=[24/255 116/255 205/255]; %blue
                elseif min(plot_mat2(:,j))<4
                    color=[0/255 205/255 102/255]; %green
                elseif min(plot_mat2(:,j))<8
                    color=[255/255 127/255 0/255]; %orange
                else 
                    color=[205/255 0/255 0/255]; %red
                end 
                plot(x, plot_mat2(:,j),'Marker','o', 'MarkerFaceColor', color, 'MarkerSize', 2, 'Color', color ); 
                hold on
            end 
            hold off
            set(gca,'XTick', [2001 2003 2005 2007 2009 2011 2013]); 
            xlim([2001 2013]); 
        end 
        %close 
    end 
end 

cd programs
cd raw_odds_ratio

print (gcf, '-dpng', [ques '_raw_OR_plot_2001_2013']); 
plot_mat3=rot90(plot_mat2); 
plot_mat3=rot90(plot_mat3); 
plot_mat3=rot90(plot_mat3); 
plot_mat3=fliplr(plot_mat3); 