 function [per_mat1, per_mat2, ratio_mat] = plot_demographic_graphs( question_mat1, question_mat2, label )
cd ..
cd ..
cd data 
cd controls 
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt', '\t'); 
weight=importdata('weight.txt','\t'); 
cd ..
cd .. 
cd programs
cd schooldrugs
%question 1-------------------------------------------------------------
[r,c]=size(question_mat1); 
for i=1:r
	index_yes{i}=find(question_mat1(i,:)==1);
	index_girls{i}=find(sex(i,:)==1);
	index_boys{i}=find(sex(i,:)==2);
	index_W{i}=find(race(i,:)== 1 );
	index_B{i}=find(race(i,:)== 2 );
	index_H{i}=find(race(i,:)== 3 );
	index_O{i}=find(race(i,:)== 4 );
end

for i=1:r
	index_missQ{i}=find(question_mat1(i,:)==9); %students who didn't answer the Q
    index_nomiss{i}=find(question_mat1(i,:)==0 | question_mat1(i,:)==1); %answers that were NOT missing (ie. 0's and 1's / no's and yes's)
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
per_mat1 = zeros(15,r);
for i=1:r
	per_mat1(1, i)=total_yes(i)/total_ans(i)*100; %total
	per_mat1(2, i)=yes_boys(i)/total_boys(i)*100; %boys
	per_mat1(3, i)=yes_girls(i)/total_girls(i)*100; %girls
	per_mat1(4, i)=yes_W(i)/total_w(i)*100; %whites
	per_mat1(5, i)=yes_B(i)/total_b(i)*100; %blacks
	per_mat1(6, i)=yes_H(i)/total_h(i)*100; %hispanics
	per_mat1(7, i)=yes_O(i)/total_o(i)*100; %other
	per_mat1(8, i)=yes_WB(i)/total_Wb(i)*100; %WB
	per_mat1(9, i)=yes_WG(i)/total_Wg(i)*100; %WG
	per_mat1(10, i)=yes_BB(i)/total_Bb(i)*100; %BB
	per_mat1(11, i)=yes_BG(i)/total_Bg(i)*100; %BG
	per_mat1(12, i)=yes_HB(i)/total_Hb(i)*100; %HB
	per_mat1(13, i)=yes_HG(i)/total_Hg(i)*100; %HG
	per_mat1(14, i)=yes_OB(i)/total_Ob(i)*100; %OB
	per_mat1(15, i)=yes_OG(i)/total_Og(i)*100; %OG
end

%QUESTION2---------------------------------------------------------------


[r,c]=size(question_mat2); 
per_mat_map=double.empty; 
for i=1:r
	index_yes{i}=find(question_mat2(i,:)==1);
	index_girls{i}=find(sex(i,:)==1);
	index_boys{i}=find(sex(i,:)==2);
	index_W{i}=find(race(i,:)== 1 );
	index_B{i}=find(race(i,:)== 2 );
	index_H{i}=find(race(i,:)== 3 );
	index_O{i}=find(race(i,:)== 4 );
end

for i=1:r
	index_missQ{i}=find(question_mat2(i,:)==9); %students who didn't answer the Q
    index_nomiss{i}=find(question_mat2(i,:)==0 | question_mat2(i,:)==1); %answers that were NOT missing (ie. 0's and 1's / no's and yes's)
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
per_mat2 = zeros(15,r);
for i=1:r
	per_mat2(1, i)=total_yes(i)/total_ans(i)*100; %total
	per_mat2(2, i)=yes_boys(i)/total_boys(i)*100; %boys
	per_mat2(3, i)=yes_girls(i)/total_girls(i)*100; %girls
	per_mat2(4, i)=yes_W(i)/total_w(i)*100; %whites
	per_mat2(5, i)=yes_B(i)/total_b(i)*100; %blacks
	per_mat2(6, i)=yes_H(i)/total_h(i)*100; %hispanics
	per_mat2(7, i)=yes_O(i)/total_o(i)*100; %other
	per_mat2(8, i)=yes_WB(i)/total_Wb(i)*100; %WB
	per_mat2(9, i)=yes_WG(i)/total_Wg(i)*100; %WG
	per_mat2(10, i)=yes_BB(i)/total_Bb(i)*100; %BB
	per_mat2(11, i)=yes_BG(i)/total_Bg(i)*100; %BG
	per_mat2(12, i)=yes_HB(i)/total_Hb(i)*100; %HB
	per_mat2(13, i)=yes_HG(i)/total_Hg(i)*100; %HG
	per_mat2(14, i)=yes_OB(i)/total_Ob(i)*100; %OB
	per_mat2(15, i)=yes_OG(i)/total_Og(i)*100; %OG
end

%PLOT--------------------------------------------------------------------
label_year={'2001', '2003','2005','2007','2009','2011'}; 
label_cell2={'Total', 'Boys', 'Girls', 'W', 'B', 'H', 'O', 'W Boys', 'W Girls', 'B Boys', 'B Girls', 'H Boys', 'H Girls', 'O Boys', 'O Girls'}; 
x=2001:2:2011; 
count=1; 
max_v=max(max(per_mat1)); 
max_v=max_v/10; 
max_v=ceil(max_v); 
max_v=max_v*10; 
for i=1:7
    f2=subplot(14,1,count:count+1); 
    plot(x, per_mat1(i,:), '-ro');
    hold on
    plot (x, per_mat2(i,:), '--b*'); 
    hold off
    ylabel([label_cell2{i}]); 
    ylim ([0 max_v]); 
    if i<7
        %set(f2, 'xTick', []); 
        %set(f2, 'yTick', []); 
        set(f2,'xTickLabel',[]);
    else 
        %set(f2, 'yTick', []); 
        set(f2, 'xTickLabel', label_year); 
    end 
    if i>1 %move the plot upward
        pos1=get(f1,'Position'); 
        pos2=get(f2,'Position'); 
        %set widths equal
        pos2(3)=pos1(3); 
        set (f2, 'Position', pos2); 
        %set x of first equal to second 
        pos1(1)=pos2(1); 
        set(f1, 'Position', pos1); 
        %move the second to touch first
        pos2(2)= pos1(2) - pos2(4); %was pos1(3)
        set (f2, 'Position', pos2); 
    end 
    f1=f2;  
    count=count+2; 
end 

saveas (gcf, [label '1.fig']); 
print (gcf, '-dpng', [label '1.png']); 
close all

count=1; 
for i=8:15
    f2=subplot(16,1,count:count+1); 
    plot(x, per_mat1(i,:), '-ro');
    hold on
    plot (x, per_mat2(i,:), '--b*'); 
    hold off
    ylabel([label_cell2{i}]); 
    set(f2, 'xTick', x); 
    ylim ([0 max_v]); 
    if i<15
        %set(f2, 'xTick', []); 
        %set(f2, 'yTick', []); 
        set(f2,'xTickLabel',[]);
    else 
        %set(f2, 'yTick', []); 
        set(f2, 'xTickLabel', label_year); 
    end 
    if i>8 %move the plot upward
        pos1=get(f1,'Position'); 
        pos2=get(f2,'Position'); 
        %set widths equal
        pos2(3)=pos1(3); 
        set (f2, 'Position', pos2); 
        %set x of first equal to second 
        pos1(1)=pos2(1); 
        set(f1, 'Position', pos1); 
        %move the second to touch first
        pos2(2)= pos1(2) - pos2(4); %was pos1(3)
        set (f2, 'Position', pos2); 
    end 
    f1=f2;  
    count=count+2; 
end 

saveas (gcf, [label '2.fig']); 
print (gcf, '-dpng', [label '2.png']); 
close all

ratio_mat=per_mat2./per_mat; 

 end  %end of function
