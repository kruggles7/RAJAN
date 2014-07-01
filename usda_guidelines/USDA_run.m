%redo everything with categorical data (>=5)-----------------------
cd ..
cd ..
cd data
cd controls
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt', '\t'); 
weight=importdata('weight.txt','\t'); 
grade=importdata('grade-NaN.txt','\t'); 
[r,c]=size(sex); 
weight=weight(:,2:c); 
race=race(:,2:c); 
sex=sex(:,2:c); 
grade=grade(:,2:c);

cd .. 
cd .. 
cd programs 
cd sleep

%FRUITS AND VEGGIES--------------------------------------------------
%Vegetables and fruits=2.5-6.5 fruits/vegetables 2010
%Q42(fruit in 1 week): 1: 0, 2: 1-3 times, 3: 4-6 times, D:1 time/day, E: 2
%times/day, F:3 times/day, G: 4 times/day
%Q43 salad (in a week): 1: 0, 2: 1-3 times, 3: 4-6 times, D:1 time/day, E: 2
%times/day, F:3 times/day, G: 4 times/day
%Q46 (vegetables in a week): 1: 0, 2: 1-3 times, 3: 4-6 times, D:1 time/day, E: 2
%times/day, F:3 times/day, G: 4 times/day
%---make the cutoff at least 2.5 fruits/veggies per day = 2.5*7=17.5~18
%
cd ..
cd ..
cd data
cd results_020314
cd cat
question_mat1=importdata('Q42-cat-NaN.txt', '\t'); 
[r,c]=size(question_mat1); 
question_mat1=question_mat1(:,2:c); 
question_mat1(question_mat1==0)=NaN;
question_mat1(question_mat1==7)=4*7; 
question_mat1(question_mat1==6)=3*7; 
question_mat1(question_mat1==5)=2*7; 
question_mat1(question_mat1==4)=7; 
question_mat1(question_mat1==3)=4; 
question_mat1(question_mat1==2)=1; 
question_mat1(question_mat1==1)=0; 

question_mat2=importdata('Q43-cat-NaN.txt', '\t'); 
[r,c]=size(question_mat2); 
question_mat2=question_mat2(:,2:c); 
question_mat2(question_mat2==0)=NaN;
question_mat2(question_mat2==7)=4*7; 
question_mat2(question_mat2==6)=3*7; 
question_mat2(question_mat2==5)=2*7; 
question_mat2(question_mat2==4)=7; 
question_mat2(question_mat2==3)=4; 
question_mat2(question_mat2==2)=1; 
question_mat2(question_mat2==1)=0; 

question_mat3=importdata('Q46-cat-NaN.txt', '\t'); 
[r,c]=size(question_mat3); 
question_mat3=question_mat3(:,2:c); 
question_mat3(question_mat3==0)=NaN;
question_mat3(question_mat3==7)=4*7; 
question_mat3(question_mat3==6)=3*7; 
question_mat3(question_mat3==5)=2*7; 
question_mat3(question_mat3==4)=7; 
question_mat3(question_mat3==3)=4; 
question_mat3(question_mat3==2)=1; 
question_mat3(question_mat3==1)=0; 

question_final=question_mat1+question_mat2; 
question_final=question_final+question_mat3; 
 
label='fruit_veggies_18perweek'; 
cd .. 
cd ..
cd ..
cd programs
cd USDA_guidelines

USDA(sex, grade, race, weight, question_final, 18,label); 

%milk, 3 cups per day
%Q47 (milk in a week): 1: 0, 2: 1-3 times, 3: 4-6 times, 4:1 time/day, 5: 2
%times/day, 6:3 times/day, 7: 4 times/day
cd ..
cd ..
cd data
cd results_020314
cd cat
question_mat1=importdata('Q47-cat-NaN.txt', '\t'); 
[r,c]=size(question_mat1); 
question_mat1=question_mat1(:,2:c); 
label='milk_3timesday'; 
cd .. 
cd ..
cd ..
cd programs
cd USDA_guidelines
USDA (sex, grade, race, weight, question_mat1,6, label); 

%physical activities 60 minutes per day 
%Q33 (PE class): 1: 0 days, 2: 1 day, 3: 2 days, 4: 3 days, 5: 4 days, 6; 5
%days
%Q81 (physical activity 60 minutes): 1: 0 days, 2: 1 day, 3: 2 days, 4: 3
%days, 5: 4 days, 6: 5 days, 7:6 days, 8:7 days

cd ..
cd ..
cd data
cd results_020314
cd cat
question_mat1=importdata('Q33-cat-NaN.txt', '\t'); 
[r,c]=size(question_mat1); 
question_mat1=question_mat1(3:6,2:c); 
question_mat1(question_mat1==0)=NaN;
question_mat1(question_mat1==1)=0; 
question_mat1(question_mat1==2)=1; 
question_mat1(question_mat1==3)=2; 
question_mat1(question_mat1==4)=3; 
question_mat1(question_mat1==5)=4; 
question_mat1(question_mat1==6)=5; 

question_mat2=importdata('Q81-cat-NaN.txt', '\t'); 
[r,c]=size(question_mat2); 
question_mat2=question_mat2(:,2:c); 
question_mat2(question_mat2==0)=NaN;
question_mat2(question_mat2==1)=0; 
question_mat2(question_mat2==2)=1; 
question_mat2(question_mat2==3)=2; 
question_mat2(question_mat2==4)=3; 
question_mat2(question_mat2==5)=4; 
question_mat2(question_mat2==6)=5; 
question_mat2(question_mat2==7)=6; 
question_mat2(question_mat2==8)=7; 

question_final=question_mat1+question_mat2; 
label='physical_activity_perday'; 
cd .. 
cd ..
cd ..
cd programs
cd USDA_guidelines

USDA(sex, grade, race, weight, question_final, 7,label); 