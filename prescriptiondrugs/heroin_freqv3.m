
cd ..
cd ..
cd data
cd Controls_061514
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt', '\t'); 
weight=importdata('weights-NaN.txt','\t'); 
grade=importdata('grade-NaN.txt','\t'); 
weight=weight(5:7,:); 
race=race(5:7,:); 
sex=sex(5:7,:); 
grade=grade(5:7,:);
cd ..
cd results_091614
cd NaN
question_mat=importdata('Q28--NaN.txt', '\t');
[r,c]=size(question_mat); 
%question_mat=question_mat(:,2:c); 
question_mat(:,1)=9; 
question_mat=question_mat(5:7,:); 
cd .. 
cd ..
cd ..

cd programs
cd prescriptiondrugs
cd results

[r,c]=size(question_mat); 
conf_mat=cell.empty; 
n_mat=double.empty; 
x_mat=double.empty; 

for i=1:r
%	total(i)=TOTAL(i,1);
	index_yes{i}=find(question_mat(i,:)==1);
	index_girls{i}=find(sex(i,:)==1);
	index_boys{i}=find(sex(i,:)==2);
	index_W{i}=find(race(i,:)== 1 );
	index_B{i}=find(race(i,:)== 2 );
	index_H{i}=find(race(i,:)== 3 );
	index_O{i}=find(race(i,:)== 4 );
    index_9{i}=find(grade(i,:)== 1 ); 
    index_10{i}=find(grade(i,:)== 2 ); 
    index_11{i}=find(grade(i,:)== 3 ); 
    index_12{i}=find(grade(i,:)== 4 ); 

	index_missQ{i}=find(question_mat(i,:)==9); %students who didn't answer the Q
    index_nomiss{i}=find(question_mat(i,:)==0 | question_mat(i,:)==1); %answers that were NOT missing (ie. 0's and 1's / no's and yes's)

	missQ(i)=length(index_missQ{i}); %number of students who answered the question each year
    index_total_b{i}=intersect(index_nomiss{i},index_boys{i}); %index of all boys who answered 
    index_total_g{i}=intersect(index_nomiss{i},index_girls{i}); %index of all girls who answered

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
    total_9(i)=nansum(w(intersect((index_9{i}),index_nomiss{i}))); 
    total_10(i)=nansum(w(intersect((index_10{i}),index_nomiss{i}))); 
    total_11(i)=nansum(w(intersect((index_11{i}),index_nomiss{i})));  
    total_12(i)=nansum(w(intersect((index_12{i}),index_nomiss{i}))); 
    total_9G(i)=nansum(w(intersect(index_9{i},index_total_g{i}))); 
    total_10G(i)=nansum(w(intersect(index_10{i},index_total_g{i})));  
    total_11G(i)=nansum(w(intersect(index_11{i},index_total_g{i}))); 
    total_12G(i)=nansum(w(intersect(index_12{i},index_total_g{i}))); 
    total_9B(i)=nansum(w(intersect(index_9{i},index_total_b{i})));  
    total_10B(i)=nansum(w(intersect(index_10{i},index_total_b{i})));  
    total_11B(i)=nansum(w(intersect(index_11{i},index_total_b{i})));  
    total_12B(i)=nansum(w(intersect(index_12{i},index_total_b{i})));  
    
    %make n_mat
    n_mat(1,i)=total_ans(i); 
    n_mat(2,i)=total_girls(i); 
    n_mat(3,i)=total_boys(i); 
	n_mat(4,i)=total_W{i};
	n_mat(5,i)=total_B{i};
	n_mat(6,i)=total_H{i};
	n_mat(7,i)=total_O{i};
	n_mat(8,i)=total_Wb(i);
    n_mat(9,i)= total_Wg(i);
    n_mat(10,i)=total_Bb(i); 
    n_mat(11,i)=total_Bg(i);
    n_mat(12,i)=total_Hb(i); 
    n_mat(13,i)=total_Hg(i); 
    n_mat(14,i)=total_Ob(i); 
    n_mat(15,i)=total_Og(i);  
    n_mat(16,i)=total_9(i); 
    n_mat(17,i)=total_9B(i); 
    n_mat(18,i)=total_9G(i);  
    n_mat(19,i)=total_10(i); 
    n_mat(20,i)=total_10B(i); 
    n_mat(21,i)=total_10G(i);  
    n_mat(22,i)=total_11(i); 
    n_mat(23,i)=total_11B(i); 
    n_mat(24,i)=total_11G(i);  
    n_mat(25,i)=total_12(i);  
    n_mat(26,i)=total_12B(i);  
    n_mat(27,i)=total_12G(i);  
    
    
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
    yes_9(i)=nansum(w(intersect(index_yes{i},index_9{i}))); 
    yes_10(i)=nansum(w(intersect(index_yes{i},index_10{i}))); 
    yes_11(i)=nansum(w(intersect(index_yes{i},index_11{i}))); 
    yes_12(i)=nansum(w(intersect(index_yes{i},index_12{i}))); 
    yes_9B(i)=nansum(w(intersect(index_yesboys{i},index_9{i}))); 
    yes_10B(i)=nansum(w(intersect(index_yesboys{i},index_10{i}))); 
    yes_11B(i)=nansum(w(intersect(index_yesboys{i},index_11{i}))); 
    yes_12B(i)=nansum(w(intersect(index_yesboys{i},index_12{i})));
    yes_9G(i)=nansum(w(intersect(index_yesgirls{i},index_9{i}))); 
    yes_10G(i)=nansum(w(intersect(index_yesgirls{i},index_10{i}))); 
    yes_11G(i)=nansum(w(intersect(index_yesgirls{i},index_11{i}))); 
    yes_12G(i)=nansum(w(intersect(index_yesgirls{i},index_12{i})));
    total_w(i)=total_W{i}; 
    total_b(i)=total_B{i}; 
    total_h(i)=total_H{i}; 
    total_o(i)=total_O{i};
    
    
    %make x_mat
    x_mat(1,i)=total_yes(i); 
    x_mat(2,i)=yes_boys(i); 
    x_mat(3,i)=yes_girls(i); 
	x_mat(4,i)=yes_W(i);
	x_mat(5,i)=yes_B(i);
	x_mat(6,i)=yes_H(i);
	x_mat(7,i)=yes_O(i);
	x_mat(8,i)=yes_WB(i);
    x_mat(9,i)= yes_WG(i);
    x_mat(10,i)=yes_BB(i); 
    x_mat(11,i)=yes_BG(i);
    x_mat(12,i)=yes_HB(i); 
    x_mat(13,i)=yes_HG(i); 
    x_mat(14,i)=yes_OB(i); 
    x_mat(15,i)=yes_OG(i);  
    x_mat(16,i)=yes_9(i); 
    x_mat(17,i)=yes_9B(i); 
    x_mat(18,i)=yes_9G(i);  
    x_mat(19,i)=yes_10(i); 
    x_mat(20,i)=yes_10B(i); 
    x_mat(21,i)=yes_10G(i);  
    x_mat(22,i)=yes_11(i); 
    x_mat(23,i)=yes_11B(i); 
    x_mat(24,i)=yes_11G(i);  
    x_mat(25,i)=yes_12(i);  
    x_mat(26,i)=yes_12B(i);  
    x_mat(27,i)=yes_12G(i);  
    
end

%put them all into a matrix as percent values:
per_mat = zeros(16,r);
for i=1:r
	per_mat(1,i)=total_yes(i)/total_ans(i)*100; %total
	per_mat(2,i)=yes_boys(i)/total_boys(i)*100; %boys
	per_mat(3,i)=yes_girls(i)/total_girls(i)*100; %girls
	per_mat(4,i)=yes_W(i)/total_w(i)*100; %whites
	per_mat(5,i)=yes_B(i)/total_b(i)*100; %blacks
	per_mat(6,i)=yes_H(i)/total_h(i)*100; %hispanics
	per_mat(7,i)=yes_O(i)/total_o(i)*100; %other
	per_mat(8, i)=yes_WB(i)/total_Wb(i)*100; %WB
	per_mat(9, i)=yes_WG(i)/total_Wg(i)*100; %WG
	per_mat(10, i)=yes_BB(i)/total_Bb(i)*100; %BB
	per_mat(11, i)=yes_BG(i)/total_Bg(i)*100; %BG
	per_mat(12, i)=yes_HB(i)/total_Hb(i)*100; %HB
	per_mat(13, i)=yes_HG(i)/total_Hg(i)*100; %HG
	per_mat(14, i)=yes_OB(i)/total_Ob(i)*100; %OB
	per_mat(15, i)=yes_OG(i)/total_Og(i)*100; %OG
    per_mat(16, i)=yes_9(i)/total_9(i)*100; 
    per_mat(17, i)=yes_9B(i)/total_9B(i)*100; 
    per_mat(18, i)=yes_9G(i)/total_9G(i)*100; 
    per_mat(19, i)=yes_10(i)/total_10(i)*100; 
    per_mat(20, i)=yes_10B(i)/total_10B(i)*100; 
    per_mat(21, i)=yes_10G(i)/total_10G(i)*100; 
    per_mat(22, i)=yes_11(i)/total_11(i)*100; 
    per_mat(23, i)=yes_11B(i)/total_11B(i)*100; 
    per_mat(24, i)=yes_11G(i)/total_11G(i)*100; 
    per_mat(25, i)=yes_12(i)/total_12(i)*100; 
    per_mat(26, i)=yes_12B(i)/total_12B(i)*100; 
    per_mat(27, i)=yes_12G(i)/total_12G(i)*100; 
end

%per_mat=flipud(per_mat); 

	label_year={'2009','2011', '2013'}; 
	label_cell2={'Total', 'Boys', 'Girls', 'W', 'B', 'H', 'O', 'W Boys', 'W Girls', 'B Boys', 'B Girls', 'H Boys', 'H Girls', 'O Boys', 'O Girls', '9th', '9th-Boys', '9th-Girls', '10th','10th-Boys', '10th-Girls', '11th', '11th-Boys', '11th-Girls', '12th', '12th-Boys', '12th-Boys'}; 
	%per_mat_map(1:15,1:r)=per_mat(1:15,1:r);
	%per_mat_map=flipdim(per_mat_map,1);
    max_mat=max(max(per_mat)); 
    if max_mat>75
        M=100; 
    elseif max_mat>50
        M=75; 
    elseif max_mat>25
        M=50; 
    else 
        M=25; 
    end
    M=50
    %get rid of deimals
    per_mat=per_mat*10; 
    per_mat=round(per_mat); 
    per_mat=per_mat/10; 
	h=figure; 
    title1={'During your life, how many times have you taken a prescription drug'; '(such as OxyContin, Percocet, Vicodin, codeine, Adderall, Ritalin, or Xanax)'; 'without a doctor�s prescription?'}; 
	[hImage]=heatmap_rb(per_mat, label_year, label_cell2, 1, M, 0, 'Colormap','money', 'UseLogColormap', false, 'ShowAllTicks',true, 'Colorbar',true,'TextColor','k', 'FontSize', 12); 
    title (title1, 'FontSize', 12, 'fontWeight','bold'); 
	set (gca, 'FontSize',12); 
    

	saveas (gcf, 'PO_heatmap.fig'); %can make pdf, jnp, or jpg 
    print (gcf, '-dpdf', 'PO_heatmap.pdf'); 

    close all
    
z=1.96; 
[r,c]=size(n_mat); 
for i=1:r
    count=1; 
    for j=1:c
        x=x_mat(i,j); 
        n=n_mat(i,j); 
        p=x/n;  %x is the number of subjects saying "yes", n is the total subjects
        upper=((p+z*sqrt(p*(1-p)/n))*100); 
        lower=((p-z*sqrt(p*(1-p)/n))*100); 
        upper=sprintf('%0.1f',round(upper*10)/10);
        lower=sprintf('%0.1f',round(lower*10)/10);  
        conf_mat{i+1,count}=[lower ', ' upper]; 
        count=count+1; 
    end
end 

