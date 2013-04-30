function [ A ] = hispanic_sex_condition( question_mat, question_name, sex, race_hispanic )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%find the total number of samples and missing for each year when we are
%looking at both sex and race 
[r,c]=size(question_mat); 
total=zeros(6,1); 
girls_mat=zeros(r,2,2); 
boys_mat=zeros(r,2,2); 
girls_percent=zeros(r,2,2); 
boys_percent=zeros(r,2,2); 

for i=1:6 %each year
    no_mat=find(question_mat(i,:)==0); 
    yes_mat=find(question_mat(i,:)==1); 
    with_missing=numel(question_mat(i,:)); 
    total(i,1)=numel(no_mat)+numel(yes_mat); 
    missing=with_missing-total; 
end

%first split by gender then make a matrix with rows of years, columns of q1
%answers and z split by race 

for i=1:r
    for j=2:c
        a=question_mat(i,j)+1; 
        b=sex(i,j);   
        d=race_hispanic(i,j)+1; 
        if ((race_hispanic(i,j)~=9) && (question_mat(i,j)~=9))
            if b==1
                girls_mat(i,a,d)= girls_mat(i,a,d)+1; 
            elseif b==2
                boys_mat(i,a,d)= boys_mat(i,a,d)+1; 
            end
        end 
    end 
    boys_percent(i,:,:)=boys_mat(i,:,:)/total(i,1)*100; 
    girls_percent(i,:,:)=girls_mat(i,:,:)/total(i,1)*100; 
end 

%graph males and females on separate graphs for each year by gender for
%each question 
s={'-*r', '-*b'}; % '-*m', '-*k'}; %, 'go', 'cx', 'y*', 'r*', 'bo', 'ks', 'g<', 'mx'}; %use to cycle through markers 
count_s=1; 
j=figure; 
j1=subplot(2,1,1); 
x=1:6; 
for j=1:2
    plot(x,girls_percent(:,2,j),s{count_s}); 
    hold on; 
    count_s=count_s+1; 
end 

title ('Girls'); 
set(gca,'XTickLabel',[2001:2:2011]); 
ylabel('Percent YES');
%xlim([1999 2013]); 
%xlabel('Years'); 
hold off; 
legend ('Non-hispanic','Hispanic','Location', 'EastOutside'); 
j2=subplot(2,1,2); 
x=1:6; 
count_s=1; 
for j=1:2
    plot (x,boys_percent(:,2,j),s{count_s}); 
    hold on; 
    count_s=count_s+1; 
end  
set(gca,'XTickLabel',[2001:2:2011]); 
ylabel('Percent YES');
title ('Boys'); 
%xlim([1999 2013]); 
%xlabel('Years'); 
hold off; 
legend ('Non-hispanic','Hispanic','Location', 'EastOutside'); 
print (gcf,'-dpng', [question_name '_RACE_hispanic']);


A=1; 
end

