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

%PO Q79
%Heroin %Q28
%Injection Drugs %Q31
cat_mat=double.empty; 
NaN_mat=double.empty; 
start_year=5; 
end_year=7; 
title={'year', 'weight', 'race', 'sex', 'grade'}; 
Q={'Q79' 'Q28', 'Q31'}; 
[r,c]=size(sex); 
weight=weight(start_year:end_year,2:c); 
race=race(start_year:end_year,2:c); 
sex=sex(start_year:end_year,2:c); 
grade=grade(start_year:end_year,2:c); 
    
for j=1:numel(Q)
    ques=Q{j}; 
    cd cat
    title{5+j}=ques; 
    question_mat=importdata([ques '-cat-NaN.txt'], '\t');
    cd ..
    cd NaN
    question_nan=importdata([ques '--NaN.txt'], '\t'); 
    cd ..
    [r,c]=size(question_mat); 
    labels=question_mat(:,1);
    question_mat=question_mat(:,2:c); 
    question_nan=question_nan(:,2:c); 
    years=[2009 2011 2013]; 
    count=1; 
    count_end=C; 
    C=c-1; 
    for i=1:numel(years)
        cat_mat(count:count_end,1)=ones(C,1)*years(i); 
        NaN_mat(count:count_end,1)=ones(C,1)*years(i); 
        cat_mat(count:count_end,2)=weight(i,:)'; 
        NaN_mat(count:count_end,2)=weight(i,:)'; 
        cat_mat(count:count_end,3)=race(i,:)'; 
        NaN_mat(count:count_end,3)=race(i,:)'; 
        cat_mat(count:count_end,4)=sex(i,:)'; 
        NaN_mat(count:count_end,4)=sex(i,:)'; 
        cat_mat(count:count_end,5)=grade(i,:)'; 
        NaN_mat(count:count_end,5)=grade(i,:)'; 
        indx=find(labels==years(i)); 
        cat_mat(count:count_end,5+j)=question_mat(indx,:)'; 
        NaN_mat(count:count_end,5+j)=question_nan(indx,:)'; 
        count=count+C; 
        count_end=count_end+C; 
    end 
end 

    [r,c]=size(cat_mat); 
    %remove NaNs 
    indx=find(isnan(cat_mat(:,6))==0 & isnan(cat_mat(:,7))==0 & isnan(cat_mat(:,8))==0);
    cat_mat_=cat_mat(indx,:); 
    indx=find(isnan(NaN_mat(:,6))==0 & isnan(NaN_mat(:,7))==0 & isnan(NaN_mat(:,8))==0);
    NaN_mat_=NaN_mat(indx,:); 