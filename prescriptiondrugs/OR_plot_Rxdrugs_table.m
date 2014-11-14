%make heatmaps out of the relative risk matrix 

cd ..
cd ..
cd matrices
load OR_2013_100714
load OR_CI_2013_100714
load qlabel_033014

table_mat=cell.empty; 
table_mat(:,1)={'Ever used cocaine', 'Ever used heroin', 'Ever used methamphetamine',  'Ever injected Drugs', 'Ever used Ecstasy', 'Ever drink alcohol','Drank alcohol*','Had 5+ alcoholic drinks*', 'Ever used marijuana', 'Used marijuana*', 'Ever smoked cigarettes', 'Smoked cigarettes*', 'Felt sad or hopeless^', 'Considered suicide^', 'Planned suicide^', 'Attempted Suicide^', 'Fasted to lose weight*', 'Took pill to lose weight*','Vomited to lose weight*', 'Carried a weapon*', 'Carried a gun*', 'Carried a weapon at school*', 'Felt unsafe at school*', 'Been threatened at school*', 'Been in a fight*','Ever been forced to have sex', 'Been bullied at school^', 'Been electronically bullied^', 'Ridden with a driver who was drinking*'};   
questions={'Q25','Q28','Q29','Q31','Q32', 'Q17','Q18','Q19','Q21','Q23','Q53', 'Q55', 'Q11','Q12','Q13','Q16', 'Q38','Q39','Q40','Q01', 'Q02', 'Q03', 'Q04', 'Q05', 'Q06','Q10', 'Q74', 'Q75', 'Q50'}; 

ques='Q79'; 
OR=odds_ratio_cell; 
[r,c]=size(OR); 
OR=OR(2:r,:); 
indx=find(strcmp(OR(:,1),'Q79')==1); %put in the number for Rx drugs
xlab=OR(indx,2); 
OR=OR(indx,7:9); 
[r,c]=size(OR_CI); 
or_ci=OR_CI(2:r,:); 
indx=find(strcmp(or_ci(:,1),'Q79')==1); 
or_ci=or_ci(indx,7:9); 

table_mat2=double.empty; 
count=1; 

avg_mat=double.empty; 

for i=1:numel(questions)
    indx=find(strcmp(xlab, questions{i})==1); 
    table_mat2{count,1}=table_mat{i,1}; 
    if numel(indx)>0
        for j=1:3
            temp=sprintf('%.1f',OR{indx,j});%num2str(OR{indx,j}); 
            temp2=or_ci{indx,j}; 
            num1='';
            num2=''; 
            a2=char(temp2);
            b2=strfind(a2,',');
            if (numel(b2)>0)
                for m=1:(b2(1)-1)
                    c2=a2(m);
                    num1=[num1 c2];
                end
                for m=b2(1)+2:numel(a2)
                    c2=a2(m);
                    num2=[num2 c2];
                end
                num1_=str2double(num1); 
                num2_=str2double(num2); 
                lower=exp(num1_); 
                upper=exp(num2_); 
                l=sprintf('%.1f',lower); %num2str(lower); 
                u=sprintf('%.1f',upper);%num2str(upper); 
            
                table_mat{i,j+1}=[temp ' (' l ', ' u ')']; 
                table_mat2{count, j+1}=temp; 
                table_mat2{count+1, j+1}=['(' l ', ' u ')']; 
                avg_mat(i,j)=OR{indx,j}; 
            end
        end 
        count=count+2; 
    end 
end 
       
indx=find((avg_mat)==0); 
avg_mat(indx)=NaN; 
mean=nanmean(avg_mat,2); 

