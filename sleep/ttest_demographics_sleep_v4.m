
cd .. 
cd ..
cd data
cd results_061514
cd cat
question_mat=importdata('Q80-cat-NaN.txt', '\t');
[r,c]=size(question_mat); 

cd ..
cd ..
cd Controls_061514
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt', '\t'); 
weight=importdata('weights-NaN.txt','\t'); 
grade=importdata('grade-NaN.txt','\t'); 
[r,c]=size(sex); 
weight=weight(4:7,:); 
race=race(4:7,:); 
sex=sex(4:7,:); 
grade=grade(4:7,:); 
cd ..
cd ..
cd programs
cd sleep

[r,c]=size(question_mat); 
indx=find(question_mat==9); 
question_mat(indx)=NaN; 

[r,c]=size(question_mat); 
c_new=c-1; 
stat_mat=nan(c_new*4,7); 
stat_mat(1:c_new,1)=question_mat(1,2:c); 
stat_mat(1:c_new,2)=2007; 
stat_mat(1:c_new,3)=sex(1,2:c); 
stat_mat(1:c_new,4)=race(1,2:c); 
stat_mat(1:c_new,5)=weight(1,2:c); 
stat_mat(1:c_new,6)=grade(1,2:c); 

stat_mat(c_new+1:c_new*2,1)=question_mat(2,2:c); 
stat_mat(c_new+1:c_new*2,2)=2009; 
stat_mat(c_new+1:c_new*2,3)=sex(2,2:c); 
stat_mat(c_new+1:c_new*2,4)=race(2,2:c);
stat_mat(c_new+1:c_new*2,5)=weight(2,2:c); 
stat_mat(c_new+1:c_new*2,6)=grade(2,2:c); 

stat_mat(c_new*2+1:c_new*3,1)=question_mat(3,2:c); 
stat_mat(c_new*2+1:c_new*3,2)=2011; 
stat_mat(c_new*2+1:c_new*3,3)=sex(3,2:c); 
stat_mat(c_new*2+1:c_new*3,4)=race(3,2:c); 
stat_mat(c_new*2+1:c_new*3,5)=weight(3,2:c); 
stat_mat(c_new*2+1:c_new*3,6)=grade(3,2:c); 

stat_mat(c_new*3+1:c_new*4,1)=question_mat(4,2:c); 
stat_mat(c_new*3+1:c_new*4,2)=2013; 
stat_mat(c_new*3+1:c_new*4,3)=sex(4,2:c); 
stat_mat(c_new*3+1:c_new*4,4)=race(4,2:c); 
stat_mat(c_new*3+1:c_new*4,5)=weight(4,2:c); 
stat_mat(c_new*3+1:c_new*4,6)=grade(4,2:c); 

indx_nan=find(isnan(stat_mat(:,1))==0 & isnan(stat_mat(:,5))==0); 
stat_mat2=stat_mat(indx_nan, :); 
[r,c]=size(stat_mat2); 

years=[2007 2009 2011 2013]; 
p_mat=cell(10,3);
f_mat=cell(10,3); 
t_mat=cell(10,3); 
p_ttest=cell(28,3); 

p_mat{1,2}='5 or less'; 
p_mat{1,3}='9 or more'; 
f_mat{1,2}='5 or less'; 
f_mat{1,3}='9 or more'; 

%<5 or >9
indx5=find(stat_mat2(:,1)<3); 
indx9=find(stat_mat2(:,1)>5); 

%males 
indx_boys=find(stat_mat2(:,3)==2); 
temp_boys5=nan(r,1); 
temp_boys9=nan(r,1);
indx_boys5=intersect(indx5,indx_boys); 
indx_boys9=intersect(indx9,indx_boys); 
temp_boys5(indx_boys5)=stat_mat2(indx_boys5,5); 
temp_boys9(indx_boys9)=stat_mat2(indx_boys9,5); 

%females
indx_girls=find(stat_mat2(:,3)==2); 
temp_girls5=nan(r,1); 
temp_girls9=nan(r,1);
indx_girls5=intersect(indx5,indx_girls); 
indx_girls9=intersect(indx9,indx_girls); 
temp_girls5(indx_girls5)=stat_mat2(indx_girls5,5); 
temp_girls9(indx_girls9)=stat_mat2(indx_girls9,5); 

%anova
temp_mat5=cat(2,temp_boys5,temp_girls5); 
temp_mat9=cat(2,temp_boys9, temp_girls9); 
[p, table,stats]=anova1(temp_mat5);
p_mat{2,1}='Overall'; 
p_mat{3,1}='White'; 
p_mat{4,1}='Black'; 
p_mat{5,1}='Hispanic'; 
p_mat{6,1}='Other'; 
p_mat{7,1}='9th'; 
p_mat{8,1}='10th'; 
p_mat{9,1}='11th'; 
p_mat{10,1}='12th'; 
f_mat(:,1)=p_mat(:,1); 

p_mat{2,2}=p; 
f_mat{2,2}=table{2,5}; 
[p, table,stats]=anova1(temp_mat9);
p_mat{2,3}=p; 
f_mat{2,3}=table{2,5}; 
close all 
%post-hoc ttest 
[h,p,c, STAT]=ttest(temp_boys5,temp_girls5); 
tstat_=STAT.tstat;

n=3; 
for j=1:4 %race
    indx=find(stat_mat2(:,4)==j);
    %males 
    temp_boys5=nan(r,1); 
    temp_boys9=nan(r,1);
    indx_boys5_=intersect(indx_boys5, indx); 
    indx_boys9_=intersect(indx_boys9, indx);
    temp_boys5(indx_boys5_)=stat_mat2(indx_boys5_,5); 
    temp_boys9(indx_boys9_)=stat_mat2(indx_boys9_,5); 
    %females
    temp_girls5=nan(r,1); 
    temp_girls9=nan(r,1);
    indx_girls5_=intersect(indx_girls5, indx); 
    indx_girls9_=intersect(indx_girls9, indx);
    temp_girls5(indx_girls5_)=stat_mat2(indx_girls5_,5); 
    temp_girls9(indx_girls9_)=stat_mat2(indx_girls9_,5); 
    
    %anova
    temp_mat5=cat(2,temp_boys5,temp_girls5); 
    temp_mat9=cat(2,temp_boys9, temp_girls9); 
    [p, table,stats]=anova1(temp_mat5);
    p_mat{n,2}=p; 
    f_mat{n,2}=table{2,5}; 
    [p, table,stats]=anova1(temp_mat9);
    p_mat{n,3}=p; 
    f_mat{n,3}=table{2,5}; 
    close all 
    n=n+1; 
end 

 for k=1:4 %grade
    indx=find(stat_mat2(:,6)==j);
    %males 
    temp_boys5=nan(r,1); 
    temp_boys9=nan(r,1);
    indx_boys5_=intersect(indx_boys5, indx); 
    indx_boys9_=intersect(indx_boys9, indx);
    temp_boys5(indx_boys5_)=stat_mat2(indx_boys5_,5); 
    temp_boys9(indx_boys9_)=stat_mat2(indx_boys9_,5); 
    %females
    temp_girls5=nan(r,1); 
    temp_girls9=nan(r,1);
    indx_girls5_=intersect(indx_girls5, indx); 
    indx_girls9_=intersect(indx_girls9, indx);
    temp_girls5(indx_girls5_)=stat_mat2(indx_girls5_,5); 
    temp_girls9(indx_girls9_)=stat_mat2(indx_girls9_,5); 
    
    %anova
    temp_mat5=cat(2,temp_boys5,temp_girls5); 
    temp_mat9=cat(2,temp_boys9, temp_girls9); 
    [p, table,stats]=anova1(temp_mat5);
    p_mat{n,2}=p; 
    f_mat{n,2}=table{2,5}; 
    [p, table,stats]=anova1(temp_mat9);
    p_mat{n,3}=p; 
    f_mat{n,3}=table{2,5}; 
    close all 
    n=n+1; 
 end 
            

  

