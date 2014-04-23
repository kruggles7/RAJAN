% %has reverse code information incorporated into this analysis
% 
% % This program goes through all the binary_NaN files and gets the # yes/#no
% % for each question for plotting 
% 
% % V1 | V2 | RR2001 | RR 2003 | RR2005 | RR2007 | RR2009 | RR2011
% %____|____|________|_________|________|________|________|________
% %	 |	  |		   |		 |		  |		   |		|
% 
% It then does the same thing for odds ratio


k=1; %counter for rows in rel_risk_cell and odds_ratio_cell

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

%files1=dir(fullfile('C:','Users','kruggles7','Dropbox','RAJAN', 'CDC_FINAL', 'results_071113','NaN', '*.txt'));
files1=dir(fullfile('C:','Users','Kelly','Documents','MATLAB', 'rajan','nan_results', '*.txt'));

cd matrices
load reverse_code.mat
cd .. 
cd ..
cd ..
cd nan_results
plot_mat=zeros(6,16410); 
gun_mat=NaN(6,16410); 
P=length(files1);
for p=1:P
	quest_1=importdata(files1(p).name, '\t');
    if k==1
        [r,c]=size(quest_1); 
        Q1=quest_1(:,2:c); 
        indx_nan=find(isnan(Q1)==1); 
        k=2; 
    end 
	filename1='';
	a1=char(files1(p).name);
	b1=strfind(a1,'-');
    for q=1:(b1(1)-1)
		c1=a1(q);
		filename1=[filename1 c1];
    end
    ct=[]; 
	for q=2:(b1(1)-1)
        c1=a1(q) ;
        if c1~=0
            ct=[ct c1]; 
        end
    end
    ct=str2num(ct);
    q1_RC=reverse_code(ct,1); 
    if (isnan(q1_RC)==0 && strcmp(filename1,'Q76')==0)
        [r,c]=size(quest_1); %number of subjects in each year 
        for i=1:r
            for j=2:c
                if q1_RC==1
                    if quest_1(i,j)==0 %students who answered yes to Q1
                        plot_mat(i,j-1)=plot_mat(i,j-1)+1; 
                    end 
                else 
                    if (quest_1(i,j)==1)
                        plot_mat(i,j-1)=plot_mat(i,j-1)+1; 
                    end 
                end  
            end 
        end 
    end
    if (strcmp(filename1,'Q02')==1)%carrying a gun
        for i=1:r
            indx_yes=find(quest_1(i,2:c)==1); 
            indx_no=find(quest_1(i,2:c)==0); 
            gun_mat(i,indx_yes)=1; 
            gun_mat(i,indx_no)=0; 
        end 
    end 
end 

cd ..
cd programs
cd relative_risk
[r,c]=size(plot_mat); 
plot_mat_yes=[]; 
plot_mat_no=[]; 
for j=1:r
    indx=find(gun_mat(j,:)==1); 
    indx2=find(gun_mat(j,:)==0);
    plot_mat_yes=cat(2,plot_mat_yes,plot_mat(j,indx)); 
    plot_mat_no=cat(2,plot_mat_no,plot_mat(j,indx2));   
end 

[r,c]=size(plot_mat_no); 
[r2,c2]=size(plot_mat_yes); 
quest_plot=NaN(c,2); 
quest_plot(:,1)=plot_mat_no'; 
quest_plot(1:c2,2)=plot_mat_yes'; 
p=anova1(quest_plot); 
boxplot(quest_plot); 
% set (gca, 'XTick', [1 2]); 
% set(gca, 'XTickLabel', {'Germline', 'Somatic'}); 
% ylabel('Number Predicted Variant Changes per Sample'); 
% print (gcf, '-dpng', [ label '_boxplot_junction.png']);  


% no=1.8; 
% yes=3.8; 
% m=0.1; 
% [r,c]=size(plot_mat); 
% for j=1:r
%     indx=find(gun_mat(j,:)==1); 
%     indx2=find(gun_mat(j,:)==0);
%     plot_mat_yes=plot_mat(j,indx); 
%     plot_mat_no=plot_mat(j,indx2); 
%     x_yes=[]; 
%     x_no=[]; 
%     no=1.8; 
%     yes=3.8; 
%     m=0.1;
%     for i=1:length(plot_mat_yes)
%         x_yes=cat(1,x_yes,yes); 
%         if yes==4.2
%             yes=3.8; 
%         else 
%             yes=yes+m; 
%         end 
%     end 
%     for i=1:length(plot_mat_no)
%         x_no=cat(1,x_no,no); 
%         if no==2.2
%             no=1.8; 
%         else 
%             no=no+m; 
%         end 
%     end 
%     scatter(x_yes,plot_mat_yes,1,'o', 'MarkerEdgeColor',blue, 'MarkerFaceColor',blue);
%     hold on
%     scatter(x_no,plot_mat_no,1,'o', 'MarkerEdgeColor',blue, 'MarkerFaceColor',blue);
%     hold on
% end 
% 
% hold off 
            

% gun=importdata('Q02-cat-NaN.txt', '\t');
% [r,c]=size(gun);
% gun=gun(:,2:c); 

% plot_mat(indx_nan)=NaN;
% [r,c]=size(plot_mat); 
% quest_plot=zeros(55,2); 
% for i=1:r
%     indx=find(isnan(plot_mat(i,:))==0); 
%     total=numel(indx); 
%     indx_no=find(gun(i,:)==1); 
%     indx_yes=find(gun(i,:)>1);
%     
% %     for k=1:55
% %         indx2=find(plot_mat(i,:)==k); 
% %         indx3=intersect(indx_yes,indx2); 
% %         indx4=intersect(indx_no,indx2); 
% %         quest_plot(k,1)= quest_plot(k,1)+numel(indx3); 
% %         quest_plot(k,2)=quest_plot(k,2)+numel(indx4); 
% %     end         
% end 
% 
% n_yes=sum(quest_plot(:,1)) ;
% n_no=sum(quest_plot(:,2)) ;
% x=[-0.1:0.05:0.1]; 
% x1=[ 2 2 2 2 2]; 
% x2=[ 4 4 4 4 4]; 
% x_n=x+x1; 
% x_y=x+x2; 
% x_yes=[]; 
% x_no=[]; 
% [r,c]=size(quest_plot); 
% for i=1:5:r
%     x_yes=cat(2,x_yes,x_y); 
%     x_no=cat(2,x_no,x_n); 
% end 
% %BOXPLOTS
% scatter(x_no, quest_plot(:,1),3,'o', 'MarkerEdgeColor',blue, 'MarkerFaceColor',blue);
% hold on
% scatter(x_yes, quest_plot(:,2),3,'o', 'MarkerEdgeColor',blue, 'MarkerFaceColor',blue);
% hold off 
% 
% p=anova1(quest_plot); 
% boxplot(quest_plot); 
% set (gca, 'XTick', [1 2]); 
% set(gca, 'XTickLabel', {'Germline', 'Somatic'}); 
% ylabel('Number Predicted Variant Changes per Sample'); 
% print (gcf, '-dpng', [ label '_boxplot_junction.png']);  
% 
% 
%                