
cd ..
cd ..
cd data
cd Controls_061514
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt', '\t'); 
weight=importdata('weights-NaN.txt','\t'); 
grade=importdata('grade-NaN.txt','\t'); 
[r,c]=size(sex); 
weight=weight(4:7,2:c); 
race=race(4:7,2:c); 
sex=sex(4:7,2:c); 
grade=grade(4:7,2:c); 
cd ..
cd results_061514
cd cat

index_yes=double.empty; 

quest_1=importdata('Q80-cat-NaN.txt', '\t');
[r1,c1]=size(quest_1);
quest_1=quest_1(:,2:c1); 
labels={ '2007',  '2009', '2011', '2013'}; 
max_=max(max(quest_1));  

total=double.empty; 
for n=1:r1
    q1=quest_1(n,:);                
    index_miss=find(q1==0); %students who didn't answer Q1
    index_nomiss=find(q1>0); 
    w=weight(n,:); 
    total_ans(n)=nansum(w(index_nomiss)); 
    for i=1:max_
        indx=find(q1==i); 
        total_yes(n, i)=nansum(w(indx)); 
    end  
end

sum_yes=sum(total_yes,2); 
[r,c]=size(total_yes); 
percent=zeros(r,c); 
for n=1:c
    for m=1:r
        percent(m,n)=total_yes(m,n)/total_ans(m); 
    end
end 

percent=percent*100; 
bar (percent, 'stacked'); 
ylim([0 100]); 
set(gca, 'xticklabel', labels); 
ylabel('Percent of subjects answering for each response'); 
legend('4 hours or less','5 hours', '6 hours', '7 hours', '8 hours', '9 hours', '10 hours+', 'Location','EastOutside' );  

cd ..
cd ..
cd ..

cd programs
cd sleep
saveas (gcf, 'sleep_frequency.fig'); 
print (gcf, '-depsc2', 'sleep_frequency.eps'); 
close 
