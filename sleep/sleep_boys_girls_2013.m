
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
question_mat=importdata('Q80-cat-NaN.txt', '\t');
[r,c]=size(question_mat); 
question_mat=question_mat(:,2:c); 
cd .. 
cd ..
cd ..
cd programs
cd sleep

%ztest matrices
p_mat=cell.empty; 
n_mat=zeros(21,2); 
x5_mat=zeros(21,2); 
x9_mat=zeros(21,2); 
p_mat{1,2}='5hrs or less'; 
p_mat{1,3}='9hrs or more'; 

p_mat{2,1}='girls vs boys';
p_mat{3,1}='Wg vs Wb';  
p_mat{4,1}='Bg vs Bb'; 
p_mat{5,1}='Hg vs Hb'; 
p_mat{6,1}='Og vs Ob'; 
p_mat{7,1}='9g vs 9b'; 
p_mat{8,1}='10g vs 10b'; 
p_mat{9,1}='11g vs 11b'; 
p_mat{10,1}='12g vs 12b'; 
p_mat{11,1}='9 vs 10'; 
p_mat{12,1}='9 vs 11'; 
p_mat{13,1}='9 vs 12'; 
p_mat{14,1}='10 vs 11'; 
p_mat{15,1}='10 vs 12'; 
p_mat{16,1}='11 vs 12'; 
p_mat{17,1}='W vs B'; 
p_mat{18,1}='W vs H'; 
p_mat{19,1}='W vs O'; 
p_mat{20,1}='B vs H'; 
p_mat{21,1}='B vs O'; 
p_mat{22,1}='H vs O'; 
chi_mat=p_mat; 

conf_mat=cell.empty; 
conf_mat{1,2}='5hrs or less'; 
conf_mat{1,3}='9hrs or more'; 
conf_mat{2,1}='girls';
conf_mat{3,1}='boys';
conf_mat{4,1}='Wg';  
conf_mat{5,1}='Wb'; 
conf_mat{6,1}='Bg'; 
conf_mat{7,1}='Bb'; 
conf_mat{8,1}='Hg'; 
conf_mat{9,1}='Hb'; 
conf_mat{10,1}='Og'; 
conf_mat{11,1}='Ob'; 
conf_mat{12,1}='W'; 
conf_mat{13,1}='B'; 
conf_mat{14,1}='H'; 
conf_mat{15,1}='O'; 
conf_mat{16,1}='9'; 
conf_mat{17,1}='10'; 
conf_mat{18,1}='11'; 
conf_mat{19,1}='12'; 
conf_mat{20,1}='9g'; 
conf_mat{21,1}='9b'; 
conf_mat{22,1}='10g'; 
conf_mat{23,1}='10b'; 
conf_mat{24,1}='11g'; 
conf_mat{25,1}='11b';
conf_mat{26,1}='12g'; 
conf_mat{27,1}='12b';  


boys=double.empty; 
girls=double.empty; 
total=double.empty; 
c=1; 
x5_mat_year=zeros(21,2,r); 
x9_mat_year=zeros(21,2,r); 
n_mat_year=zeros(21,2,r); 
conf_mat_year=cell(27,9,r);
p_mat_year=p_mat; 

p_mat_year{1,4}='5hrs or less'; 
p_mat_year{1,5}='9hrs or more'; 
p_mat_year{1,6}='5hrs or less'; 
p_mat_year{1,7}='9hrs or more'; 
p_mat_year{1,8}='5hrs or less'; 
p_mat_year{1,9}='9hrs or more'; 
chi_mat_year=p_mat_year; 
conf_mat_year(:,1,1)=conf_mat(:,1);
conf_mat_year(1,:,:)=p_mat_year(1,:); 


%sleep key A(1)=4 hours or less,  B(2)=5 hours, C(3)=6 hours D(4)=7 hours
%E(5)=8 hours, %F(6)=9 hours, %G(7)=10 hours or more
for i=1:r
%	total(i)=TOTAL(i,1);
    for j=1:7
        n=zeros(21,2); 
        x5=zeros(21,2); 
        x9=zeros(21,2); 
        
        index_yes{i}=find(question_mat(i,:)==j);
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
        
        index_W9{i}=intersect(index_9{i},index_W{i}); 
        index_W10{i}=intersect(index_10{i},index_W{i});  
        index_W11{i}=intersect(index_11{i},index_W{i});  
        index_W12{i}=intersect(index_12{i},index_W{i});  
        
        index_B9{i}=intersect(index_9{i},index_B{i}); 
        index_B10{i}=intersect(index_10{i},index_B{i});  
        index_B11{i}=intersect(index_11{i},index_B{i});  
        index_B12{i}=intersect(index_12{i},index_B{i});  
        
        index_H9{i}=intersect(index_9{i},index_H{i}); 
        index_H10{i}=intersect(index_10{i},index_H{i});  
        index_H11{i}=intersect(index_11{i},index_H{i});  
        index_H12{i}=intersect(index_12{i},index_H{i});  
        
        index_O9{i}=intersect(index_9{i},index_O{i}); 
        index_O10{i}=intersect(index_10{i},index_O{i});  
        index_O11{i}=intersect(index_11{i},index_O{i});  
        index_O12{i}=intersect(index_12{i},index_O{i});  
        
        index_missQ{i}=find(question_mat(i,:)== 0); %students who didn't answer the Q
        index_nomiss{i}=find(question_mat(i,:)>0); %answers that were NOT missing (ie. 0's and 1's / no's and yes's)
     
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
        
        total_w(i)=total_W{i}; 
        total_b(i)=total_B{i}; 
        total_h(i)=total_H{i}; 
        total_o(i)=total_O{i};
  
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
        
        total_9G_W(i)=nansum(w(intersect(index_W9{i},index_total_g{i})));  
        total_9B_W(i)=nansum(w(intersect(index_W9{i},index_total_b{i})));  
        total_9G_B(i)=nansum(w(intersect(index_B9{i},index_total_g{i})));  
        total_9B_B(i)=nansum(w(intersect(index_B9{i},index_total_b{i})));  
        
        total_9G_H(i)=nansum(w(intersect(index_H9{i},index_total_g{i}))); 
        total_9B_H(i)=nansum(w(intersect(index_H9{i},index_total_b{i})));  
        total_9G_O(i)=nansum(w(intersect(index_O9{i},index_total_g{i}))); 
        total_9B_O(i)=nansum(w(intersect(index_O9{i},index_total_b{i}))); 
        
        total_10G_W(i)=nansum(w(intersect(index_W10{i},index_total_g{i})));  
        total_10B_W(i)=nansum(w(intersect(index_W10{i},index_total_b{i}))); 
        total_10G_B(i)=nansum(w(intersect(index_B10{i},index_total_g{i}))); 
        total_10B_B(i)=nansum(w(intersect(index_B10{i}, index_total_b{i}))); 
        
        total_10G_H(i)=nansum(w(intersect(index_H10{i},index_total_g{i})));  
        total_10B_H(i)=nansum(w(intersect(index_H10{i},index_total_b{i})));  
        total_10G_O(i)=nansum(w(intersect(index_O10{i},index_total_g{i})));  
        total_10B_O(i)=nansum(w(intersect(index_O10{i},index_total_b{i})));  
        
        total_11G_W(i)=nansum(w(intersect(index_W11{i},index_total_g{i})));  
        total_11B_W(i)=nansum(w(intersect(index_W11{i},index_total_b{i})));  
        total_11G_B(i)=nansum(w(intersect(index_B11{i},index_total_g{i})));  
        total_11B_B(i)=nansum(w(intersect(index_B11{i},index_total_b{i}))); 
        
        total_11G_H(i)=nansum(w(intersect(index_H11{i},index_total_g{i}))); 
        total_11B_H(i)=nansum(w(intersect(index_H11{i},index_total_b{i}))); 
        total_11G_O(i)=nansum(w(intersect(index_O11{i},index_total_g{i}))); 
        total_11B_O(i)=nansum(w(intersect(index_O11{i},index_total_b{i}))); 
        
        total_12G_W(i)=nansum(w(intersect(index_W12{i},index_total_g{i}))); 
        total_12B_W(i)=nansum(w(intersect(index_W12{i},index_total_b{i}))); 
        total_12G_B(i)=nansum(w(intersect(index_B12{i},index_total_g{i}))); 
        total_12B_B(i)=nansum(w(intersect(index_B12{i},index_total_b{i}))); 
        
        total_12G_H(i)=nansum(w(intersect(index_H12{i},index_total_g{i}))); 
        total_12B_H(i)=nansum(w(intersect(index_H12{i},index_total_b{i}))); 
        total_12G_O(i)=nansum(w(intersect(index_O12{i},index_total_g{i}))); 
        total_12B_O(i)=nansum(w(intersect(index_O12{i},index_total_b{i}))); 
        
        total_9_W(i)=nansum(w(intersect(index_nomiss{i},index_W9{i}))); 
        total_9_B(i)=nansum(w(intersect(index_nomiss{i},index_B9{i}))); 
        total_9_H(i)=nansum(w(intersect(index_nomiss{i},index_H9{i}))); 
        total_9_O(i)=nansum(w(intersect(index_nomiss{i},index_O9{i})));
        
        total_10_W(i)=nansum(w(intersect(index_nomiss{i},index_W10{i}))); 
        total_10_B(i)=nansum(w(intersect(index_nomiss{i},index_B10{i}))); 
        total_10_H(i)=nansum(w(intersect(index_nomiss{i},index_H10{i}))); 
        total_10_O(i)=nansum(w(intersect(index_nomiss{i},index_O10{i})));
        
        total_11_W(i)=nansum(w(intersect(index_nomiss{i},index_W11{i}))); 
        total_11_B(i)=nansum(w(intersect(index_nomiss{i},index_B11{i}))); 
        total_11_H(i)=nansum(w(intersect(index_nomiss{i},index_H11{i}))); 
        total_11_O(i)=nansum(w(intersect(index_nomiss{i},index_O11{i}))); 
        
        total_12_W(i)=nansum(w(intersect(index_nomiss{i},index_W12{i}))); 
        total_12_B(i)=nansum(w(intersect(index_nomiss{i},index_B12{i}))); 
        total_12_H(i)=nansum(w(intersect(index_nomiss{i},index_H12{i})));  
        total_12_O(i)=nansum(w(intersect(index_nomiss{i},index_O12{i}))); 
        
        w=weight(i,:)';         
        index_yesgirls{i}=intersect(index_yes{i},index_girls{i});
        index_yesboys{i}=intersect(index_yes{i},index_boys{i});
        yes_girls(i)=nansum(w(index_yesgirls{i}));
        yes_boys(i)=nansum(w(index_yesboys{i}));
        total_yes(i)=nansum(w(index_yes{i})); 
        
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
        
        
        yes_9WB(i)=nansum(w(intersect(index_yesboys{i},index_W9{i}))); 
        yes_10WB(i)=nansum(w(intersect(index_yesboys{i},index_W10{i}))); 
        yes_11WB(i)=nansum(w(intersect(index_yesboys{i},index_W11{i}))); 
        yes_12WB(i)=nansum(w(intersect(index_yesboys{i},index_W12{i})));
        yes_9WG(i)=nansum(w(intersect(index_yesgirls{i},index_W9{i}))); 
        yes_10WG(i)=nansum(w(intersect(index_yesgirls{i},index_W10{i}))); 
        yes_11WG(i)=nansum(w(intersect(index_yesgirls{i},index_W11{i}))); 
        yes_12WG(i)=nansum(w(intersect(index_yesgirls{i},index_W12{i})));
        
        yes_9W(i)=nansum(w(intersect(index_yes{i},index_W9{i}))); 
        yes_10W(i)=nansum(w(intersect(index_yes{i},(index_W10{i}))));
        yes_11W(i)=nansum(w(intersect(index_yes{i},(index_W11{i}))));
        yes_12W(i)=nansum(w(intersect(index_yes{i},(index_W12{i})))); 
        
        yes_9B(i)=nansum(w(intersect(index_yes{i},(index_B9{i}))));
        yes_10B(i)=nansum(w(intersect(index_yes{i},(index_B10{i}))));
        yes_11B(i)=nansum(w(intersect(index_yes{i},(index_B11{i}))));
        yes_12B(i)=nansum(w(intersect(index_yes{i},(index_B12{i}))));
        
        yes_9H(i)=nansum(w(intersect(index_yes{i},(index_H9{i}))));
        yes_10H(i)=nansum(w(intersect(index_yes{i},(index_H10{i}))));
        yes_11H(i)=nansum(w(intersect(index_yes{i},(index_H11{i}))));
        yes_12H(i)=nansum(w(intersect(index_yes{i},(index_H12{i})))); 
        
        yes_9O(i)=nansum(w(intersect(index_yes{i},(index_O9{i}))));
        yes_10O(i)=nansum(w(intersect(index_yes{i},(index_O10{i}))));
        yes_11O(i)=nansum(w(intersect(index_yes{i},(index_O11{i})))); 
        yes_12O(i)=nansum(w(intersect(index_yes{i},(index_O12{i})))); 
        
        yes_9BB(i)=nansum(w(intersect(index_yesboys{i},index_B9{i}))); 
        yes_10BB(i)=nansum(w(intersect(index_yesboys{i},index_B10{i}))); 
        yes_11BB(i)=nansum(w(intersect(index_yesboys{i},index_B11{i}))); 
        yes_12BB(i)=nansum(w(intersect(index_yesboys{i},index_B12{i})));
        yes_9BG(i)=nansum(w(intersect(index_yesgirls{i},index_B9{i}))); 
        yes_10BG(i)=nansum(w(intersect(index_yesgirls{i},index_B10{i}))); 
        yes_11BG(i)=nansum(w(intersect(index_yesgirls{i},index_B11{i}))); 
        yes_12BG(i)=nansum(w(intersect(index_yesgirls{i},index_B12{i})));
        
        yes_9HB(i)=nansum(w(intersect(index_yesboys{i},index_H9{i}))); 
        yes_10HB(i)=nansum(w(intersect(index_yesboys{i},index_H10{i}))); 
        yes_11HB(i)=nansum(w(intersect(index_yesboys{i},index_H11{i}))); 
        yes_12HB(i)=nansum(w(intersect(index_yesboys{i},index_H12{i})));
        yes_9HG(i)=nansum(w(intersect(index_yesgirls{i},index_H9{i}))); 
        yes_10HG(i)=nansum(w(intersect(index_yesgirls{i},index_H10{i}))); 
        yes_11HG(i)=nansum(w(intersect(index_yesgirls{i},index_H11{i}))); 
        yes_12HG(i)=nansum(w(intersect(index_yesgirls{i},index_H12{i})));
        
        yes_9OB(i)=nansum(w(intersect(index_yesboys{i},index_O9{i}))); 
        yes_10OB(i)=nansum(w(intersect(index_yesboys{i},index_O10{i}))); 
        yes_11OB(i)=nansum(w(intersect(index_yesboys{i},index_O11{i}))); 
        yes_12OB(i)=nansum(w(intersect(index_yesboys{i},index_O12{i})));
        yes_9OG(i)=nansum(w(intersect(index_yesgirls{i},index_O9{i}))); 
        yes_10OG(i)=nansum(w(intersect(index_yesgirls{i},index_O10{i}))); 
        yes_11OG(i)=nansum(w(intersect(index_yesgirls{i},index_O11{i}))); 
        yes_12OG(i)=nansum(w(intersect(index_yesgirls{i},index_O12{i})));
        
        girls(1, c)=yes_girls(i)/total_girls(i)*100; %girls
        girls(2, c)=yes_WG(i)/total_Wg(i)*100; %WG
        girls(3, c)=yes_BG(i)/total_Bg(i)*100; %BG
        girls(4, c)=yes_HG(i)/total_Hg(i)*100; %HG
        girls(5, c)=yes_OG(i)/total_Og(i)*100; %OG
        girls(6, c)=yes_9G(i)/total_9G(i)*100; 
        girls(7, c)=yes_10G(i)/total_10G(i)*100; 
        girls(8, c)=yes_11G(i)/total_11G(i)*100; 
        girls(9, c)=yes_12G(i)/total_12G(i)*100; 
        girls(10, c)=yes_9WG(i)/total_9G_W(i)*100; 
        girls(11, c)=yes_10WG(i)/total_10G_W(i)*100; 
        girls(12, c)=yes_11WG(i)/total_11G_W(i)*100; 
        girls(13, c)=yes_12WG(i)/total_12G_W(i)*100; 
        girls(14, c)=yes_9BG(i)/total_9G_B(i)*100; 
        girls(15, c)=yes_10BG(i)/total_10G_B(i)*100; 
        girls(16, c)=yes_11BG(i)/total_11G_B(i)*100; 
        girls(17, c)=yes_12BG(i)/total_12G_B(i)*100; 
        girls(18, c)=yes_9HG(i)/total_9G_H(i)*100; 
        girls(19, c)=yes_10HG(i)/total_10G_H(i)*100; 
        girls(20, c)=yes_11HG(i)/total_11G_H(i)*100; 
        girls(21, c)=yes_12HG(i)/total_12G_H(i)*100; 
        girls(22, c)=yes_9OG(i)/total_9G_O(i)*100; 
        girls(23, c)=yes_10OG(i)/total_10G_O(i)*100; 
        girls(24, c)=yes_11OG(i)/total_11G_O(i)*100; 
        girls(25, c)=yes_12OG(i)/total_12G_O(i)*100; 
        
        boys(1, c)=yes_boys(i)/total_boys(i)*100; %boys
        boys(2, c)=yes_WB(i)/total_Wb(i)*100; %WB
        boys (3, c)=yes_BB(i)/total_Bb(i)*100; %BB
        boys(4, c)=yes_HB(i)/total_Hb(i)*100; %HB
        boys(5, c)=yes_OB(i)/total_Ob(i)*100; %OB
        boys(6, c)=yes_9B(i)/total_9B(i)*100; 
        boys(7, c)=yes_10B(i)/total_10B(i)*100; 
        boys(8, c)=yes_11B(i)/total_11B(i)*100; 
        boys(9, c)=yes_12B(i)/total_12B(i)*100; 
        boys(10, c)=yes_9WB(i)/total_9B_W(i)*100; 
        boys(11, c)=yes_10WB(i)/total_10B_W(i)*100; 
        boys(12, c)=yes_11WB(i)/total_11B_W(i)*100; 
        boys(13, c)=yes_12WB(i)/total_12B_W(i)*100; 
        boys(14, c)=yes_9BB(i)/total_9B_B(i)*100; 
        boys(15, c)=yes_10BB(i)/total_10B_B(i)*100; 
        boys(16, c)=yes_11BB(i)/total_11B_B(i)*100; 
        boys(17, c)=yes_12BB(i)/total_12B_B(i)*100; 
        boys(18, c)=yes_9HB(i)/total_9B_H(i)*100; 
        boys(19, c)=yes_10HB(i)/total_10B_H(i)*100; 
        boys(20, c)=yes_11HB(i)/total_11B_H(i)*100; 
        boys(21, c)=yes_12HB(i)/total_12B_H(i)*100; 
        boys(22, c)=yes_9OB(i)/total_9B_O(i)*100; 
        boys(23, c)=yes_10OB(i)/total_10B_O(i)*100; 
        boys(24, c)=yes_11OB(i)/total_11B_O(i)*100; 
        boys(25, c)=yes_12OB(i)/total_12B_O(i)*100;    
        
        total(1,c)=total_yes(i)/total_ans(i)*100; %total
        total(2,c)=yes_boys(i)/total_boys(i)*100; %boys
        total(3,c)=yes_girls(i)/total_girls(i)*100; %girls
        total(4,c)=yes_W(i)/total_w(i)*100; %whites
        total(5,c)=yes_B(i)/total_b(i)*100; %blacks
        total(6,c)=yes_H(i)/total_h(i)*100; %hispanics
        total(7,c)=yes_O(i)/total_o(i)*100; %other
        total(8,c)=yes_9(i)/total_9(i)*100; 
        total(9,c)=yes_10(i)/total_10(i)*100; 
        total(10,c)=yes_11(i)/total_11(i)*100; 
        total(11,c)=yes_12(i)/total_12(i)*100; 
        total(12, c)=yes_9W(i)/total_9_W(i)*100; 
        total(13, c)=yes_10W(i)/total_10_W(i)*100; 
        total(14, c)=yes_11W(i)/total_11_W(i)*100; 
        total(15, c)=yes_12W(i)/total_12_W(i)*100; 
        total(16, c)=yes_9B(i)/total_9_B(i)*100; 
        total(17, c)=yes_10B(i)/total_10_B(i)*100; 
        total(18, c)=yes_11B(i)/total_11_B(i)*100; 
        total(19, c)=yes_12B(i)/total_12_B(i)*100; 
        total(20, c)=yes_9H(i)/total_9_H(i)*100; 
        total(21, c)=yes_10H(i)/total_10_H(i)*100; 
        total(22, c)=yes_11H(i)/total_11_H(i)*100; 
        total(23, c)=yes_12H(i)/total_12_H(i)*100; 
        total(24, c)=yes_9O(i)/total_9_O(i)*100; 
        total(25, c)=yes_10O(i)/total_10_O(i)*100; 
        total(26, c)=yes_11O(i)/total_11_O(i)*100; 
        total(27, c)=yes_12O(i)/total_12_O(i)*100; 
        
        c=c+1; 
        
        %for stats
        n(1,1)=total_girls(i); 
        n(1,2)=total_boys(i); 
        n(2,1)=total_Wg(i); 
        n(2,2)=total_Wb(i); 
        n(3,1)=total_Bg(i); 
        n(3,2)=total_Bb(i);  
        n(4,1)=total_Hg(i); 
        n(4,2)=total_Hb(i); 
        n(5,1)=total_Og(i); 
        n(5,2)=total_Ob(i); 
        n(6,1)=total_9G(i); 
        n(6,2)=total_9B(i); 
        n(7,1)=total_10G(i); 
        n(7,2)=total_10B(i); 
        n(8,1)=total_11G(i); 
        n(8,2)=total_11B(i); 
        n(9,1)=total_12G(i); 
        n(9,2)=total_12B(i); 
        n(10,1)=total_9(i); 
        n(10,2)=total_10(i); 
        n(11,1)=total_9(i); 
        n(11,2)=total_11(i); 
        n(12,1)=total_9(i); 
        n(12,2)=total_12(i); 
        n(13,1)=total_10(i); 
        n(13,2)=total_11(i); 
        n(14,1)=total_10(i); 
        n(14,2)=total_12(i); 
        n(15,1)=total_11(i); 
        n(15,2)=total_12(i); 
        n(16,1)=total_w(i); 
        n(16,2)=total_b(i); 
        n(17,1)=total_w(i); 
        n(17,2)=total_h(i); 
        n(18,1)=total_w(i); 
        n(18,2)=total_o(i); 
        n(19,1)=total_b(i); 
        n(19,2)=total_h(i);
        n(20,1)=total_b(i); 
        n(20,2)=total_o(i);  
        n(21,1)=total_h(i); 
        n(21,2)=total_o(i);  
        n_mat=n_mat+n; 
        n_mat_year(:,:,i)=n_mat_year(:,:,i)+n; 
        
        if (j<3) %5 hours or less 
            x5(1,1)=yes_girls(i); 
            x5(1,2)=yes_boys(i); 
            x5(2,1)=yes_WG(i); 
            x5(2,2)=yes_WB(i); 
            x5(3,1)=yes_BG(i); 
            x5(3,2)=yes_BB(i);  
            x5(4,1)=yes_HG(i); 
            x5(4,2)=yes_HB(i); 
            x5(5,1)=yes_OG(i); 
            x5(5,2)=yes_OB(i); 
            x5(6,1)=yes_9G(i); 
            x5(6,2)=yes_9B(i); 
            x5(7,1)=yes_10G(i); 
            x5(7,2)=yes_10B(i); 
            x5(8,1)=yes_11G(i); 
            x5(8,2)=yes_11B(i); 
            x5(9,1)=yes_12G(i); 
            x5(9,2)=yes_12B(i); 
            x5(10,1)=yes_9(i); 
            x5(10,2)=yes_10(i); 
            x5(11,1)=yes_9(i); 
            x5(11,2)=yes_11(i); 
            x5(12,1)=yes_9(i); 
            x5(12,2)=yes_12(i); 
            x5(13,1)=yes_10(i); 
            x5(13,2)=yes_11(i); 
            x5(14,1)=yes_10(i); 
            x5(14,2)=yes_12(i); 
            x5(15,1)=yes_11(i); 
            x5(15,2)=yes_12(i); 
            x5(16,1)=yes_W(i); 
            x5(16,2)=yes_B(i); 
            x5(17,1)=yes_W(i); 
            x5(17,2)=yes_H(i); 
            x5(18,1)=yes_W(i); 
            x5(18,2)=yes_O(i); 
            x5(19,1)=yes_B(i); 
            x5(19,2)=yes_H(i);
            x5(20,1)=yes_B(i); 
            x5(20,2)=yes_O(i);  
            x5(21,1)=yes_H(i); 
            x5(21,2)=yes_O(i); 
            x5_mat=x5_mat+x5;     
            x5_mat_year(:,:,i)=x5_mat_year(:,:,i)+x5;  
        elseif (j>5) %9 hours or more
            x9(1,1)=yes_girls(i); 
            x9(1,2)=yes_boys(i); 
            x9(2,1)=yes_WG(i); 
            x9(2,2)=yes_WB(i); 
            x9(3,1)=yes_BG(i); 
            x9(3,2)=yes_BB(i);  
            x9(4,1)=yes_HG(i); 
            x9(4,2)=yes_HB(i); 
            x9(5,1)=yes_OG(i); 
            x9(5,2)=yes_OB(i); 
            x9(6,1)=yes_9G(i); 
            x9(6,2)=yes_9B(i); 
            x9(7,1)=yes_10G(i); 
            x9(7,2)=yes_10B(i); 
            x9(8,1)=yes_11G(i); 
            x9(8,2)=yes_11B(i); 
            x9(9,1)=yes_12G(i); 
            x9(9,2)=yes_12B(i); 
            x9(10,1)=yes_9(i); 
            x9(10,2)=yes_10(i); 
            x9(11,1)=yes_9(i); 
            x9(11,2)=yes_11(i); 
            x9(12,1)=yes_9(i); 
            x9(12,2)=yes_12(i); 
            x9(13,1)=yes_10(i); 
            x9(13,2)=yes_11(i); 
            x9(14,1)=yes_10(i); 
            x9(14,2)=yes_12(i); 
            x9(15,1)=yes_11(i); 
            x9(15,2)=yes_12(i); 
            x9(16,1)=yes_W(i); 
            x9(16,2)=yes_B(i); 
            x9(17,1)=yes_W(i); 
            x9(17,2)=yes_H(i); 
            x9(18,1)=yes_W(i); 
            x9(18,2)=yes_O(i); 
            x9(19,1)=yes_B(i); 
            x9(19,2)=yes_H(i);
            x9(20,1)=yes_B(i); 
            x9(20,2)=yes_O(i);  
            x9(21,1)=yes_H(i); 
            x9(21,2)=yes_O(i); 
            x9_mat=x9_mat+x9; 
            x9_mat_year(:,:,i)=x9_mat_year(:,:,i)+x9;  
        end 
        
        
    end 
end

c=1; 
c2=1; 
%sleep key A(1)=4 hours or less,  B(2)=5 hours, C(3)=6 hours D(4)=7 hours
%E(5)=8 hours, %F(6)=9 hours, %G(7)=10 hours or more
final_boys=double.empty; 

for i=1:4
    final_boys(:,c)=boys(:,c2)+boys(:,c2+1); 
    final_boys(:,c+1)=boys(:,c2+2); 
    final_boys(:,c+2)=boys(:,c2+3); 
    final_boys(:,c+3)=boys(:,c2+4); 
    final_boys(:,c+4)=boys(:,c2+5) + boys(:,c2+6); 
    c2=c2+7; 
    c=c+5; 
end 

c=1; 
c2=1; 
%sleep key A(1)=4 hours or less,  B(2)=5 hours, C(3)=6 hours D(4)=7 hours
%E(5)=8 hours, %F(6)=9 hours, %G(7)=10 hours or more
final_girls=double.empty; 
for i=1:4
    final_girls(:,c)=girls(:,c2)+girls(:,c2+1); 
    final_girls(:,c+1)=girls(:,c2+2); 
    final_girls(:,c+2)=girls(:,c2+3); 
    final_girls(:,c+3)=girls(:,c2+4); 
    final_girls(:,c+4)=girls(:,c2+5) + girls(:,c2+6); 
    c2=c2+7; 
    c=c+5; 
end 

c=1; 
c2=1; 
%sleep key A(1)=4 hours or less,  B(2)=5 hours, C(3)=6 hours D(4)=7 hours
%E(5)=8 hours, %F(6)=9 hours, %G(7)=10 hours or more
final_total=double.empty; 

for i=1:4
    final_total(:,c)=total(:,c2)+total(:,c2+1); 
    final_total(:,c+1)=total(:,c2+2); 
    final_total(:,c+2)=total(:,c2+3); 
    final_total(:,c+3)=total(:,c2+4); 
    final_total(:,c+4)=total(:,c2+5) + total(:,c2+6); 
    c2=c2+7; 
    c=c+5; 
end 

%chi-square test
for i=1:21 
    [p,c]=chi2(x5_mat(i,1), n_mat(i,1), x5_mat(i,2), n_mat(i,2) ); %chi2( x1, n1, x2, n2)
    p_mat{i+1,2}=p; 
    chi_mat{i+1,2}=c; 
    [p,c]=chi2(x9_mat(i,1), n_mat(i,1), x9_mat(i,2), n_mat(i,2) ); %chi2( x1, n1, x2, n2)
    p_mat{i+1,3}=p; 
    chi_mat{i+1,3}=c; 
end 

count=2; 
for j=1:4
    n=n_mat_year(:,:,j); 
    x5=x5_mat_year(:,:,j); 
    x9=x9_mat_year(:,:,j); 
    for i=1:21
        [p,c]=chi2(x5(i,1), n(i,1), x5(i,2), n(i,2) ); %chi2( x1, n1, x2, n2)
        p_mat_year{i+1,count}=p; 
        chi_mat_year{i+1,count}=c; 
        [p,c]=chi2(x9(i,1), n(i,1), x9(i,2), n(i,2) ); %chi2( x1, n1, x2, n2)
        p_mat_year{i+1,count+1}=p; 
        chi_mat_year{i+1,count+1}=c; 
    end 
    count=count+2; 
end 