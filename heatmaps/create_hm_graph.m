 function [per_mat_map] = create_hm_graph( question_mat, filename, race, sex, weight )
% CREATE_HM_GRAPH takes in the question binary matrix (rows= years,
% columns=subjects) and outputs and outputs the summary matrix with the percentage of "yes" in each subgroup.
% also makes a heatmap and/or graph out of the output matrix matrix and saves them as PDFs (or whatever other file type you chose)
%   Input variables: 
%       QUESTION_MAT: binary matrix for question (row=years, column=subjects) 
%       FILENAME: name of the question for file saving
%		HEATMAP: 1 for yes, 0 for no
%		GRAPH: 1 for yes, 0 for no


% TOTAL=importdata('TOTAL.txt', '\t'); 
% ^ not necessary for this program because we're only interested in the students who answered and didn't leave out the Q

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

% create heatmap and/or graph:

% if (graph==1)
% 	year=2001:2:2011;
% 	
% 	% create 3 'subplots': one for totals, one for girls, one for boys
% 	
% 	f1=subplot(3,1,1); 
% 	yes=per_mat(15,:);
% 	plot(year,yes, 'ko');
% 	hold on
% 	W=per_mat(12,:);
% 	plot (year, W, 'k*');
% 	hold on
% 	B=per_mat(11,:);
% 	plot (year, B, 'kd');
% 	hold on
% 	H=per_mat(10,:);
% 	plot (year, H, 'kx');
% 	hold on
% 	O=per_mat(9,:);
% 	plot (year, O, 'ks');
% 	hold off
% 	legend('Total', 'Whites', 'Blacks', 'Hispanics', 'Other', 'Location', 'NorthEastOutside');
% 	ylabel('Percentage');
% 	set(f1,'xTickLabel',[]);
% 	set(gca,'xtick',2001:2:2011);
% 	title('Total');
% 	
% 	f2=subplot(3,1,2);
% 	boys=per_mat(14,:);
% 	plot(year, boys, 'ko');
% 	hold on
% 	WB=per_mat(8,:);
% 	plot (year, WB, 'k*');
% 	hold on
% 	BB=per_mat(6,:);
% 	plot (year, BB, 'kd');
% 	hold on
% 	HB=per_mat(4,:);
% 	plot (year, HB, 'kx');
% 	hold on
% 	OB=per_mat(2,:);
% 	plot (year, OB, 'ks');
% 	hold off
% 	legend('Total', 'White', 'Black', 'Hispanic', 'Other', 'Location', 'NorthEastOutside');
% 	ylabel('Percentage');
% 	set(f2,'xTickLabel',[]);
% 	set(gca,'xtick',2001:2:2011);
% 	title('Boys');
% 	
% 	f3=subplot(3,1,3); 
% 	girls=per_mat(13,:);
% 	plot (year, girls, 'ko');
% 	hold on
% 	WG=per_mat(7,:);
% 	plot (year, WG, 'k*');
% 	hold on		
% 	BG=per_mat(5,:);
% 	plot (year, BG, 'kd');
% 	hold on
% 	HG=per_mat(3,:);
% 	plot (year, HG, 'kx');
% 	hold on		
% 	OG=per_mat(1,:);
% 	plot (year, OG, 'ks');
% 	hold off; 
% 	legend('Total', 'White', 'Black', 'Hispanic', 'Other', 'Location', 'NorthEastOutside');
% 	xlabel('Year');
% 	ylabel('Percentage');
% 	set(gca,'xtick',2001:2:2011); 
% 	title('Girls');
% 	
% 	%saveas(gca, [ filename '_graph.emf'] ); %can make pdf, jnp, or jpg 
% 	close 
% end

	label_year={'2001', '2003','2005','2007','2009','2011'}; 
	label_cell2={'Total', 'Boys', 'Girls', 'W', 'B', 'H', 'O', 'W Boys', 'W Girls', 'B Boys', 'B Girls', 'H Boys', 'H Girls', 'O Boys', 'O Girls'}; 
	per_mat_map(1:15,1:r)=per_mat(1:15,1:r);
	per_mat_map=flipdim(per_mat_map,1);
    max_mat=max(max(per_mat_map)); 
    if max_mat>75
        M=100; 
    elseif max_mat>50
        M=75; 
    elseif max_mat>25
        M=50; 
    else 
        M=25; 
    end 
    %get rid of deimals
    per_mat_map=per_mat_map*10; 
    per_mat_map=round(per_mat_map); 
    per_mat_map=per_mat_map/10; 
	h=figure; 
	[hImage]=heatmap_rb(per_mat_map, label_year, label_cell2, 1, M, 0, 'Colormap','money', 'UseLogColormap', false, 'ShowAllTicks',true, 'Colorbar',true,'TextColor','k', 'FontSize', 12); 
    %title (title1, 'FontSize', 12); 
	set (gca, 'FontSize',12); 
    cd results
	saveas (gcf, [ filename '_heatmap.fig'] ); %can make pdf, jnp, or jpg 
    print (gcf, '-dpng',  [ filename '_heatmap.png']); 
    cd ..
    close all


 end  %end of function
