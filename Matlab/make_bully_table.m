%find the total number of samples and missing for each year when we are
%looking at both sex and race 


question_mat=importdata('Q74--NaN.txt', '\t');
%question_mat=importdata('Q75--NaN.txt', '\t');
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt','\t'); 

[r,c]=size(question_mat); 
total=zeros(r,1); 
girls_mat=zeros(r,4); 
boys_mat=zeros(r,4); 
girls_percent=zeros(r,4); 
boys_percent=zeros(r,4); 

for i=1:r
    no_mat=find(question_mat(i,:)==0);  %answers "no"
    yes_mat=find(question_mat(i,:)==1); %answers "yes" 
    total(i,1)=numel(no_mat)+numel(yes_mat); %total number answered  
end

%find the total number of white boys, black boys etc who were questions 
girls_total=zeros(4,2); 
boys_total=zeros(4,2); 

for i=1:r
    for j=2:c
        a=race(i,j); 
        b=sex(i,j); 
        if ((a>0) && (b>0))
            if b==1 %girls 
                girls_total(a,i)=girls_total(a,i)+1; 
            elseif b==2
                boys_total(a,i)=boys_total(a,i)+1; 
            end
        end 
    end 
end 

%first split by gender then make a matrix with rows of years, columns of q1
%answers and z split by race 

for i=1:r
    for j=2:c
        a=question_mat(i,j); 
        b=sex(i,j);   
        d=race(i,j); 
        if (race(i,j)>0) && (question_mat(i,j)==1) 
            if b==1
                girls_mat(i,d)= girls_mat(i,d)+1; 
            elseif b==2
                boys_mat(i,d)= boys_mat(i,d)+1; 
            end
        end
    boys_percent(i,:)=boys_mat(i,:)/total(i,1)*100; 
    girls_percent(i,:)=girls_mat(i,:)/total(i,1)*100; 
    end 
end 

[r,c]=size(girls_mat); 
girls_mat_percent=zeros(r,c,z); 
boys_mat_percent=zeros(r,c,z); 
for j=1:r
    for i=1:z
        girls_mat_percent(j,:,i)=girls_mat(j,:,i)/girls_total(i,j)*100; 
        boys_mat_percent(j,:,i)=boys_mat(j,:,i)/boys_total(i,j)*100; 
    end 
end

total_trend=zeros(r,3); %column1:girls, column2:boys, column3:total
for j=1:r %for each year
    total_trend(j,1)=sum(girls_mat(j,1,:))/sum(girls_total(:,j))*100; 
    total_trend(j,2)=sum(boys_mat(j,1,:))/sum(boys_total(:,j))*100; 
    k=sum(girls_mat(j,1,:));
    l=sum(boys_mat(j,1,:));
    total_trend(j,3)=(k+l)/total(j,1)*100; 
    %total_trend(j,3)
    %total(j,1)
    %total_trend(j,4)=sum(girls_mat(j,2,:))/total(j,1)*100; 
    %total_trend(j,5)=sum(boys_mat(j,2,:))/total(j,1)*100; 
end 

girls_percent=girls_mat_percent; 
boys_percent=boys_mat_percent;

mat_new=zeros(11,2); 
mat_new(11,1:r)=total_trend(:,3); %total
mat_new(10,1:r)=total_trend(:,2); %boys
mat_new(9,1:r)=total_trend(:,1); %girls
mat_new(8,1:r)=boys_percent(:,1,1); %WB
mat_new(7,1:r)=girls_percent(:,1,1); %WG
mat_new(6,1:r)=boys_percent(:,1,2); %BB
mat_new(5,1:r)=girls_percent(:,1,2); %BG
mat_new(4,1:r)=boys_percent(:,1,3); %HB
mat_new(3,1:r)=girls_percent(:,1,3); %HG
mat_new(2,1:r)=boys_percent(:,1,4); %OB
mat_new(1,1:r)=girls_percent(:,1,4); %OG