cd ..
cd ..
cd data
cd Controls_061514
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt', '\t'); 
weight=importdata('weights-NaN.txt','\t'); 
grade=importdata('grade-NaN.txt','\t'); 
cd ..
cd results_103114
cd cat
ques=input ('Enter in the question number you want to use (ex. Q01): ', 's'); 
question_mat=importdata([ques '-cat-NaN.txt'], '\t');
[r,c]=size(question_mat); 
labels=question_mat(:,1);
question_mat=question_mat(:,2:c); 
years=[2001 2003 2005 2007 2009 2011 2013]; 
start_year=0; 
end_year=0; 
years2=double.empty; 
count=1; 
for i=1:numel(years)
    indx=find(labels==years(i)); 
    if numel(indx)==1
        if start_year==0
            start_year=i; 
        else
            end_year=i; 
        end 
        years2(count)=years(i); 
        count=count+1; 
    end 
end 

[r,c]=size(sex); 
weight=weight(start_year:end_year,2:c); 
race=race(start_year:end_year,2:c); 
sex=sex(start_year:end_year,2:c); 
grade=grade(start_year:end_year,2:c); 
cd .. 
cd ..
cd ..
cd programs
cd heatmaps
[conf_mat, total, x_mat, n_mat, conf_mat2] = demographics_2013_CI( question_mat, race, sex, grade, weight, years2 );