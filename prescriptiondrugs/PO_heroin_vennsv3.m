%files1=dir(fullfile('C:','Users','kruggles7','Documents','MATLAB', 'CDC', 'data','cat_results_010314', '*.txt'));

cd ..
cd ..
cd data
cd results_061514
cd cat
index_yes=double.empty; 


questions={'Q79', 'Q27', 'Q31'}; 
labels={'Rx Drugs', 'Heroin', 'Injection Drugs'}; 

quest_1=importdata('Q79-cat-NaN.txt', '\t');
[r1,c1]=size(quest_1);
q1_2013=quest_1(r1,2:c1); 
q1_2011=quest_1(r1-1,2:c1); 
q1_2009=quest_1(r1-2,2:c1); 
q1_all=cat(2,q1_2013, q1_2011); 
q1_all=cat(2,q1_all, q1_2009); 

max_=max(q1_all);   
indx_nomiss=find(q1_all>0); 
q1_total=numel(indx_nomiss); 

quest_2=importdata('Q27-cat-NaN.txt', '\t'); 
[r2,c2]=size(quest_2); 
q2_2013=quest_2(r2,2:c2); 
q2_2011=quest_2(r2-1,2:c2); 
q2_2009=quest_2(r2-2,2:c2); 
q2_all=cat(2,q2_2013, q2_2011); 
q2_all=cat(2,q2_all, q2_2009); 

indx_nomiss=find(q2_all>0); 
q2_total=numel(indx_nomiss);

quest_3=importdata('Q31-cat-NaN.txt','\t'); 
[r3,c3]=size(quest_3); 
q3_2013=quest_3(r3,2:c3); 
q3_2011=quest_3(r3-1,2:c3); 
q3_2009=quest_3(r3-2,2:c3); 
q3_all=cat(2,q3_2013, q3_2011); 
q3_all=cat(2,q3_all, q3_2009); 

indx_nomiss=find(q3_all>0); 
q3_total=numel(indx_nomiss); 

cd ..
cd ..
cd ..
cd programs
cd prescriptiondrugs
cd results

indx_heroin=find(q2_all>1); 
indx_injection=find(q3_all>1); 

table_PO=cell.empty;  
table_heroin=cell.empty; 
table_overlap=cell(6,8); 
table_overlap_heroin=cell(6,5); 
table_PO{1,1}='PO lifetime'; 
table_PO{2,1}='PO > 3 times'; 
table_PO{3,1}='PO > 10 times'; 
table_PO{4,1}='PO > 20 times'; 
table_PO{5,1}='PO > 40 times'; 
table_PO{6,1}='heroin lifetime'; 
table_PO{7,1}='injected lifetime'; 

table_heroin{1,1}='Heroin lifetime'; 
table_heroin{2,1}='Heroin > 3 times'; 
table_heroin{3,1}='Heroin > 10 times'; 
table_heroin{4,1}='Heroin > 20 times'; 
table_heroin{5,1}='Heroin > 40 times'; 


%remove missing values 
indx=find(q1_all>0 & q2_all>0 & q3_all>0 ); 
q1_all=q1_all(indx); 
q2_all=q2_all(indx); 
q3_all=q3_all(indx); 

indx2=find(q2_all>1); 
indx_no2=find(q2_all==1); 
table_PO{6,2}=numel(indx2);
indx3=find(q3_all>1); 
indx_no3=find(q3_all==1); 
table_PO{7,2}=numel(indx3);
indx_no1=find(q1_all==1); 
indx1_=find(q1_all>1); 

table_overlap{1,2}='PO only (C)'; 
table_overlap{1,3}='heroin+injected+PO (E)';
table_overlap{1,4}='PO+heroin-injection(B)';
table_overlap{1,5}='injected+heroin-PO(D)';  
table_overlap{1,6}='PO+injected-heroin (F)'; 
table_overlap{1,7}='heroin only (A)';  
table_overlap{1,8}='injection only (G)'; 

table_overlap_heroin{1,2}='Heroin only'; 
table_overlap_heroin{1,3}='heroin+injected+po'; 
table_overlap_heroin{1,4}='heroin+PO-injections'; 
table_overlap_heroin{1,5}='heroin+injections-PO';

table_overlap{2,1}='PO lifetime'; 
table_overlap{3,1}='PO > 3 times'; 
table_overlap{4,1}='PO > 10 times'; 
table_overlap{5,1}='PO > 20 times'; 
table_overlap{6,1}='PO > 40 times';

table_overlap_heroin{2,1}='heroin lifetime'; 
table_overlap_heroin{3,1}='heroin > 3 times'; 
table_overlap_heroin{4,1}='heroin > 10 times'; 
table_overlap_heroin{5,1}='heroin > 20 times'; 
table_overlap_heroin{6,1}='heroin > 40 times'; 

for i=1:max_-1
    indx1=find(q1_all==i+1);
    indx2_=find(q2_all==i+1); 
    table_PO{i,2}=numel(indx1); 
    table_heroin{i,2}=numel(indx2_); 
    %heroin only 
    indx_=intersect(indx2_, indx_no1); 
    indx=intersect(indx_, indx_no3); 
    table_overlap_heroin{i+1,2}=numel(indx); 
    %heroin+injected+po
    indx_=intersect(indx2_, indx1_); 
    indx=intersect(indx_, indx3); 
    table_overlap_heroin{i+1,3}=numel(indx); 
    %heroin+PO-injections
    indx_=intersect(indx2_,indx1_); 
    indx=intersect(indx_,indx_no3); 
    table_overlap_heroin{i+1,4}=numel(indx); 
    %heroin+injections-PO
    indx_=intersect(indx2_,indx3); 
    indx=intersect(indx_,indx_no1); 
    table_overlap_heroin{i+1,5}=numel(indx); 
    
    %heroin only (A)
    indx_=intersect(indx2, indx_no1); 
    indx=intersect(indx_, indx_no3); 
    table_overlap{i+1,7}=numel(indx); 
    
    %PO+heroin-injection(B)
    indx_=intersect(indx1,indx2); 
    indx=intersect(indx_,indx_no3); 
    table_overlap{i+1,4}=numel(indx);
    %PO only (C)
    indx_=intersect(indx1, indx_no2); 
    indx=intersect(indx_, indx_no3); 
    table_overlap{i+1,2}=numel(indx); 
    %injected+heroin-PO(D)
    indx_=intersect(indx2,indx3); 
    indx=intersect(indx_,indx_no1); 
    table_overlap{i+1,5}=numel(indx);
    %heroin+injected+PO(E)
    indx_=intersect(indx1,indx2); 
    indx=intersect(indx_,indx3); 
    table_overlap{i+1,3}=numel(indx); 
    %PO+injected-heroin(F)
    indx_=intersect(indx1,indx3); 
    indx=intersect(indx_,indx_no2); 
    table_overlap{i+1,6}=numel(indx);
    %injection only (G)
    indx_=intersect(indx3, indx_no1); 
    indx=intersect(indx_,indx_no2); 
    table_overlap{i+1,8}=numel(indx); 
end 

%injected drugs ---------------------------------

table_injected=cell.empty; 
table_injected{2,1}='injected 1 time'; 
table_injected{3,1}='injected 2 or more times'; 

table_overlap_injected=cell(3,5); 
table_overlap_injected{1,2}='injected only'; 
table_overlap_injected{1,3}='heroin+injected+po'; 
table_overlap_injected{1,4}='injected+PO-heroin'; 
table_overlap_injected{1,5}='injections+heroin-PO';
table_overlap_injected{2,1}='injected 1 time'; 
table_overlap_injected{3,1}='injected 2 or more times'; 

for i=1:2
    indx3=find(q3_all==i+1);
    table_injected{i+1,2}=numel(indx3); 
    %injected only 
    indx_=intersect(indx3, indx_no1); 
    indx=intersect(indx_, indx_no2); 
    table_overlap_injected{i+1,2}=numel(indx); 
    %heroin+injected+po
    indx_=intersect(indx3, indx1_); 
    indx=intersect(indx_, indx2); 
    table_overlap_injected{i+1,3}=numel(indx); 
    %injected+PO-heroin
    indx_=intersect(indx3,indx1_); 
    indx=intersect(indx_,indx_no2); 
    table_overlap_injected{i+1,4}=numel(indx); 
    %injections+heroin-PO
    indx_=intersect(indx2,indx3); 
    indx=intersect(indx_,indx_no1); 
    table_overlap_injected{i+1,5}=numel(indx); 
end 

inj=cell2mat(table_overlap_injected(2:3,2:5)); 
overlap_i(:,1)=inj(:,1); 
overlap_i(:,2)=inj(:,3);
overlap_i(:,3)=inj(:,4); 
overlap_i(:,4)=inj(:,2); 
oi=sum(overlap_i,2); 
overlap_i(1,:)=overlap_i(1,:)/oi(1)*100; 
overlap_i(2,:)=overlap_i(2,:)/oi(2)*100; 

f1=subplot(4,1,1); 
x=1:2; 
oi_=oi/q3_total*100; 
plot(x,oi_, '-ok', 'MarkerFaceColor','k'); 
set(gca,'xtick',[0 1 2]); 
set(gca, 'xticklabel', []); 
xlim([0.5 2.5]); 
ylabel('% of Total', 'FontSize', 12);
title ('Overall Frequency of Injection Drug Use', 'FontSize', 12, 'FontWeight', 'Bold'); 
set (gca, 'FontSize', 12); 
f2=subplot(4,1,2:4); 
bar(overlap_i,'stacked'); 
ylim([0 100]);  
labels={'1 time', '2 or more times'}; 
set(gca, 'xticklabel', labels); 
xlim([0.5 2.5]); 
ylabel('% of Total Injection Drug Users', 'FontSize', 12);
title ('Breakdown of Combination Drug Use', 'FontSize', 12, 'FontWeight', 'Bold'); 
legend('Injection Drugs Only','Injection Drugs & Rx Drugs', 'Injection Drugs & Heroin', 'Injection Drugs, Rx Drugs, & Heroin ', 'Location','SouthOutside'); 
set (gca, 'FontSize', 12); 
% %linkaxes([f1,f2], 'x'); 
% %find the current position [x,y,width, height]
% pos1=get(f1,'Position'); 
% pos2=get(f2,'Position'); 
% %set widths equal
% pos2(3)=pos1(3); 
% set (f2, 'Position', pos2); 
% %set x of first equal to second 
% pos1(1)=pos2(1); 
% set(f1, 'Position', pos1); 
% %move the second to touch first
% pos2(2)= pos1(2) - pos2(4); %was pos1(3)
% set (f2, 'Position', pos2); 
saveas (gca, 'Injection_overlaps.fig'); 
close 

%make the stacked bars---------------------------------------------------- 
t=cell2mat(table_overlap(2:6,2:8)); 
overlap(:,1)=t(:,1); 
overlap(:,2)=t(:,3); 
overlap(:,3)=t(:,5); 
overlap(:,4)=t(:,2); 
o=sum(overlap,2); 
overlap(1,:)=overlap(1,:)/o(1)*100; 
overlap(2,:)=overlap(2,:)/o(2)*100; 
overlap(3,:)=overlap(3,:)/o(3)*100; 
overlap(4,:)=overlap(4,:)/o(4)*100; 
overlap(5,:)=overlap(5,:)/o(5)*100; 

f1=subplot(4,1,1); 
x=1:1:5; 
o_=o/q1_total*100; 
plot(x,o_, '-ok', 'MarkerFaceColor','k'); 
%set(gcf,'xticks', []); 
set(gca,'xtick',[0 1 2 3 4 5]); 
set(gca, 'xticklabel', []); 
xlim([0.5 5.5]); 
ylabel('% of Total', 'FontSize', 12);
title ('Overall Frequency of Rx Drug Use', 'FontSize', 12', 'FontWeight', 'Bold'); 
set (gca, 'FontSize', 12); 
f2=subplot(4,1,2:4); 
bar(overlap,'stacked'); 
ylim([0 100]);  
labels={'1 or 2 times', '3-9 times', '10-19 times', '20-39 times', '40+ times'}; 
set(gca, 'xticklabel', labels); 
set (gca, 'FontSize', 12); 
ylabel('% of Total Rx Drug Users', 'FontSize', 12);
legend('Rx Drugs Only','Rx Drugs & Heroin', 'Rx Drugs & Injection Drugs', 'Rx Drugs, Heroin & Injection Drugs', 'Location','SouthOutside'); 
title ('Breakdown of Combination Drug Use', 'FontSize', 12', 'FontWeight', 'Bold'); 
%linkaxes([f1,f2], 'x'); 
%find the current position [x,y,width, height]
% pos1=get(f1,'Position'); 
% pos2=get(f2,'Position'); 
% %set widths equal
% pos2(3)=pos1(3); 
% set (f2, 'Position', pos2); 
% %set x of first equal to second 
% pos1(1)=pos2(1); 
% set(f1, 'Position', pos1); 
% %move the second to touch first
% pos2(2)= pos1(2) - pos2(4); %was pos1(3)
% set (f2, 'Position', pos2); 

saveas (gca, 'PO_overlaps.fig'); 
close 

%make the stacked bars for heroin
t2=cell2mat(table_overlap_heroin(2:6,2:5)); 
overlap2(:,1)=t2(:,1); 
overlap2(:,2)=t2(:,3); 
overlap2(:,3)=t2(:,4); 
overlap2(:,4)=t2(:,2); 
o2=sum(overlap2,2); 
overlap2(1,:)=overlap2(1,:)/o2(1)*100; 
overlap2(2,:)=overlap2(2,:)/o2(2)*100; 
overlap2(3,:)=overlap2(3,:)/o2(3)*100; 
overlap2(4,:)=overlap2(4,:)/o2(4)*100; 
overlap2(5,:)=overlap2(5,:)/o2(5)*100; 
f1=subplot(4,1,1); 
x=1:1:5; 
o2_=o2/q2_total*100; 
plot(x,o2_, '-ok', 'MarkerFaceColor','k');
%set(gcf,'xticks', []); 
set(gca,'xtick',[0 1 2 3 4 5]); 
set(gca, 'xticklabel', []); 
xlim([0.5 5.5]); 
ylabel('% of Total', 'FontSize', 12);
title ('Overall Frequency of Heroin Use', 'FontSize', 12', 'FontWeight', 'Bold'); 
set (gca, 'FontSize', 12); 
f2=subplot(4,1,2:4); 
bar(overlap2,'stacked'); 
ylim([0 100]);  
labels={'1 or 2 times', '3-9 times', '10-19 times', '20-39 times', '40+ times'}; 
set(gca, 'xticklabel', labels); 
ylabel('% of Total Heroin Users', 'FontSize', 12);
title ('Breakdown of Combination Drug Use', 'FontSize', 12, 'FontWeight', 'Bold'); 
set (gca, 'FontSize', 12); 
legend('Heroin Only','Heroin & Prescription Drugs', 'Heroin & Injection Drugs', 'Heroin, Prescription Drugs, & Injection Drugs', 'Location','SouthOutside' ); 
% %linkaxes([f1,f2], 'x'); 
% %find the current position [x,y,width, height]
% pos1=get(f1,'Position'); 
% pos2=get(f2,'Position'); 
% %set widths equal
% pos2(3)=pos1(3); 
% set (f2, 'Position', pos2); 
% %set x of first equal to second 
% pos1(1)=pos2(1); 
% set(f1, 'Position', pos1); 
% %move the second to touch first
% pos2(2)= pos1(2) - pos2(4); %was pos1(3)
% set (f2, 'Position', pos2); 
title ('Breakdown of Combination Drug Use'); 

saveas (gca, 'Heroin_overlaps.fig'); 
close 


