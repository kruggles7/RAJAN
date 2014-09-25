
cd ..
cd ..
cd data
cd Controls_061514
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt', '\t'); 
weight=importdata('weights-NaN.txt','\t'); 
grade=importdata('grade-NaN.txt','\t'); 
[r,c]=size(sex); 
xlabel_w=weight(:,1); 
weight=weight(:,2:c); 
race=race(:,2:c); 
sex=sex(:,2:c); 
grade=grade(:,2:c); 
cd ..
cd results_091614
cd cat
question_mat=importdata('Q80-cat-NaN.txt', '\t');
[r,c]=size(question_mat); 

%Q59: texting, "YES">=3
%Q06: been in a fight "YES">=2
%Q04: felt unsafe at school "YES">=2
%Q74:bullied at school "YES"==1
%Q12: considered suicide "YES"==1
%Q13: made a plan for suicide "YES"==1
%Q16: attempted suicide "YES">=2
%Q81: physical active 5 of past 7 days "YES">=6
%Q35: watched TV 3 or more hours "YES">=5

others={'Q59', 'Q06', 'Q04', 'Q74', 'Q12', 'Q13', 'Q16', 'Q81', 'Q35'}; 
other_mat=[3, 2, 2, 1, 1, 1, 2, 6, 5]; 
other_do=[1, 1, 1, 0, 0, 0, 1, 1, 1];  
other_total=[1, 0, 0, 0, 0, 0, 0, 0, 0, 0]; %if denominator is different than ALL
conf_mat=cell(9,r); 
conf_mat(:,1)=others; 
total=zeros(9,7,7); 
n_mat=zeros(9,7); 
x5_mat=zeros(9,7); 
x9_mat=zeros(9,7);
xlabel_all=[2001, 2003, 2005, 2007, 2009, 2011, 2013]; 
%sleep key A(1)=4 hours or less,  B(2)=5 hours, C(3)=6 hours D(4)=7 hours
%E(5)=8 hours, %F(6)=9 hours, %G(7)=10 hours or more
%split by <=6 hours and >=8 hours
xlabel1=question_mat(:,1); 
question_mat=question_mat(:,2:c); 
years=cell.empty; 

for i=1:numel(xlabel_all); 
    year=xlabel_all(i); 
    indx1=find(year==xlabel1); 
    indx_w=find(year==xlabel_w); 
    for k=1:numel(others)
        question_mat2=importdata([others{k} '-cat-NaN.txt'], '\t'); 
        [r,c2]=size(question_mat2); 
        xlabel2=question_mat2(:,1); 
        indx2=find(year==xlabel2); 
        
        question_mat2=question_mat2(:,2:c2); 
        if numel(indx1)>0 && numel(indx2)>0
            years{i}=year; 
            for j=1:7
                q1=question_mat(indx1,:); 
                q2=question_mat2(indx2,:); 
                [r1,c1]=size(question_mat); 
                [r2,c2]=size(question_mat2); 
                min_c=min(c1,c2); 
                q1_=q1(1,1:min_c);
                q2_=q2(1,1:min_c); 
                w=weight(indx_w,1:min_c); 

                index_yes=find(q1_==j);
                if (other_do(k)==1)
                    index_yes2=find(q2_>=other_mat(k)); 
                else 
                    index_yes2=find(q2_==other_mat(k)); 
                end 

                index_missQ=find(q1_== 0 | q2_==0); %students who didn't answer the Q
                index_nomiss=find(q1_>0 & q2_>other_total(k)); 
             

                index_overlap=intersect(index_yes,index_yes2); %index of all all who participated in both behaviors
                index_overlap2=intersect(index_overlap,index_nomiss); 
                total_ans=nansum(w(index_nomiss)); 
                yes_overlap=nansum(w(index_overlap2));
                n=total_ans; 
                n_mat (k,i)=n;
                if (j<=3) %6 hours or less 
                    x5=yes_overlap; 
                    x5_mat(k,i)=x5_mat(k,i)+x5; 
                end 

                if (j>=5) %6 hours or less 
                    x9=yes_overlap; 
                    x9_mat(k,i)=x9_mat(k,i)+x9; 
                end 
                total(k,j,i)=yes_overlap/total_ans*100; %total
            end 
        end 
    end
end

c=1; 

c2=1; 
%sleep key A(1)=4 hours or less,  B(2)=5 hours, C(3)=6 hours D(4)=7 hours
%E(5)=8 hours, %F(6)=9 hours, %G(7)=10 hours or more
    final_total=double.empty; 
for i=1:7
    final_total(:,c)=total(:,c2,i)+total(:,c2+1,i) + total(:,c2+2,i) ; 
    final_total(:,c+1)=total(:,c2+4,i) + total(:,c2+5,i) + total(:,c2+6,i); 
    c=c+2; 
end 

z=1.96; 
[r,c]=size(n_mat); 
for i=1:r
    count=2; 
    for j=1:c
        x=x5_mat(i,j); 
        n=n_mat(i,j); 
        p=x/n;  %x is the number of subjects saying "yes", n is the total subjects
        upper=((p+z*sqrt(p*(1-p)/n))*100); 
        lower=((p-z*sqrt(p*(1-p)/n))*100); 
        upper=sprintf('%0.1f',round(upper*10)/10);
        lower=sprintf('%0.1f',round(lower*10)/10);  
        conf_mat{i+1,count}=[lower ', ' upper]; 
        x=x9_mat(i,j); 
        n=n_mat(i,j); 
        p=x/n;  %x is the number of subjects saying "yes", n is the total subjects
        upper=((p+z*sqrt(p*(1-p)/n))*100); 
        lower=((p-z*sqrt(p*(1-p)/n))*100); 
        upper=sprintf('%0.1f',round(upper*10)/10);
        lower=sprintf('%0.1f',round(lower*10)/10); 
        conf_mat{i+1,count+1}=[lower ', ' upper]; 
        count=count+2; 
    end 
end 