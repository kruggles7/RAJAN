%make heatmaps out of the relative risk matrix 

cd ..
cd ..
cd matrices
load OR_2013
load qlabel_033014

drugs={'Q25','Q27','Q29','Q31','Q32'}; 
violence={'Q01', 'Q02', 'Q03', 'Q04', 'Q05', 'Q06','Q10', 'Q74', 'Q75', 'Q50', 'Q51'};
suicide={'Q11','Q12','Q13','Q14','Q16'}; 
alcohol_marijuana={'Q17','Q18','Q19','Q21','Q23','Q53', 'Q55'}; % 'Q50','Q51'}; 
disordered_eat={'Q38','Q39','Q40'}; 
cigarette={'Q53','Q55','Q57','Q58','Q59'}; 

ques='Q79'; 
OR=oddsratio2013; 
[r,c]=size(OR); 
OR=OR(2:r,:); 
indx=find(strcmp(OR(:,1),'Q79')==1); %put in the number for Rx drugs
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
xlab=OR(:,2); 
plot_mat=cell2mat(OR(:,7:9));
[indx_r, indx_c]=find(plot_mat<100000); 
indx_ru=unique(indx_r); 
plot_mat2=plot_mat(indx_ru,:); 
xlab2=xlab(indx_ru,:); 
indx=find(plot_mat2==0); 
plot_mat2(indx)=NaN; 

[r,c]=size(plot_mat2); 
%x={'2009', '2011', '2013'}; 
x=1:r; 
for j=1:3
    if j==1
        color=[24/255 116/255 205/255]; %blue
    elseif j==2
        color=[0/255 205/255 102/255]; %green
    elseif j==3
        color=[255/255 127/255 0/255]; %orange
    %elseif 
    %    color=[205/255 0/255 0/255]; %red
    end 
    y=plot_mat2(:,j); 
	scatter(x, y, 5, color, 'filled'); 
    hold on
end 
avg=nanmean(plot_mat2,2); 
scatter(x, avg,  5, color, 'filled');
hold off
set(gca,'XTickLabel', xlab); 
cd .. 
cd programs
cd prescriptiondrugs
cd results

saveas (gcf,'PO_OR.fig'); 
close


%drugs-----------
count=1; 
druglab=cell.empty;
for i=1:numel(drugs)
    indx=find(strcmp(xlab2,drugs{i})==1); 
    if numel(indx)>0
        plot_drugs(count,:)=plot_mat2(indx,:); 
        druglab{count,1}=drugs{i};
        count=count+1; 
    end
end 

for i=1:numel(alcohol_marijuana)
    indx=find(strcmp(xlab2,alcohol_marijuana{i})==1); 
    if numel(indx)>0
        plot_drugs(count,:)=plot_mat2(indx,:); 
        druglab{count,1}=alcohol_marijuana{i};
        count=count+1; 
    end
end 

%f1=subplot(2,3,1); 
[r,c]=size(plot_drugs); 
%x={'2009', '2011', '2013'}; 
x=1:r; 
for j=1:3
    if j==1
        color=[24/255 116/255 205/255]; %blue
    elseif j==2
        color=[0/255 205/255 102/255]; %green
    %elseif 
    %    color=[255/255 127/255 0/255]; %orange
    elseif j==3 
        color=[205/255 0/255 0/255]; %red
    end 
    y=plot_drugs(:,j); 
	scatter(x, y,20,'b','o','filled');  
    hold on
end 
avg=nanmean(plot_drugs,2); 
for i=1:numel(x)
    x1=x(i)-0.25; 
    x2=x(i)+0.25; 
    x_=[x1,x2]; 
    y_=[avg(i),avg(i)]; 
    plot(x_,y_, 'k');
end
%hold off
set(gca,'Xtick',1:r); 
label_new={'Ever used cocaine', 'Ever used heroin', 'Ever used methamphetamine',  'Ever injected Drugs', 'Ever used Ecstasy', 'Ever drink alcohol','Drank alcohol*','Had 5+ alcoholic drinks*', 'Ever used marijuana', 'Used marijuana*', 'Ever smoked cigarettes', 'Smoked cigarettes*'};  
set(gca,'XTickLabel', label_new); 
xlim([0,r+1]); 
ylim([0 25]); 
title('Association between Rx Drug use and Drug, Alcohol and Cigarette Use', 'FontSize', 12, 'FontWeight', 'bold'); 
cd ..
rotateXLabels(gca,45)
cd results
ylabel('Odds Ratio with Rx Drug Use', 'FontSize', 12); 
set (gca, 'FontSize', 12); 
saveas (gcf,'Drug_OR.fig'); 
print (gcf, '-dpdf', 'Fig3A.pdf'); 
close 

%suicide and disordered eating-----------
count=1; 
suicide_lab=cell.empty;
plot_suicide=double.empty; 
for i=1:numel(suicide)
    indx=find(strcmp(xlab2,suicide{i})==1); 
    if numel(indx)>0
        plot_suicide(count,:)=plot_mat2(indx,:); 
        suicide_lab{count,1}=suicide{i};
        count=count+1; 
    end
end 

for i=1:numel(disordered_eat)
    indx=find(strcmp(xlab2,disordered_eat{i})==1); 
    if numel(indx)>0
        plot_suicide(count,:)=plot_mat2(indx,:); 
        suicide_lab{count,1}=disordered_eat{i};
        count=count+1; 
    end
end 

%f1=subplot(2,3,1); 
[r,c]=size(plot_suicide); 
%x={'2009', '2011', '2013'}; 
x=1:r; 
for j=1:3
    if j==1
        color=[24/255 116/255 205/255]; %blue
    elseif j==2
        color=[0/255 205/255 102/255]; %green
    %elseif 
    %    color=[255/255 127/255 0/255]; %orange
    elseif j==3 
        color=[205/255 0/255 0/255]; %red
    end 
    y=plot_suicide(:,j); 
	scatter(x, y, 20,'b','o','filled');  
    hold on
end 
avg=nanmean(plot_suicide,2); 
for i=1:numel(x)
    x1=x(i)-0.25; 
    x2=x(i)+0.25; 
    x_=[x1,x2]; 
    y_=[avg(i),avg(i)]; 
    plot(x_,y_, 'k');
end
%hold off
set(gca,'Xtick',1:r); 
label_new={'Felt sad or hopeless^', 'Considered suicide^', 'Planned suicide^', 'Was injured during suicide attempt^', 'Attempted Suicide^', 'Fasted to lose weight*', 'Took pill to lose weight*','Vomited to lose weight*'}; 
set(gca,'XTickLabel', label_new); 
xlim([0,r+1]); 
title('Association between Rx Drug use and Suicide, Disordered Eating', 'FontSize', 12, 'FontWeight', 'bold');
cd ..
rotateXLabels(gca,45)
cd results
ylabel('Odds Ratio with Rx Drug Use', 'FontSize', 12);
ylim([0 10]); 
set (gca, 'FontSize', 12); 
saveas (gcf,'suicide_eating_OR.fig'); 
print (gcf, '-dpdf', 'Fig3B.pdf'); 
close

%violence/safety-----------
count=1; 
safe_lab=cell.empty;
plot_safe=double.empty; 
for i=1:numel(violence)
    indx=find(strcmp(xlab2,violence{i})==1); 
    if numel(indx)>0
        plot_safe(count,:)=plot_mat2(indx,:); 
        safe_lab{count,1}=violence{i};
        count=count+1; 
    end
end 


%f1=subplot(2,3,1); 
[r,c]=size(plot_safe); 
%x={'2009', '2011', '2013'}; 
x=1:r; 
for j=1:3
    if j==1
        color=[24/255 116/255 205/255]; %blue
    elseif j==2
        color=[0/255 205/255 102/255]; %green
    %elseif 
    %    color=[255/255 127/255 0/255]; %orange
    elseif j==3 
        color=[205/255 0/255 0/255]; %red
    end 
    y=plot_safe(:,j); 
	scatter(x, y, 20,'b','o','filled'); 
    hold on
end 
avg=nanmean(plot_safe,2); 
for i=1:numel(x)
    x1=x(i)-0.25; 
    x2=x(i)+0.25; 
    x_=[x1,x2]; 
    y_=[avg(i),avg(i)]; 
    plot(x_,y_, 'k');
end
%hold off
set(gca,'Xtick',1:r); 
label_new={'Carried a weapon*', 'Carried a gun*', 'Carried a weapon at school*', 'Felt unsafe at school*', 'Been threatened at school*', 'Been in a fight*','Ever been forced to have sex', 'Been bullied at school^', 'Been electronically bullied^', 'Ridden with a driver who was drinking*', 'Driven while drinking*'}; 
set(gca,'XTickLabel', label_new); 
xlim([0,r+1]); 
title('Association between Rx Drug use and Physical Violence, School Safety', 'FontSize', 12, 'FontWeight', 'bold');
cd ..
rotateXLabels(gca,45)
cd results
ylabel('Odds Ratio with Rx Drug Use', 'FontSize', 12);
ylim([0 10]); 
set (gca, 'FontSize', 12); 
saveas (gcf,'violence_OR.fig'); 
print (gcf, '-dpdf', 'Fig3C.pdf'); 
%close

% 
% %drugs-----------
% count=1; 
% druglab=cell.empty;
% for i=1:numel(drugs)
%     indx=find(strcmp(xlab2,drugs{i})==1); 
%     if numel(indx)>0
%         plot_drugs(count,:)=plot_mat2(indx,:); 
%         druglab{count,1}=drugs{i};
%         count=count+1; 
%     end
% end 
% 
% f1=subplot(2,3,1); 
% [r,c]=size(plot_drugs); 
% %x={'2009', '2011', '2013'}; 
% x=1:r; 
% for j=1:3
%     if j==1
%         color=[24/255 116/255 205/255]; %blue
%     elseif j==2
%         color=[0/255 205/255 102/255]; %green
%     %elseif 
%     %    color=[255/255 127/255 0/255]; %orange
%     elseif j==3 
%         color=[205/255 0/255 0/255]; %red
%     end 
%     y=plot_drugs(:,j); 
% 	scatter(x, y, 15, 'b','o', 'filled'); 
%     hold on
% end 
% avg=mean(plot_drugs,2); 
% for i=1:numel(x)
%     x1=x(i)-0.25; 
%     x2=x(i)+0.25; 
%     x_=[x1,x2]; 
%     y_=[avg(i),avg(i)]; 
%     plot(x_,y_);
% end
% %hold off
% set(gca,'Xtick',1:r); 
% set(gca,'XTickLabel', druglab); 
% xlim([0,r+1]); 
% 
% %alcohol_marijuana------
% %drugs-----------
% count=1;
% alclab=cell.empty;
% for i=1:numel(alcohol_marijuana)
%     indx=find(strcmp(xlab2,alcohol_marijuana{i})==1); 
%     if numel(indx)>0
%         plot_alc(count,:)=plot_mat2(indx,:); 
%         alclab{count,1}=alcohol_marijuana{i};
%         count=count+1; 
%     end
% end 
% 
% f2=subplot(2,3,2:3); 
% [r,c]=size(plot_alc); 
% %x={'2009', '2011', '2013'}; 
% x=1:r; 
% for j=1:3
%     if j==1
%         color=[24/255 116/255 205/255]; %blue
%     elseif j==2
%         color=[0/255 205/255 102/255]; %green
%     %elseif 
%     %    color=[255/255 127/255 0/255]; %orange
%     elseif j==3 
%         color=[205/255 0/255 0/255]; %red
%     end 
%     y=plot_alc(:,j); 
% 	scatter(x, y, 15, 'b','o', 'filled'); 
%     hold on
% end 
% avg=mean(plot_alc,2); 
% for i=1:numel(x)
%     x1=x(i)-0.25; 
%     x2=x(i)+0.25; 
%     x_=[x1,x2]; 
%     y_=[avg(i),avg(i)]; 
%     plot(x_,y_);
% end
% hold off
% set(gca,'Xtick',1:r); 
% set(gca,'XTickLabel', alclab); 
% xlim([0,r+1]); 