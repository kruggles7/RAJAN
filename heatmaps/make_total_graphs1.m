heatmap=1;
graph=1;

% reads all the text files in the folder 'binary_NaN_files' and saves them in an array called files
% make sure that folder contains only the NaN files for the questions you want to run create_hm_graph for

cd controls  
weight=importdata('weight.txt','\t'); 
cd ..

%%%question 3-----------------------------------------------
q3_mat=importdata('Q03--NaN.txt', '\t');
[r,c]=size(q3_mat); 
for i=1:r
%	total(i)=TOTAL(i,1);
	index_yes{i}=find(q3_mat(i,:)==1);
    index_nomiss{i}=find(q3_mat(i,:)==0 | q3_mat(i,:)==1); %answers that were NOT missing (ie. 0's and 1's / no's and yes's)
end

for i=1:r
    w=weight(i,:)'; 
    total_ans(i)=nansum(w(index_nomiss{i})); 
    total_yes(i)=nansum(w(index_yes{i}));
    q3_total(i)=total_yes(i)/total_ans(i)*100; %total
end 

%%%question 4-----------------------------------------------
q4_mat=importdata('Q04--NaN.txt', '\t');
[r,c]=size(q4_mat); 
for i=1:r
%	total(i)=TOTAL(i,1);
	index_yes{i}=find(q4_mat(i,:)==1);
    index_nomiss{i}=find(q4_mat(i,:)==0 | q4_mat(i,:)==1); %answers that were NOT missing (ie. 0's and 1's / no's and yes's)
end

for i=1:r
    w=weight(i,:)'; 
    total_ans(i)=nansum(w(index_nomiss{i})); 
    total_yes(i)=nansum(w(index_yes{i}));
    q4_total(i)=total_yes(i)/total_ans(i)*100; %total
end 

%%%question 5-----------------------------------------------
q5_mat=importdata('Q05--NaN.txt', '\t');
[r,c]=size(q5_mat); 
for i=1:r
%	total(i)=TOTAL(i,1);
	index_yes{i}=find(q5_mat(i,:)==1);
    index_nomiss{i}=find(q5_mat(i,:)==0 | q5_mat(i,:)==1); %answers that were NOT missing (ie. 0's and 1's / no's and yes's)
end

for i=1:r
    w=weight(i,:)'; 
    total_ans(i)=nansum(w(index_nomiss{i})); 
    total_yes(i)=nansum(w(index_yes{i}));
    q5_total(i)=total_yes(i)/total_ans(i)*100; %total
end 

x=[2001; 2003; 2005; 2007; 2009; 2011]; 
f=figure; 
plot(x,q3_total, '-ko', 'MarkerFaceColor', 'k'); 
hold on
plot(x,q4_total,'--ks', 'MarkerFaceColor', 'k'); 
plot(x,q5_total, ':kd', 'MarkerFaceColor', 'k'); 
hold off
xlim([2000 2012]);
max3=max(q3_total); 
max4=max(q4_total); 
max5=max(q5_total); 
maxT=max([max3; max4; max5]); 
maxT=maxT+0.1*maxT; 
ylim([0 maxT]); 
set(gca, 'XTick', x); 
set(gca, 'XTickLabels', x); 

legend ('Carried a weapon to school', 'Felt unsafe at school', 'Threatened at school', 'Location', 'SouthWest');  
xlabel('Year','FontSize', 12);  
ylabel('% of Respondents Answering Positively', 'FontSize', 12); 
set (gca, 'FontSize',12); 
print (gcf,'-dmeta', 'Fig1d.emf' );