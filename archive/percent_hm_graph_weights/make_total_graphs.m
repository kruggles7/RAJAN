heatmap=1;
graph=1;

% reads all the text files in the folder 'binary_NaN_files' and saves them in an array called files
% make sure that folder contains only the NaN files for the questions you want to run create_hm_graph for

cd controls  
weight=importdata('weight.txt','\t'); 
cd ..

q3_mat=importdata('Q03--NaN.txt', '\t');
for i=1:r
%	total(i)=TOTAL(i,1);
	index_yes{i}=find(q3_mat(i,:)==1);
    index_missQ{i}=find(q3_mat(i,:)==9); %students who didn't answer the Q
end

for i=1:r
    w=weight(i,:)'; 
    total_ans(i)=nansum(w(index_nomiss{i})); 
    total_yes(i)=nansum(w(index_yes{i}));
    q3_total=total_yes(i)/total_ans(i)*100; %total
end 

q4_mat=importdata('Q04--NaN.txt', '\t');
for i=1:r
%	total(i)=TOTAL(i,1);
	index_yes{i}=find(q4_mat(i,:)==1);
    index_missQ{i}=find(q4_mat(i,:)==9); %students who didn't answer the Q
end

for i=1:r
    w=weight(i,:)'; 
    total_ans(i)=nansum(w(index_nomiss{i})); 
    total_yes(i)=nansum(w(index_yes{i}));
    q4_total=total_yes(i)/total_ans(i)*100; %total
end 

q5_mat=importdata('Q05--NaN.txt', '\t');
for i=1:r
%	total(i)=TOTAL(i,1);
	index_yes{i}=find(q5_mat(i,:)==1);
    index_missQ{i}=find(q5_mat(i,:)==9); %students who didn't answer the Q
end

for i=1:r
    w=weight(i,:)'; 
    total_ans(i)=nansum(w(index_nomiss{i})); 
    total_yes(i)=nansum(w(index_yes{i}));
    q5_total=total_yes(i)/total_ans(i)*100; %total
end 