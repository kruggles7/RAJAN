%make heatmaps out of the relative risk matrix 
load odds_ratio_RC_girls.mat
load q_labels_010414.mat
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

ques1={'Q11' 'Q12' 'Q13' 'Q14' 'Q16'}; 
ques2={'Q38' 'Q39' 'Q40' 'Q09' 'Q10' 'Q67'}; 
qlabelF=cell.empty; 
for j=1:numel(ques1)
    q1=ques1{j}; 
    plot_mat=zeros(1,6); 
    table=cell.empty; 
    indx=find (strcmp(odds_ratio_cell(:,1),q1)==1); 
    if isempty(indx)==0
        for i=1:numel(ques2)
            q2=ques2{i}; 
            qlabelF{j,1}=q1; 
            qlabelF{j,2}=q2; 
            table{i,1}=q1; 
            table{i,2}=q2; 
            indx2=find(strcmp(odds_ratio_cell(:,2),q2)==1); 
            if isempty(indx2)==0
                indx3=intersect(indx,indx2); 
                plot_mat(i,:)=cell2mat(odds_ratio_cell(indx3,3:8)); 
                table(i,3:8)=odds_ratio_cell(indx3,3:8); 
            end 
        end 
        plot_mat=rot90(plot_mat);
        [r,c]=size(plot_mat); 
        x=[2001 2003 2005 2007 2009 2011]; 
        for k=1:c
            if k==1 %min(plot_mat(:,k))<1
                color=[97/255 97/255 97/255]; %grey2
            elseif k==2 %min(plot_mat(:,k))<2 
                color=[24/255 116/255 205/255]; %blue
            elseif k==3%min(plot_mat(:,k))<5
                color=[0/255 205/255 102/255]; %green
            elseif k==4 %min(plot_mat(:,k))<10
                color=[255/255 127/255 0/255]; %orange
            else 
                color=[205/255 0/255 0/255]; %red
            end 
            plot(x, plot_mat(:,k),'Marker','o', 'MarkerFaceColor', color, 'MarkerSize', 2, 'Color', color ); 
            hold on
        end 
        set(gca,'XTick', [2001 2003 2005 2007 2009 2011]); 
        hold off
        ylim([0 10]); 
        ylabel('Raw Odds Ratio'); 
        print (gcf,'-dpng', [ q1 '_OR_raw.png'] ); 
        
        %make heatmap table
        label_year={'2001', '2003','2005','2007','2009','2011'}; 
        label_cell2=table(:,2); 
        per_mat_map=cell2mat(table(:,3:8));
        max_mat=max(max(per_mat_map)); 
        if max_mat>5
            M=10; 
        elseif max_mat>2
            M=5; 
        else 
            M=2; 
        end 
        %get rid of deimals
        per_mat_map=per_mat_map*10; 
        per_mat_map=round(per_mat_map); 
        per_mat_map=per_mat_map/10; 
        for t=1:numel(label_cell2)
            indxt=find(strcmp(label_cell2{t},qlabel(:,2))==1); 
            table_lable{t}=qlabel{indxt,1};
        end 
        h=figure; 
        [hImage]=heatmap_rb(per_mat_map, label_year, table_lable, 1, M, 0, 'Colormap','money', 'UseLogColormap', false, 'ShowAllTicks',true, 'Colorbar',true,'TextColor','k', 'FontSize', 12); 
        %title (title1, 'FontSize', 12); 
        set (gca, 'FontSize',12); 
        %title(tabel_label); 
        print (gcf,'-dpng', [ q1 '_OR_heatmap.png'] ); %can make pdf, jnp, or jpg 
    end
end 
