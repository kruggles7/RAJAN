%QUESTION 75

cd controls 
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt', '\t'); 
weight=importdata('weight.txt','\t'); 
weight=weight(5:6,:); 
race=race(5:6,:); 
sex=sex(5:6,:); 
cd ..
question_mat=importdata('Q74--NaN.txt', '\t');
[r,c]=size(question_mat); 


for i=1:r
%	total(i)=TOTAL(i,1);
	index_yes{i}=find(question_mat(i,:)==1);
	index_girls{i}=find(sex(i,:)==1);
	index_boys{i}=find(sex(i,:)==2);
	index_W{i}=find(race(i,:)== 1 );
	index_B{i}=find(race(i,:)== 2 );
	index_H{i}=find(race(i,:)== 3 );
	index_O{i}=find(race(i,:)== 4 );
end
% ^for each desired variable we created an array of the indexes (ie. students) who are a "yes" in that variable


for i=1:r
	index_missQ{i}=find(question_mat(i,:)==9); %students who didn't answer the Q
    index_nomiss{i}=find(question_mat(i,:)==0 | question_mat(i,:)==1); %answers that were NOT missing (ie. 0's and 1's / no's and yes's)
end

for i=1:r
	missQ(i)=length(index_missQ{i}); %number of students who answered the question each year
end


for i=1:r
    index_total_b{i}=intersect(index_nomiss{i},index_boys{i}); %index of all boys who answered 
    index_total_g{i}=intersect(index_nomiss{i},index_girls{i}); %index of all girls who answered
end

% totals of each race/sex/combo: (for percentages- to compare those who said yes to total questioned)
for i=1:r
	w=weight(i,:)'; 
    total_ans(i)=nansum(w(index_nomiss{i})); 
    total_girls(i)=nansum(w(index_total_g{i})); %total # of girls who answered
    total_boys(i)=nansum(w(index_total_b{i}));  %total number of boys who answered
	total_W{i}=nansum(w(intersect(index_nomiss{i}, index_W{i}))); %total # of white students who answered
	total_B{i}=nansum(w(intersect(index_nomiss{i}, index_B{i}))); %total # of black students who answered
	total_H{i}=nansum(w(intersect(index_nomiss{i}, index_H{i}))); %total # of hispanic students who answered
	total_O{i}=nansum(w(intersect(index_nomiss{i}, index_O{i}))); %total # of "other" students who answered
	total_Wb(i)=nansum(w(intersect(index_total_b{i},index_W{i}))); 
    total_Wg(i)=nansum(w(intersect(index_total_g{i},index_W{i}))); 
    total_Bb(i)=nansum(w(intersect(index_total_b{i},index_B{i}))); 
    total_Bg(i)=nansum(w(intersect(index_total_g{i},index_B{i}))); 
    total_Hb(i)=nansum(w(intersect(index_total_b{i},index_H{i}))); 
    total_Hg(i)=nansum(w(intersect(index_total_g{i},index_H{i}))); 
    total_Ob(i)=nansum(w(intersect(index_total_b{i},index_O{i}))); 
    total_Og(i)=nansum(w(intersect(index_total_g{i},index_O{i})));  
end 

% %yes-es:
for i=1:r
    w=weight(i,:)'; 
	index_yesgirls{i}=intersect(index_yes{i},index_girls{i});
	index_yesboys{i}=intersect(index_yes{i},index_boys{i});
	yes_girls(i)=nansum(w(index_yesgirls{i}));
	yes_boys(i)=nansum(w(index_yesboys{i}));
	yes_W(i)=nansum(w(intersect(index_yes{i}, index_W{i})));
	yes_B(i)=nansum(w(intersect(index_yes{i}, index_B{i})));
	yes_H(i)=nansum(w(intersect(index_yes{i}, index_H{i})));
	yes_O(i)=nansum(w(intersect(index_yes{i}, index_O{i})));
	yes_WG(i)=nansum(w(intersect(index_yesgirls{i},index_W{i})));
	yes_BG(i)=nansum(w(intersect(index_yesgirls{i},index_B{i})));
	yes_HG(i)=nansum(w(intersect(index_yesgirls{i},index_H{i})));
	yes_OG(i)=nansum(w(intersect(index_yesgirls{i},index_O{i})));
	yes_WB(i)=nansum(w(intersect(index_yesboys{i},index_W{i})));
	yes_BB(i)=nansum(w(intersect(index_yesboys{i},index_B{i})));
	yes_HB(i)=nansum(w(intersect(index_yesboys{i},index_H{i})));
	yes_OB(i)=nansum(w(intersect(index_yesboys{i},index_O{i})));
    total_yes(i)=nansum(w(index_yes{i}));
    total_w(i)=total_W{i}; 
    total_b(i)=total_B{i}; 
    total_h(i)=total_H{i}; 
    total_o(i)=total_O{i};
end

%put them all into a matrix as percent values:
per_mat = zeros(16,r);
for i=1:r
	per_mat(15, i)=total_yes(i)/total_ans(i)*100; %total
	per_mat(14, i)=yes_boys(i)/total_boys(i)*100; %boys
	per_mat(13, i)=yes_girls(i)/total_girls(i)*100; %girls
	per_mat(12, i)=yes_W(i)/total_w(i)*100; %whites
	per_mat(11, i)=yes_B(i)/total_b(i)*100; %blacks
	per_mat(10, i)=yes_H(i)/total_h(i)*100; %hispanics
	per_mat(9, i)=yes_O(i)/total_o(i)*100; %other
	per_mat(8, i)=yes_WB(i)/total_Wb(i)*100; %WB
	per_mat(7, i)=yes_WG(i)/total_Wg(i)*100; %WG
	per_mat(6, i)=yes_BB(i)/total_Bb(i)*100; %BB
	per_mat(5, i)=yes_BG(i)/total_Bg(i)*100; %BG
	per_mat(4, i)=yes_HB(i)/total_Hb(i)*100; %HB
	per_mat(3, i)=yes_HG(i)/total_Hg(i)*100; %HG
	per_mat(2, i)=yes_OB(i)/total_Ob(i)*100; %OB
	per_mat(1, i)=yes_OG(i)/total_Og(i)*100; %OG
end

per_mat=flipud(per_mat); 
