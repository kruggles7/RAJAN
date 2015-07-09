%make heatmaps out of the relative risk matrix 
cd .. 
cd .. 
cd matrices
load OR_2013_HISPANIC_GIRLS.mat 
or_all=odds_ratio_cell; 
load qlabel_090914.mat
load OR_2013_HISPANIC_GIRLS
or_HG=odds_ratio_cell;
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
        indx_all=find (strcmp(or_all(:,1),q1)==1); 
        indx_HG=find(strcmp(or_HG(:,1),q1)==1); 
        if isempty(indx_all)==0 && isempty(indx_HG)==0
            lab=or_all(indx_all,2); 
            P=or_all(indx_all,3:9); 
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
           
            q2=or_all(indx,2);
            q2_=cell(length(q2)-1,1); 
            for p=1:length(q2)-1
                s=q2{p,1}; 
                q2_{p,1}=s(2:3); 
            end  
            plot_mat=rot90(plot_mat);
            plot_mat=flipud(plot_mat); 
            indx=find(isinf(plot_mat(1,:))==0); 
            plot_mat_all=plot_mat(:,indx); 
            qlabel_all=qlabel2(indx,:); 
            
            %hispanic girls matrix -----------------------
            lab=or_HG(indx_HG,2); 
            P=or_HG(indx_HG,3:9); 
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
           
            q2=or_HG(indx,2);
            q2_=cell(length(q2)-1,1); 
            for p=1:length(q2)-1
                s=q2{p,1}; 
                q2_{p,1}=s(2:3); 
            end  
            plot_mat=rot90(plot_mat);
            plot_mat=flipud(plot_mat); 
            indx=find(isinf(plot_mat)==1); 
            plot_mat(indx)=0; 
            max_=max(max(plot_mat_all));
            max2=max(max(plot_mat)); 
            max_final=max(max_, max2)+10; 
            if (max_final<20)
                max_final=20; 
            end 
            plot_mat(indx)=max_final; 
            plot_mat_HG=plot_mat; 
            qlabel_HG=qlabel2; 
            
            
            
            [r,c]=size(plot_mat_all); 
            x=1; 
            for k=1:c
                lab=qlabel_all{k,2}; 
                indx_lab=find(strcmp(qlabel_HG(:,2), lab)==1); 
                for j=1:r
                    plot(x, plot_mat_all(j,k),'Marker','o', 'MarkerSize', 2, 'Color', blue,  'MarkerFaceColor', blue  ); 
                    hold on 
                end 
                x=x+1; 
                for j=1:r
                    plot(x, plot_mat_HG(j, indx_lab),'Marker','o', 'MarkerSize', 2, 'Color', magenta ,  'MarkerFaceColor', magenta  );  
                end 
                x=x+1;
                x2=[x x]; 
                y2=[0 max_final+50]; 
                plot(x2, y2, '-k'); 
                x=x+1; 
            end 
        end 
        hold off
        set(gca,'XTick', 1:3:x-1); 
        set(gca, 'XTicklabel', qlabel_all(:,1)); 
        xlim([0 x-1]); 
        ylim([0 max_final+10]); 
        print (gcf, '-dpdf', [ques '_raw_OR_metnalhealth_hispanic_girls']); 
        saveas(gcf, [ques '_raw_OR_metnalhealth_hispanic_girls.fig']); 
        close 
    end 
end 
