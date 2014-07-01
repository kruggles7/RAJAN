%QUESTION 75

cd ..
cd ..
cd data
cd controls
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt', '\t'); 
weight=importdata('weight.txt','\t'); 
grade=importdata('grade-NaN.txt','\t'); 
[r,c]=size(sex); 
weight=weight(6,2:c); 
race=race(6,2:c); 
sex=sex(6,2:c); 
grade=grade(6,2:c);
cd ..
cd cat_results_010314

questions={'Q79', 'Q27' }; 
N=length(questions); 
per_mat = zeros(27,N);

for i=1:N
    q=questions{i}; 
    question_mat=importdata([q '-cat-NaN.txt'], '\t');
    [r,c]=size(question_mat); 
    Q1=question_mat(r,2:c); 
    Q1_=zeros(1,c);
    index_yes=find(Q1>4);
    index_girls=find(sex==1);
    index_boys=find(sex==2);
    index_W=find(race== 1 );
    index_B=find(race== 2 );
    index_H=find(race== 3 );
    index_O=find(race== 4 );
    index_9=find(grade== 1 ); 
    index_10=find(grade== 2 ); 
    index_11=find(grade== 3 ); 
    index_12=find(grade== 4 ); 

    index_missQ=find(Q1==0); %students who didn't answer the Q
    index_nomiss=find(Q1>0); %answers that were NOT missing (ie. 0's and 1's / no's and yes's)
    missQ=length(index_missQ); %number of students who answered the question each year

    index_total_b=intersect(index_nomiss,index_boys); %index of all boys who answered 
    index_total_g=intersect(index_nomiss,index_girls); %index of all girls who answered

    % totals of each race/sex/combo: (for percentages- to compare those who said yes to total questioned)
    w=weight'; 
    total_ans=nansum(w(index_nomiss)); 
    total_girls=nansum(w(index_total_g)); %total # of girls who answered
    total_boys=nansum(w(index_total_b));  %total number of boys who answered
    total_W=nansum(w(intersect(index_nomiss, index_W))); %total # of white students who answered
    total_B=nansum(w(intersect(index_nomiss, index_B))); %total # of black students who answered
    total_H=nansum(w(intersect(index_nomiss, index_H))); %total # of hispanic students who answered
    total_O=nansum(w(intersect(index_nomiss, index_O))); %total # of "other" students who answered
    total_Wb=nansum(w(intersect(index_total_b,index_W))); 
    total_Wg=nansum(w(intersect(index_total_g,index_W))); 
    total_Bb=nansum(w(intersect(index_total_b,index_B))); 
    total_Bg=nansum(w(intersect(index_total_g,index_B))); 
    total_Hb=nansum(w(intersect(index_total_b,index_H))); 
    total_Hg=nansum(w(intersect(index_total_g,index_H))); 
    total_Ob=nansum(w(intersect(index_total_b,index_O))); 
    total_Og=nansum(w(intersect(index_total_g,index_O))); 
    total_9=nansum(w(intersect((index_9),index_nomiss))); 
    total_10=nansum(w(intersect((index_10),index_nomiss))); 
    total_11=nansum(w(intersect((index_11),index_nomiss)));  
    total_12=nansum(w(intersect((index_12),index_nomiss))); 
    total_9G=nansum(w(intersect(index_9,index_total_g))); 
    total_10G=nansum(w(intersect(index_10,index_total_g)));  
    total_11G=nansum(w(intersect(index_11,index_total_g))); 
    total_12G=nansum(w(intersect(index_12,index_total_g))); 
    total_9B=nansum(w(intersect(index_9,index_total_b)));  
    total_10B=nansum(w(intersect(index_10,index_total_b)));  
    total_11B=nansum(w(intersect(index_11,index_total_b)));  
    total_12B=nansum(w(intersect(index_12,index_total_b)));  

    w=weight'; 
    index_yesgirls=intersect(index_yes,index_girls);
    index_yesboys=intersect(index_yes,index_boys);
    yes_girls=nansum(w(index_yesgirls));
    yes_boys=nansum(w(index_yesboys));
    yes_W=nansum(w(intersect(index_yes, index_W)));
    yes_B=nansum(w(intersect(index_yes, index_B)));
    yes_H=nansum(w(intersect(index_yes, index_H)));
    yes_O=nansum(w(intersect(index_yes, index_O)));
    yes_WG=nansum(w(intersect(index_yesgirls,index_W)));
    yes_BG=nansum(w(intersect(index_yesgirls,index_B)));
    yes_HG=nansum(w(intersect(index_yesgirls,index_H)));
    yes_OG=nansum(w(intersect(index_yesgirls,index_O)));
    yes_WB=nansum(w(intersect(index_yesboys,index_W)));
    yes_BB=nansum(w(intersect(index_yesboys,index_B)));
    yes_HB=nansum(w(intersect(index_yesboys,index_H)));
    yes_OB=nansum(w(intersect(index_yesboys,index_O)));
    yes_9=nansum(w(intersect(index_yes,index_9))); 
    yes_10=nansum(w(intersect(index_yes,index_10))); 
    yes_11=nansum(w(intersect(index_yes,index_11))); 
    yes_12=nansum(w(intersect(index_yes,index_12))); 
    yes_9B=nansum(w(intersect(index_yesboys,index_9))); 
    yes_10B=nansum(w(intersect(index_yesboys,index_10))); 
    yes_11B=nansum(w(intersect(index_yesboys,index_11))); 
    yes_12B=nansum(w(intersect(index_yesboys,index_12)));
    yes_9G=nansum(w(intersect(index_yesgirls,index_9))); 
    yes_10G=nansum(w(intersect(index_yesgirls,index_10))); 
    yes_11G=nansum(w(intersect(index_yesgirls,index_11))); 
    yes_12G=nansum(w(intersect(index_yesgirls,index_12)));
    total_yes=nansum(w(index_yes));
    total_w=total_W; 
    total_b=total_B; 
    total_h=total_H; 
    total_o=total_O;

    %put them all into a matrix as percent values:
    per_mat(1, i)=total_yes/total_ans*100; %total
    per_mat(2, i)=yes_boys/total_boys*100; %boys
    per_mat(3, i)=yes_girls/total_girls*100; %girls
    per_mat(4, i)=yes_W/total_w*100; %whites
    per_mat(5, i)=yes_WB/total_Wb*100; %WB
    per_mat(6, i)=yes_WG/total_Wg*100; %WG
    per_mat(7, i)=yes_B/total_b*100; %blacks
    per_mat(8, i)=yes_BB/total_Bb*100; %BB
    per_mat(9, i)=yes_BG/total_Bg*100; %BG
    per_mat(10, i)=yes_H/total_h*100; %hispanics
    per_mat(11, i)=yes_HB/total_Hb*100; %HB
    per_mat(12, i)=yes_HG/total_Hg*100; %HG
    per_mat(13, i)=yes_O/total_o*100; %other
    per_mat(14, i)=yes_OB/total_Ob*100; %OB
    per_mat(15, i)=yes_OG/total_Og*100; %OG
    per_mat(16, i)=yes_9/total_9*100; 
    per_mat(17, i)=yes_9B/total_9B*100; 
    per_mat(18, i)=yes_9G/total_9G*100; 
    per_mat(19, i)=yes_10/total_10*100; 
    per_mat(20, i)=yes_10B/total_10B*100; 
    per_mat(21, i)=yes_10G/total_10G*100; 
    per_mat(22, i)=yes_11/total_11*100; 
    per_mat(23, i)=yes_11B/total_11B*100; 
    per_mat(24, i)=yes_11G/total_11G*100; 
    per_mat(25, i)=yes_12/total_12*100; 
    per_mat(26, i)=yes_12B/total_12B*100; 
    per_mat(27, i)=yes_12G/total_12G*100; 
end 

label_y={'Prescription Drugs', 'Heroin'}; 
%label_x={'Total', 'Males', 'Females', 'Total', 'Males', 'Females', 'Total', 'Males', 'Females', 'Total', 'Males', 'Females', 'Total', 'Males', 'Females', 'Total', 'Males', 'Females', 'Total', 'Males', 'Females', 'Total', 'Males', 'Females', 'Total', 'Males', 'Females'}; 
label_x={'T', 'M', 'F','T', 'M', 'F','T', 'M', 'F','T', 'M', 'F','T', 'M', 'F','T', 'M', 'F','T', 'M', 'F','T', 'M', 'F','T', 'M', 'F' }; 
    
f=figure; 
markers={'o', 's', 'd', 'v', '*'}; 
filled=[1 0]; 
for i=1:N
    x=1:27; 
    if (filled(i)==1)
        scatter(x, per_mat(:,i),30,'k',markers{i}, 'fill'); 
    else 
        scatter(x, per_mat(:,i),30,'k',markers{i}); 
    end 
    hold on
end 

cd .. 
cd ..
cd programs
cd prescriptiondrugs

y=0:7.5:15; 
x=[3.5 3.5 3.5]; 
plot(x,y,'--k'); 
x=[6.5 6.5 6.5]; 
plot(x,y,'--k'); 
x=[9.5 9.5 9.5]; 
plot(x,y,'--k'); 
x=[12.5 12.5 12.5];
plot(x,y,'--k');  
x=[15.5 15.5 15.5];
plot(x,y,'--k');  
x=[18.5 18.5 18.5];
plot(x,y,'--k');  
x=[21.5 21.5 21.5];
plot(x,y,'--k');  
x=[24.5 24.5 24.5];
plot(x,y,'--k'); 
x=[27.5 27.5 27.5];
plot(x,y,'--k');  
set(gca,'xtick', 1:27); 
set(gca,'xticklabel',label_x); 
str1='Overall'; 
text(1,12,str1);
str1='White'; 
text(4,12,str1); 
str1='Black'; 
text(7,12,str1); 
str1='Hispanic'; 
text(10,12,str1); 
str1='Other'; 
text(13,12,str1); 
str1='9th'; 
text(16,12,str1); 
str1='10th'; 
text(19,12,str1); 
str1='11th'; 
text(22,12,str1); 
str1='12th'; 
text(25,12,str1); 
legend(label_y, 'Location', 'NorthOutside'); 
xlim([0.5 27.5]); 
ylabel('Percentage of subjects reporting use >20 times'); 
%rotateXLabels(gca,45);

cd results
saveas(gcf, 'PO_heroin_demographic_20s.fig'); 

%label_x={'Total', 'Boys', 'Girls', 'W', 'W Boys', 'W Girls','B','B Boys', 'B Girls','H',  'H Boys', 'H Girls', 'O', 'O Boys', 'O Girls', '9th', '9th Boys', '9th Girls', '10th', '10th Boys', '10th Girls', '11th', '11th Boys', '11th Girls', '12th', '12th Boys', '12th Girls'}; 
%rework the order 
permat=per_mat; 
permat2=zeros(27,N); 
label_x2={'T', 'W', 'B', 'H', 'O', '9', '10', '11', '12','T', 'W', 'B', 'H', 'O', '9', '10', '11', '12','T', 'W', 'B', 'H', 'O', '9', '10', '11', '12'};  
permat2(1,:)=permat(1,:); 
permat2(2,:)=permat(4,:); 
permat2(3,:)=permat(7,:); 
permat2(4,:)=permat(10,:); 
permat2(5,:)=permat(13,:); 
permat2(6,:)=permat(16,:); 
permat2(7,:)=permat(19,:); 
permat2(8,:)=permat(22,:); 
permat2(9,:)=permat(25,:); 

permat2(10,:)=permat(2,:); 
permat2(11,:)=permat(5,:); 
permat2(12,:)=permat(8,:); 
permat2(13,:)=permat(11,:); 
permat2(14,:)=permat(14,:); 
permat2(15,:)=permat(17,:); 
permat2(16,:)=permat(20,:); 
permat2(17,:)=permat(23,:); 
permat2(18,:)=permat(26,:); 

permat2(19,:)=permat(3,:); 
permat2(20,:)=permat(6,:); 
permat2(21,:)=permat(9,:); 
permat2(22,:)=permat(12,:); 
permat2(23,:)=permat(15,:); 
permat2(24,:)=permat(18,:); 
permat2(25,:)=permat(21,:); 
permat2(26,:)=permat(24,:); 
permat2(27,:)=permat(27,:); 

label_y={'Prescription Drugs', 'Heroin'}; 

f=figure; 
markers={'o', 's', 'd', 'v', '*'}; 
filled=[1 0]; 
for i=1:N
    x=1:27; 
    if (filled(i)==1)
        scatter(x, permat2(:,i),30,'k',markers{i}, 'fill'); 
    else 
        scatter(x, permat2(:,i),30,'k',markers{i}); 
    end 
    hold on
end 
y=0:20:40; 
x=[9.5 9.5 9.5]; 
plot(x,y,'--k'); 
x=[18.5 18.5 18.5]; 
plot(x,y,'--k'); 
x=[27.5 27.5 27.5]; 
plot(x,y,'--k'); 
set(gca,'xtick', 1:27); 
set(gca,'xticklabel',label_x2); 
str1='Overall'; 
text(4,35,str1); 
str1='Boys'; 
text(13,35,str1); 
str1='Girls'; 
text(21,35,str1); 
legend(label_y, 'Location', 'NorthOutside'); 
xlim([0.5 27.5]); 
ylabel('Percentage of subjects reporting use >20 times'); 
saveas(gcf, 'PO_heroin_demographics2_20.fig'); 
