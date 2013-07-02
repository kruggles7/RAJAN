function [per_mat_map] = combo_hm_NEW( question_mat, filename, title1 ,sex, race, TOTAL, heatmap, graph )
% COMBO_HM_NEW takes in the question binary matrix (rows= years,
% columns=subjects) and outputs and outputs the summary matrix with the percentage of "yes" in each subgroup.
%   Input variables: 
%       QUESTION_MAT: binary matrix for question (row=years, column=subjects) 
%       FILENAME: name of the question for file saving
%       TITLE: label for the graphs (question)
%       SEX: sex matrix (already made and in folder)
%       RACE: race matrix (already made and in folder)
%       TOTAL: total number of subejects per year (already made and in
%       folder)
%		HEATMAP: 1 for yes, 0 for no
%		GRAPH: 1 for yes, 0 for no
% also makes a heatmap and/or graph out of the output matrix matrix and saves them as PDFs 


[r,c]=size(question_mat); 

for (i=1:r)
	total(i)=TOTAL(i,1);
	index_yes{i}=find(question_mat(i,:)==1);
	index_girls{i}=find(sex(i,:)==1);
	index_boys{i}=find(sex(i,:)==2);
%	index_W{i}=find(race(i,:)== 1 );
%	index_B{i}=find(race(i,:)== 2 );
%	index_H{i}=find(race(i,:)== 3 );
%	index_O{i}=find(race(i,:)== 4 );
	index_W{i}=find(race(i,:)== 5 );
	index_B{i}=find(race(i,:)== 3 );
	index_H{i}=find(race(i,:)==6 | race(i,:)==7 );
	index_O{i}=find(race(i,:)==1 | race(i,:)==2 | race(i,:)==4 | race(i,:)==8 );
end
% ^for each desired variable we created an array of the indexes (ie. students) who are a "yes" in that variable


for i=1:r
	index_missQ{i}=find(question_mat(i,:)==9); %students who didn't answer the Q
    index_nomiss{i}=find(question_mat(i,:)==0 | question_mat(i,:)==1); %answers that were NOT missing (ie. 0's and 1's / no's and yes's)
end
for i=1:r
	missQ(i)=length(index_missQ{i});
end


for i=1:r
    index_total_b{i}=intersect(index_nomiss{i},index_boys{i}); %index of all boys who answered 
    index_total_g{i}=intersect(index_nomiss{i},index_girls{i}); %index of all girls who answered

end

% totals of each race/sex/combo: (for percentages- to compare those who said yes to total questioned)
for i=1:r
	total_ans(i)=length(index_nomiss{i});  %total # of students who answered the given question
    total_girls(i)=length(index_total_g{i}); %total # of girls who answered
    total_boys(i)=length(index_total_b{i});  %total number of boys who answered
	total_W{i}=length(intersect(index_nomiss{i}, index_W{i})); %total # of white students who answered
	total_B{i}=length(intersect(index_nomiss{i}, index_B{i})); %total # of black students who answered
	total_H{i}=length(intersect(index_nomiss{i}, index_H{i})); %total # of hispanic students who answered
	total_O{i}=length(intersect(index_nomiss{i}, index_O{i})); %total # of "other" students who answered
	total_Wb(i)=length(intersect(index_total_b{i},index_W{i})); 
    total_Wg(i)=length(intersect(index_total_g{i},index_W{i})); 
    total_Bb(i)=length(intersect(index_total_b{i},index_B{i})); 
    total_Bg(i)=length(intersect(index_total_g{i},index_B{i})); 
    total_Hb(i)=length(intersect(index_total_b{i},index_H{i})); 
    total_Hg(i)=length(intersect(index_total_g{i},index_H{i})); 
    total_Ob(i)=length(intersect(index_total_b{i},index_O{i})); 
    total_Og(i)=length(intersect(index_total_g{i},index_O{i}));  
end 

%yes-es:
for i=1:r
	index_yesgirls{i}=intersect(index_yes{i},index_girls{i});
	index_yesboys{i}=intersect(index_yes{i},index_boys{i});
	yes_girls(i)=length(index_yesgirls{i});
	yes_boys(i)=length(index_yesboys{i});
	yes_W(i)=length(intersect(index_yes{i}, index_W{i}));
	yes_B(i)=length(intersect(index_yes{i}, index_B{i}));
	yes_H(i)=length(intersect(index_yes{i}, index_H{i}));
	yes_O(i)=length(intersect(index_yes{i}, index_O{i}));
	yes_WG(i)=length(intersect(index_yesgirls{i},index_W{i}));
	yes_BG(i)=length(intersect(index_yesgirls{i},index_B{i}));
	yes_HG(i)=length(intersect(index_yesgirls{i},index_H{i}));
	yes_OG(i)=length(intersect(index_yesgirls{i},index_O{i}));
	yes_WB(i)=length(intersect(index_yesboys{i},index_W{i}));
	yes_BB(i)=length(intersect(index_yesboys{i},index_B{i}));
	yes_HB(i)=length(intersect(index_yesboys{i},index_H{i}));
	yes_OB(i)=length(intersect(index_yesboys{i},index_O{i}));
    total_yes(i)=length(index_yes{i});
    total_w(i)=total_W{i}; 
    total_b(i)=total_B{i}; 
    total_h(i)=total_H{i}; 
    total_o(i)=total_O{i}; 
end

%put them all into a matrix as percent values:
per_mat = zeros(16,r);
for(i=1:r)
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

% create heatmap and/or graph:

if (graph==1)
	year=[2001, 2003, 2005, 2007, 2009, 2011];
	yes=per_mat(11,:);
	plot(year,yes, 'k-');
	hold on
	boys=per_mat(10,:);
	plot(year, boys, 'bo');
	hold on
	girls=per_mat(9,:);
	plot (year, girls, 'ro');
	hold on
	WB=per_mat(8,:);
	plot (year, WB, 'b-');
	hold on
	WG=per_mat(7,:);
	plot (year, WG, 'r-');
	hold on		
	BB=per_mat(6,:);
	plot (year, BB, 'b-.');
	hold on
	BG=per_mat(5,:);
	plot (year, BG, 'r-.');
	hold on
	HB=per_mat(4,:);
	plot (year, HB, 'b:');
	hold on
	HG=per_mat(3,:);
	plot (year, HG, 'r:');
	hold on		
	OB=per_mat(2,:);
	plot (year, OB, 'b--');
	hold on
	OG=per_mat(1,:);
	k=plot (year, OG, 'r--');
	legend('Total', 'Boys', 'Girls', 'White Boys', 'White Girls', 'Black Boys', 'Black Girls', 'Hispanic Boys', 'Hispanic Girls', 'Other Boys', 'Other Girls');
	xlabel('Year');
	ylabel('Percent of Respondents Answering Positively');
	title(title1);
	saveas(k, [ filename '_graph.pdf'] );
end

if (heatmap==1)
	label_year={'2001', '2003','2005','2007','2009','2011'}; 
	label_cell2={'Total', 'Boys', 'Girls', 'White', 'Black', 'Hispanic', 'Other', 'White Boys', 'White Girls', 'Black Boys', 'Black Girls', 'Hispanic Boys', 'Hispanic Girls', 'Other Boys', 'Other Girls'}; 
	%for i=2:r
	%	for j=1:11
	%		per_mat_relative(j,i)=(per_mat(j,i)-per_mat(j,1)); 
	%	end 
	%end
	per_mat_map(1:16,1:6)=per_mat(1:16,1:6);  %r=6
	per_mat_map=flipdim(per_mat_map,1);
	h=figure; 
	[hImage]=heatmap_rb(per_mat_map, label_year, label_cell2,1, 50, 0, 'Colormap','money', 'UseLogColormap',false, 'ShowAllTicks',true, 'Colorbar',true,'TextColor','k', 'FontSize', 12); 
    title (title1, 'FontSize', 12); 
	set (gca, 'FontSize',12); 
	print (gcf,'-dpdf', [ filename '_heatmap.pdf'] );
end


end  %end of function
