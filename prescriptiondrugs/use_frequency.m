files1=dir(fullfile('C:','Users','kruggles7','Documents','MATLAB', 'CDC', 'data','cat_results_010314', '*.txt'));

cd ..
cd ..
cd data
cd cat_results_010314
index_yes=double.empty; 

questions={'Q79', 'Q27', 'Q29', 'Q25', 'Q32' }; 
labels={'Prescription Drugs', 'Heroin', 'Methamphetamine', 'Cocaine',  'Ecstasy'}; 
P=length(questions);
total=double.empty; 
for n=1:P
    q1=questions{n}; 
    q_name=[q1 '-cat-NaN.txt']; 
    quest_1=importdata(q_name, '\t');
    [r1,c1]=size(quest_1);
    q1_2011=quest_1(r1,2:c1); 
    max_=max(q1_2011);                 
    index_miss=find(q1_2011==0); %students who didn't answer Q1
    for i=2:max_
        indx=find(q1_2011==i); 
        index_yes(n, i-1)=numel(indx); 
    end  
    indx_total=find(q1_2011>0);
    total(n)=numel(indx_total);
end

sum_yes=sum(index_yes,2); 
[r,c]=size(index_yes); 
percent=zeros(r,c); 
for n=1:c
    for m=1:r
        percent(m,n)=index_yes(m,n)/sum_yes(m,1); 
    end
end 

bar (percent, 'stacked'); 
ylim([0 1]); 
set(gca, 'xticklabel', labels); 
legend('1 or 2 times','3 to 9 times', '10 to 19 times', '20 to 39 times', '40 or more times', 'Location','EastOutside' );  

cd ..
cd ..
cd programs
cd prescriptiondrugs
cd results
saveas (gca, 'PO_drugs_frequency_percentage.fig'); 
close 

 
[r,c]=size(index_yes); 
freq=zeros(r,c); 
for n=1:c
    for m=1:r
        freq(m,n)=index_yes(m,n)/total(n)*100; 
    end
end 

bar(index_yes,'stacked'); 
set(gca, 'xticklabel', labels); 
set(gca, 'xticklabel', labels); 
legend('1 or 2 times','3 to 9 times', '10 to 19 times', '20 to 39 times', '40 or more times', 'Location','NorthEast' );  
ylabel('Number of participants surveyed'); 
saveas (gca, 'PO_drugs_frequency.fig'); 
close 

bar(freq,'stacked'); 
set(gca, 'xticklabel', labels); 
set(gca, 'xticklabel', labels); 
legend('1 or 2 times','3 to 9 times', '10 to 19 times', '20 to 39 times', '40 or more times', 'Location','NorthEast' ); 
ylabel('Percent of participants surveyed'); 
saveas (gca, 'PO_drugs_frequency_total.fig'); 

