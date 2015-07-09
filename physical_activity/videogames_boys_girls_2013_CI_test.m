
cd ..
cd ..
cd data
cd Controls_061514
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt', '\t'); 
weight=importdata('weights-NaN.txt','\t'); 
grade=importdata('grade-NaN.txt','\t'); 
[r,c]=size(sex); 
weight=weight(3:7,2:c); 
race=race(3:7,2:c); 
sex=sex(3:7,2:c); 
grade=grade(3:7,2:c); 
cd ..
cd results_103114
cd cat
question_mat=importdata('Q72-cat-NaN.txt', '\t');
[r,c]=size(question_mat); 
question_mat=question_mat(:,2:c); 
cd .. 
cd ..
cd ..
cd programs
cd physical_activity

conf_mat=cell(59,16); 
conf_mat{1,2}='0 hours'; 
conf_mat{1,3}='0.5-2 hours'; 
conf_mat{1,4}='3+ hours';  

conf_mat{1,5}='0 hours'; 
conf_mat{1,6}='0.5-2 hours'; 
conf_mat{1,7}='3+ hours'; 

conf_mat{1,8}='0 hours'; 
conf_mat{1,9}='0.5-2 hours'; 
conf_mat{1,10}='3+ hours'; 

conf_mat{1,11}='0 hours'; 
conf_mat{1,12}='0.5-2 hours'; 
conf_mat{1,13}='3+ hours';  

conf_mat{1,14}='0 hours'; 
conf_mat{1,15}='0.5-1 hours'; 
conf_mat{1,16}='3+ hours';  

conf_mat{2,1}='total'; 
conf_mat{3,1}='girls';
conf_mat{4,1}='boys';
conf_mat{5,1}='Wg';  
conf_mat{6,1}='Wb'; 
conf_mat{7,1}='Bg'; 
conf_mat{8,1}='Bb'; 
conf_mat{9,1}='Hg'; 
conf_mat{10,1}='Hb'; 
conf_mat{11,1}='Og'; 
conf_mat{12,1}='Ob'; 
conf_mat{13,1}='W'; 
conf_mat{14,1}='B'; 
conf_mat{15,1}='H'; 
conf_mat{16,1}='O'; 
conf_mat{17,1}='9'; 
conf_mat{18,1}='10'; 
conf_mat{19,1}='11'; 
conf_mat{20,1}='12'; 
conf_mat{21,1}='9g'; 
conf_mat{22,1}='9b'; 
conf_mat{23,1}='10g'; 
conf_mat{24,1}='10b'; 
conf_mat{25,1}='11g'; 
conf_mat{26,1}='11b';
conf_mat{27,1}='12g'; 
conf_mat{28,1}='12b'; 

conf_mat{29,1}='H9g'; 
conf_mat{30,1}='H10g'; 
conf_mat{31,1}='H11g'; 
conf_mat{32,1}='H12g'; 
conf_mat{33,1}='H9b'; 
conf_mat{34,1}='H10b'; 
conf_mat{35,1}='H11b'; 
conf_mat{36,1}='H12b'; 
conf_mat{37,1}='W9g'; 
conf_mat{38,1}='W10g'; 
conf_mat{39,1}='W11g'; 
conf_mat{40,1}='W12g'; 
conf_mat{41,1}='W9b'; 
conf_mat{42,1}='W10b'; 
conf_mat{43,1}='W11b'; 
conf_mat{44,1}='W12b'; 

conf_mat{45,1}='B9g'; 
conf_mat{46,1}='B10g'; 
conf_mat{47,1}='B11g'; 
conf_mat{48,1}='B12g'; 
conf_mat{49,1}='B9b'; 
conf_mat{50,1}='B10b'; 
conf_mat{51,1}='B11b'; 
conf_mat{52,1}='B12b'; 
conf_mat{53,1}='O9g'; 
conf_mat{54,1}='O10g'; 
conf_mat{55,1}='O11g'; 
conf_mat{56,1}='O12g'; 
conf_mat{57,1}='O9b'; 
conf_mat{58,1}='O10b'; 
conf_mat{59,1}='O11b'; 
conf_mat{60,1}='O12b'; 

n_mat=zeros(59,r); 
n_mat_=zeros(59,r); 
x_mat=zeros(59,4,r); 

boys=double.empty; 
girls=double.empty; 
total=double.empty; 
c=1; 


%key A(1)=0,  B(2)=<1, C(3)=1 D(4)=2
%E(5)=3, %F(6)=4, %G(7)=5
for i=1:r
%	total(i)=TOTAL(i,1);
    for j=1:7
        n=zeros(59,1); 
        x=zeros(59,3); 
        
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
        index_noNaN{i}=find(isnan(question_mat(i,:))==0); 
     
        index_total_b{i}=intersect(index_nomiss{i},index_boys{i}); %index of all boys who answered 
        index_total_g{i}=intersect(index_nomiss{i},index_girls{i}); %index of all girls who answered

        index_total_b_{i}=intersect(index_noNaN{i},index_boys{i}); %index of all boys who answered 
        index_total_g_{i}=intersect(index_noNaN{i},index_girls{i}); %index of all girls who answered
        
        w=weight(i,:)'; 
        %TOTAL FOR PREVALENCE 
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
        
        %TOTAL FOR CI 
        total_ans_(i)=nansum(w(index_noNaN{i})); 
        total_girls_(i)=nansum(w(index_total_g_{i})); %total # of girls who answered
        total_boys_(i)=nansum(w(index_total_b_{i}));  %total number of boys who answered
        total_W{i}=nansum(w(intersect(index_noNaN{i}, index_W{i}))); %total # of white students who answered
        total_B{i}=nansum(w(intersect(index_noNaN{i}, index_B{i}))); %total # of black students who answered
        total_H{i}=nansum(w(intersect(index_noNaN{i}, index_H{i}))); %total # of hispanic students who answered
        total_O{i}=nansum(w(intersect(index_noNaN{i}, index_O{i}))); %total # of "other" students who answered
        
        total_w_(i)=total_W{i}; 
        total_b_(i)=total_B{i}; 
        total_h_(i)=total_H{i}; 
        total_o_(i)=total_O{i};
  
        total_Wb_(i)=nansum(w(intersect(index_total_b_{i},index_W{i}))); 
        total_Wg_(i)=nansum(w(intersect(index_total_g_{i},index_W{i}))); 
        total_Bb_(i)=nansum(w(intersect(index_total_b_{i},index_B{i}))); 
        total_Bg_(i)=nansum(w(intersect(index_total_g_{i},index_B{i}))); 
        total_Hb_(i)=nansum(w(intersect(index_total_b_{i},index_H{i}))); 
        total_Hg_(i)=nansum(w(intersect(index_total_g_{i},index_H{i}))); 
        total_Ob_(i)=nansum(w(intersect(index_total_b_{i},index_O{i}))); 
        total_Og_(i)=nansum(w(intersect(index_total_g_{i},index_O{i})));  
        total_9_(i)=nansum(w(intersect((index_9{i}),index_noNaN{i}))); 
        total_10_(i)=nansum(w(intersect((index_10{i}),index_noNaN{i}))); 
        total_11_(i)=nansum(w(intersect((index_11{i}),index_noNaN{i})));  
        total_12_(i)=nansum(w(intersect((index_12{i}),index_noNaN{i})));
    
        total_9G_(i)=nansum(w(intersect(index_9{i},index_total_g_{i}))); 
        total_10G_(i)=nansum(w(intersect(index_10{i},index_total_g_{i})));  
        total_11G_(i)=nansum(w(intersect(index_11{i},index_total_g_{i}))); 
        total_12G_(i)=nansum(w(intersect(index_12{i},index_total_g_{i}))); 
        
        total_9B_(i)=nansum(w(intersect(index_9{i},index_total_b_{i})));  
        total_10B_(i)=nansum(w(intersect(index_10{i},index_total_b_{i})));  
        total_11B_(i)=nansum(w(intersect(index_11{i},index_total_b_{i})));  
        total_12B_(i)=nansum(w(intersect(index_12{i},index_total_b_{i}))); 
        
        total_9G_W_(i)=nansum(w(intersect(index_W9{i},index_total_g_{i})));  
        total_9B_W_(i)=nansum(w(intersect(index_W9{i},index_total_b_{i})));  
        total_9G_B_(i)=nansum(w(intersect(index_B9{i},index_total_g_{i})));  
        total_9B_B_(i)=nansum(w(intersect(index_B9{i},index_total_b_{i})));  
        
        total_9G_H_(i)=nansum(w(intersect(index_H9{i},index_total_g_{i}))); 
        total_9B_H_(i)=nansum(w(intersect(index_H9{i},index_total_b_{i})));  
        total_9G_O_(i)=nansum(w(intersect(index_O9{i},index_total_g_{i}))); 
        total_9B_O_(i)=nansum(w(intersect(index_O9{i},index_total_b_{i}))); 
        
        total_10G_W_(i)=nansum(w(intersect(index_W10{i},index_total_g_{i})));  
        total_10B_W_(i)=nansum(w(intersect(index_W10{i},index_total_b_{i}))); 
        total_10G_B_(i)=nansum(w(intersect(index_B10{i},index_total_g_{i}))); 
        total_10B_B_(i)=nansum(w(intersect(index_B10{i}, index_total_b_{i}))); 
        
        total_10G_H_(i)=nansum(w(intersect(index_H10{i},index_total_g_{i})));  
        total_10B_H_(i)=nansum(w(intersect(index_H10{i},index_total_b_{i})));  
        total_10G_O_(i)=nansum(w(intersect(index_O10{i},index_total_g_{i})));  
        total_10B_O_(i)=nansum(w(intersect(index_O10{i},index_total_b_{i})));  
        
        total_11G_W_(i)=nansum(w(intersect(index_W11{i},index_total_g_{i})));  
        total_11B_W_(i)=nansum(w(intersect(index_W11{i},index_total_b_{i})));  
        total_11G_B_(i)=nansum(w(intersect(index_B11{i},index_total_g_{i})));  
        total_11B_B_(i)=nansum(w(intersect(index_B11{i},index_total_b_{i}))); 
        
        total_11G_H_(i)=nansum(w(intersect(index_H11{i},index_total_g_{i}))); 
        total_11B_H_(i)=nansum(w(intersect(index_H11{i},index_total_b_{i}))); 
        total_11G_O_(i)=nansum(w(intersect(index_O11{i},index_total_g_{i}))); 
        total_11B_O_(i)=nansum(w(intersect(index_O11{i},index_total_b_{i}))); 
        
        total_12G_W_(i)=nansum(w(intersect(index_W12{i},index_total_g_{i}))); 
        total_12B_W_(i)=nansum(w(intersect(index_W12{i},index_total_b_{i}))); 
        total_12G_B_(i)=nansum(w(intersect(index_B12{i},index_total_g_{i}))); 
        total_12B_B_(i)=nansum(w(intersect(index_B12{i},index_total_b_{i}))); 
        
        total_12G_H_(i)=nansum(w(intersect(index_H12{i},index_total_g_{i}))); 
        total_12B_H_(i)=nansum(w(intersect(index_H12{i},index_total_b_{i}))); 
        total_12G_O_(i)=nansum(w(intersect(index_O12{i},index_total_g_{i}))); 
        total_12B_O_(i)=nansum(w(intersect(index_O12{i},index_total_b_{i}))); 
        
        total_9_W_(i)=nansum(w(intersect(index_noNaN{i},index_W9{i}))); 
        total_9_B_(i)=nansum(w(intersect(index_noNaN{i},index_B9{i}))); 
        total_9_H_(i)=nansum(w(intersect(index_noNaN{i},index_H9{i}))); 
        total_9_O_(i)=nansum(w(intersect(index_noNaN{i},index_O9{i})));
        
        total_10_W_(i)=nansum(w(intersect(index_noNaN{i},index_W10{i}))); 
        total_10_B_(i)=nansum(w(intersect(index_noNaN{i},index_B10{i}))); 
        total_10_H_(i)=nansum(w(intersect(index_noNaN{i},index_H10{i}))); 
        total_10_O_(i)=nansum(w(intersect(index_noNaN{i},index_O10{i})));
        
        total_11_W_(i)=nansum(w(intersect(index_noNaN{i},index_W11{i}))); 
        total_11_B_(i)=nansum(w(intersect(index_noNaN{i},index_B11{i}))); 
        total_11_H_(i)=nansum(w(intersect(index_noNaN{i},index_H11{i}))); 
        total_11_O_(i)=nansum(w(intersect(index_noNaN{i},index_O11{i}))); 
        
        total_12_W_(i)=nansum(w(intersect(index_noNaN{i},index_W12{i}))); 
        total_12_B_(i)=nansum(w(intersect(index_noNaN{i},index_B12{i}))); 
        total_12_H_(i)=nansum(w(intersect(index_noNaN{i},index_H12{i})));  
        total_12_O_(i)=nansum(w(intersect(index_noNaN{i},index_O12{i}))); 
        
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
        yes_9b(i)=nansum(w(intersect(index_yesboys{i},index_9{i}))); 
        yes_10b(i)=nansum(w(intersect(index_yesboys{i},index_10{i}))); 
        yes_11b(i)=nansum(w(intersect(index_yesboys{i},index_11{i}))); 
        yes_12b(i)=nansum(w(intersect(index_yesboys{i},index_12{i})));
        yes_9g(i)=nansum(w(intersect(index_yesgirls{i},index_9{i}))); 
        yes_10g(i)=nansum(w(intersect(index_yesgirls{i},index_10{i}))); 
        yes_11g(i)=nansum(w(intersect(index_yesgirls{i},index_11{i}))); 
        yes_12g(i)=nansum(w(intersect(index_yesgirls{i},index_12{i})));
        
        
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
        girls(6, c)=yes_9g(i)/total_9G(i)*100; 
        girls(7, c)=yes_10g(i)/total_10G(i)*100; 
        girls(8, c)=yes_11g(i)/total_11G(i)*100; 
        girls(9, c)=yes_12g(i)/total_12G(i)*100; 
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
        boys(6, c)=yes_9b(i)/total_9B(i)*100; 
        boys(7, c)=yes_10b(i)/total_10B(i)*100; 
        boys(8, c)=yes_11b(i)/total_11B(i)*100; 
        boys(9, c)=yes_12b(i)/total_12B(i)*100; 
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
        n_mat_ (1,i)= total_ans_(i); 
        n_mat_ (2,i)=total_girls_(i); 
        n_mat_ (3,i)=total_boys_(i); 
        n_mat_ (4,i)=total_Wg_(i); 
        n_mat_ (5,i)=total_Wb_(i); 
        n_mat_ (6,i)=total_Bg_(i); 
        n_mat_ (7,i)=total_Bb_(i);  
        n_mat_ (8,i)=total_Hg_(i); 
        n_mat_ (9,i)=total_Hb_(i); 
        n_mat_ (10,i)=total_Og_(i); 
        n_mat_ (11,i)=total_Ob_(i); 
        n_mat_ (12,i)=total_w_(i); 
        n_mat_ (13,i)=total_b_(i); 
        n_mat_ (14,i)=total_h_(i); 
        n_mat_ (15,i)=total_o_(i); 
        n_mat_ (16,i)=total_9_(i); 
        n_mat_ (17,i)=total_10_(i); 
        n_mat_ (18,i)=total_11_(i); 
        n_mat_ (19,i)=total_12_(i);
        n_mat_ (20,i)=total_9G_(i); 
        n_mat_ (21,i)=total_9B_(i); 
        n_mat_ (22,i)=total_10G_(i); 
        n_mat_ (23,i)=total_10B_(i); 
        n_mat_ (24,i)=total_11G_(i); 
        n_mat_ (25,i)=total_11B_(i); 
        n_mat_ (26,i)=total_12G_(i); 
        n_mat_ (27,i)=total_12B_(i); 
        
        n_mat_ (28,i)=total_9G_H_(i); 
        n_mat_ (29,i)=total_10G_H_(i); 
        n_mat_ (30,i)=total_11G_H_(i); 
        n_mat_ (31,i)=total_12G_H_(i); 
        n_mat_ (32,i)=total_9B_H_(i); 
        n_mat_ (33,i)=total_10B_H_(i); 
        n_mat_ (34,i)=total_11B_H_(i); 
        n_mat_ (35,i)=total_12B_H_(i); 
       
        n_mat_ (36,i)=total_9G_W_(i); 
        n_mat_ (37,i)=total_10G_W_(i); 
        n_mat_ (38,i)=total_11G_W_(i); 
        n_mat_ (39,i)=total_12G_W_(i); 
        n_mat_ (40,i)=total_9B_W_(i); 
        n_mat_ (41,i)=total_10B_W_(i); 
        n_mat_ (42,i)=total_11B_W_(i); 
        n_mat_ (43,i)=total_12B_W_(i); 
       
        n_mat_ (44,i)=total_9G_B_(i); 
        n_mat_ (45,i)=total_10G_B_(i); 
        n_mat_ (46,i)=total_11G_B_(i); 
        n_mat_ (47,i)=total_12G_B_(i); 
        n_mat_ (48,i)=total_9B_B_(i); 
        n_mat_ (49,i)=total_10B_B_(i); 
        n_mat_ (50,i)=total_11B_B_(i); 
        n_mat_ (51,i)=total_12B_B_(i); 
        
        n_mat_ (52,i)=total_9G_O_(i); 
        n_mat_ (53,i)=total_10G_O_(i); 
        n_mat_ (54,i)=total_11G_O_(i); 
        n_mat_ (55,i)=total_12G_O_(i); 
        n_mat_ (56,i)=total_9B_O_(i); 
        n_mat_ (57,i)=total_10B_O_(i); 
        n_mat_ (58,i)=total_11B_O_(i); 
        n_mat_ (59,i)=total_12B_O_(i); 
        
        %for stats
        n_mat (1,i)= total_ans(i); 
        n_mat (2,i)=total_girls(i); 
        n_mat (3,i)=total_boys(i); 
        n_mat (4,i)=total_Wg(i); 
        n_mat (5,i)=total_Wb(i); 
        n_mat (6,i)=total_Bg(i); 
        n_mat (7,i)=total_Bb(i);  
        n_mat (8,i)=total_Hg(i); 
        n_mat (9,i)=total_Hb(i); 
        n_mat (10,i)=total_Og(i); 
        n_mat (11,i)=total_Ob(i); 
        n_mat (12,i)=total_w(i); 
        n_mat (13,i)=total_b(i); 
        n_mat (14,i)=total_h(i); 
        n_mat (15,i)=total_o(i); 
        n_mat (16,i)=total_9(i); 
        n_mat (17,i)=total_10(i); 
        n_mat (18,i)=total_11(i); 
        n_mat (19,i)=total_12(i);
        n_mat (20,i)=total_9G(i); 
        n_mat (21,i)=total_9B(i); 
        n_mat (22,i)=total_10G(i); 
        n_mat (23,i)=total_10B(i); 
        n_mat (24,i)=total_11G(i); 
        n_mat (25,i)=total_11B(i); 
        n_mat (26,i)=total_12G(i); 
        n_mat (27,i)=total_12B(i); 
        
        n_mat (28,i)=total_9G_H(i); 
        n_mat (29,i)=total_10G_H(i); 
        n_mat (30,i)=total_11G_H(i); 
        n_mat (31,i)=total_12G_H(i); 
        n_mat (32,i)=total_9B_H(i); 
        n_mat (33,i)=total_10B_H(i); 
        n_mat (34,i)=total_11B_H(i); 
        n_mat (35,i)=total_12B_H(i); 
       
        n_mat (36,i)=total_9G_W(i); 
        n_mat (37,i)=total_10G_W(i); 
        n_mat (38,i)=total_11G_W(i); 
        n_mat (39,i)=total_12G_W(i); 
        n_mat (40,i)=total_9B_W(i); 
        n_mat (41,i)=total_10B_W(i); 
        n_mat (42,i)=total_11B_W(i); 
        n_mat (43,i)=total_12B_W(i); 
       
        n_mat (44,i)=total_9G_B(i); 
        n_mat (45,i)=total_10G_B(i); 
        n_mat (46,i)=total_11G_B(i); 
        n_mat (47,i)=total_12G_B(i); 
        n_mat (48,i)=total_9B_B(i); 
        n_mat (49,i)=total_10B_B(i); 
        n_mat (50,i)=total_11B_B(i); 
        n_mat (51,i)=total_12B_B(i); 
        
        n_mat (52,i)=total_9G_O(i); 
        n_mat (53,i)=total_10G_O(i); 
        n_mat (54,i)=total_11G_O(i); 
        n_mat (55,i)=total_12G_O(i); 
        n_mat (56,i)=total_9B_O(i); 
        n_mat (57,i)=total_10B_O(i); 
        n_mat (58,i)=total_11B_O(i); 
        n_mat (59,i)=total_12B_O(i); 
        
        if (j>1 && j<5)%0.5-1 hour hours or less 
            x(1,2)=total_yes(i); 
            x(2,2)=yes_girls(i); 
            x(3,2)=yes_boys(i); 
            x(4,2)=yes_WG(i); 
            x(5,2)=yes_WB(i); 
            x(6,2)=yes_BG(i); 
            x(7,2)=yes_BB(i);  
            x(8,2)=yes_HG(i); 
            x(9,2)=yes_HB(i); 
            x(10,2)=yes_OG(i); 
            x(11,2)=yes_OB(i); 
            x(12,2)=yes_W(i); 
            x(13,2)=yes_B(i); 
            x(14,2)=yes_H(i); 
            x(15,2)=yes_O(i); 
            x(16,2)=yes_9(i); 
            x(17,2)=yes_10(i); 
            x(18,2)=yes_11(i); 
            x(19,2)=yes_12(i);
            x(20,2)=yes_9g(i); 
            x(21,2)=yes_9b(i); 
            x(22,2)=yes_10g(i); 
            x(23,2)=yes_10b(i); 
            x(24,2)=yes_11g(i); 
            x(25,2)=yes_11b(i); 
            x(26,2)=yes_12g(i); 
            x(27,2)=yes_12b(i);
           
            x(28,2)=yes_9HG(i); 
            x(29, 2)=yes_10HG(i); 
            x(30, 2)=yes_11HG(i); 
            x(31, 2)=yes_12HG(i); 
            x(32, 2)=yes_9HB(i); 
            x(33, 2)=yes_10HB(i); 
            x(34, 2)=yes_11HB(i); 
            x(35, 2)=yes_12HB(i); 
           
            x(36, 2)=yes_9WG(i); 
            x(37, 2)=yes_10WG(i); 
            x(38, 2)=yes_11WG(i); 
            x(39, 2)=yes_12WG(i); 
            x(40, 2)=yes_9WB(i); 
            x(41, 2)=yes_10WB(i); 
            x(42, 2)=yes_11WB(i); 
            x(43, 2)=yes_12WB(i);
           
            x(44, 2)=yes_9BG(i); 
            x(45, 2)=yes_10BG(i); 
            x(46, 2)=yes_11BG(i); 
            x(47, 2)=yes_12BG(i); 
            x(48, 2)=yes_9BB(i); 
            x(49, 2)=yes_10BB(i); 
            x(50, 2)=yes_11BB(i); 
            x(51, 2)=yes_12BB(i);
           
            x(52, 2)=yes_9OG(i); 
            x(53, 2)=yes_10OG(i); 
            x(54, 2)=yes_11OG(i); 
            x(55, 2)=yes_12OG(i); 
            x(56, 2)=yes_9OB(i); 
            x(57, 2)=yes_10OB(i); 
            x(58, 2)=yes_11OB(i); 
            x(59, 2)=yes_12OB(i);
            
            x_mat(:,2, i)=x_mat(:, 2, i)+x(:,2);     
        elseif j>4 %3-4 hours hours or more
            x(1,3)=total_yes(i); 
            x(2,3)=yes_girls(i); 
            x(3,3)=yes_boys(i); 
            x(4,3)=yes_WG(i); 
            x(5,3)=yes_WB(i); 
            x(6,3)=yes_BG(i); 
            x(7,3)=yes_BB(i);  
            x(8,3)=yes_HG(i); 
            x(9,3)=yes_HB(i); 
            x(10,3)=yes_OG(i); 
            x(11,3)=yes_OB(i); 
            x(12,3)=yes_W(i); 
            x(13,3)=yes_B(i); 
            x(14,3)=yes_H(i); 
            x(15,3)=yes_O(i); 
            x(16,3)=yes_9(i); 
            x(17,3)=yes_10(i); 
            x(18,3)=yes_11(i); 
            x(19,3)=yes_12(i);
            x(20,3)=yes_9g(i); 
            x(21,3)=yes_9b(i); 
            x(22,3)=yes_10g(i); 
            x(23,3)=yes_10b(i); 
            x(24,3)=yes_11g(i); 
            x(25,3)=yes_11b(i); 
            x(26,3)=yes_12g(i); 
            x(27,3)=yes_12b(i);
           
            x(28,3)=yes_9HG(i); 
            x(29, 3)=yes_10HG(i); 
            x(30, 3)=yes_11HG(i); 
            x(31, 3)=yes_12HG(i); 
            x(32, 3)=yes_9HB(i); 
            x(33, 3)=yes_10HB(i); 
            x(34, 3)=yes_11HB(i); 
            x(35, 3)=yes_12HB(i); 
           
            x(36, 3)=yes_9WG(i); 
            x(37, 3)=yes_10WG(i); 
            x(38, 3)=yes_11WG(i); 
            x(39, 3)=yes_12WG(i); 
            x(40, 3)=yes_9WB(i); 
            x(41, 3)=yes_10WB(i); 
            x(42, 3)=yes_11WB(i); 
            x(43, 3)=yes_12WB(i);
           
            x(44, 3)=yes_9BG(i); 
            x(45, 3)=yes_10BG(i); 
            x(46, 3)=yes_11BG(i); 
            x(47, 3)=yes_12BG(i); 
            x(48, 3)=yes_9BB(i); 
            x(49, 3)=yes_10BB(i); 
            x(50, 3)=yes_11BB(i); 
            x(51, 3)=yes_12BB(i);
           
            x(52, 3)=yes_9OG(i); 
            x(53, 3)=yes_10OG(i); 
            x(54, 3)=yes_11OG(i); 
            x(55, 3)=yes_12OG(i); 
            x(56, 3)=yes_9OB(i); 
            x(57, 3)=yes_10OB(i); 
            x(58, 3)=yes_11OB(i); 
            x(59, 3)=yes_12OB(i);
            
            x_mat(:,3, i)=x_mat(:,3, i)+x(:,3);  
        else 
           if j==1
               F=1; 
           end 
            x_mat(1,F, i)=total_yes(i); 
            x_mat(2,F, i)=yes_girls(i); 
            x_mat(3,F, i)=yes_boys(i); 
            x_mat(4,F, i)=yes_WG(i); 
            x_mat(5,F, i)=yes_WB(i); 
            x_mat(6,F, i)=yes_BG(i); 
            x_mat(7,F, i)=yes_BB(i);  
            x_mat(8,F, i)=yes_HG(i); 
            x_mat(9,F, i)=yes_HB(i); 
            x_mat(10,F, i)=yes_OG(i); 
            x_mat(11,F, i)=yes_OB(i); 
            x_mat(12,F, i)=yes_W(i); 
            x_mat(13,F, i)=yes_B(i); 
            x_mat(14,F, i)=yes_H(i); 
            x_mat(15,F, i)=yes_O(i); 
            x_mat(16,F, i)=yes_9(i); 
            x_mat(17,F, i)=yes_10(i); 
            x_mat(18,F, i)=yes_11(i); 
            x_mat(19,F, i)=yes_12(i);
            x_mat(20,F, i)=yes_9g(i); 
            x_mat(21,F, i)=yes_9b(i); 
            x_mat(22,F, i)=yes_10g(i); 
            x_mat(23,F, i)=yes_10b(i); 
            x_mat(24,F, i)=yes_11g(i); 
            x_mat(25,F, i)=yes_11b(i); 
            x_mat(26,F, i)=yes_12g(i); 
            x_mat(27,F, i)=yes_12b(i);
           
            x_mat(28,F, i)=yes_9HG(i); 
            x_mat(29, F, i)=yes_10HG(i); 
            x_mat(30, F, i)=yes_11HG(i); 
            x_mat(31, F, i)=yes_12HG(i); 
            x_mat(32, F, i)=yes_9HB(i); 
            x_mat(33, F, i)=yes_10HB(i); 
            x_mat(34, F, i)=yes_11HB(i); 
            x_mat(35, F, i)=yes_12HB(i); 
           
            x_mat(36, F, i)=yes_9WG(i); 
            x_mat(37, F, i)=yes_10WG(i); 
            x_mat(38, F, i)=yes_11WG(i); 
            x_mat(39, F, i)=yes_12WG(i); 
            x_mat(40, F, i)=yes_9WB(i); 
            x_mat(41, F, i)=yes_10WB(i); 
            x_mat(42, F, i)=yes_11WB(i); 
            x_mat(43, F, i)=yes_12WB(i);
           
            x_mat(44, F, i)=yes_9BG(i); 
            x_mat(45, F, i)=yes_10BG(i); 
            x_mat(46, F, i)=yes_11BG(i); 
            x_mat(47, F, i)=yes_12BG(i); 
            x_mat(48, F, i)=yes_9BB(i); 
            x_mat(49, F, i)=yes_10BB(i); 
            x_mat(50, F, i)=yes_11BB(i); 
            x_mat(51, F, i)=yes_12BB(i);
           
            x_mat(52, F, i)=yes_9OG(i); 
            x_mat(53, F, i)=yes_10OG(i); 
            x_mat(54, F, i)=yes_11OG(i); 
            x_mat(55, F, i)=yes_12OG(i); 
            x_mat(56, F, i)=yes_9OB(i); 
            x_mat(57, F, i)=yes_10OB(i); 
            x_mat(58, F, i)=yes_11OB(i); 
            x_mat(59, F, i)=yes_12OB(i);
            
        end 
        
        
    end 
end

c=1; 
c2=1; 
%key A(1)=0,  B(2)=<1, C(3)=1 D(4)=2
%E(5)=3, %F(6)=4, %G(7)=5
final_boys=double.empty; 

for i=1:5
    final_boys(:,c)=boys(:,c2); 
    final_boys(:,c+1)=boys(:,c2+1)+boys(:,c2+2)+boys(:,c2+3); 
    final_boys(:,c+2)=boys(:,c+4)+boys(c2+5); 
    final_boys(:,c+3)=boys(:,c2+6); 
    c2=c2+7; 
    c=c+3; 
end 

c=1; 
c2=1; 
%key A(1)=0,  B(2)=<1, C(3)=1 D(4)=2
%E(5)=3, %F(6)=4, %G(7)=5
final_girls=double.empty; 
for i=1:5
    final_girls(:,c)=girls(:,c2); 
    final_girls(:,c+1)=girls(:,c2+1)+girls(:,c2+2)+girls(:,c2+3); 
    final_girls(:,c+2)=girls(:,c2+4)+girls(:,c2+5); 
    final_girls(:,c+3)=girls(:,c2+6); 
    c2=c2+7; 
    c=c+3; 
end 

c=1; 
c2=1; 
%key A(1)=0,  B(2)=<1, C(3)=1 D(4)=2
%E(5)=3, %F(6)=4, %G(7)=5
final_total=double.empty; 

for i=1:5
    final_total(:,c)=total(:,c2); 
    final_total(:,c+1)=total(:,c2+1)+total(:,c2+2)+total(:,c2+3); 
    final_total(:,c+2)=total(:,c2+4)+total(:,c2+5); 
    final_total(:,c+3)=total(:,c2+6); 
    c2=c2+7; 
    c=c+3; 
end 

%%confidence interval

lower_mat=double.empty; 
upper_mat=double.empty; 
plot_mat=double.empty; 
z=1.96; 
for i=1:59 
    count=2; 
    for j=1:r
        n=n_mat_(i,j); 
        N=n_mat(i,j); %total without missing
        for k=1:3
            x=x_mat(i,k, j); %x_mat=zeros(59,5,r); 
            p=x/n;  %x is the number of subjects saying "yes", n is the total subjects
            P=x/N; 
            upper=((P+z*sqrt(p*(1-p)/n))*100); 
            lower=((P-z*sqrt(p*(1-p)/n))*100); 
            lower_mat(i,count-1)=lower; 
            upper_mat(i,count-1)=upper; 
            upper=sprintf('%0.1f',round(upper*10)/10);
            lower=sprintf('%0.1f',round(lower*10)/10);  
            p=p*100; 
            P=P*100; 
            plot_mat(i,count-1)=P; 
            p_num=sprintf('%0.1f', round(P*10)/10); 
            conf_mat{i+1,count}=[p_num ' [' lower ', ' upper ']']; 
            count=count+1; 
        end 
    end 
end 

%make plots!
x=2005:2:2013; 
lookat=[1, 2, 3; 14, 6, 7; 15, 8, 9; 16, 10, 11]; %, 12, 13, 14, 15, 16, 17, 18, 19]; 
[r,c]=size(lookat); 
cmap=jet(c); 
title_mat={'0 hours', '3 hours or less', '3+ hours'}; 
ylabel_mat={'Total', 'White', 'Black', 'Hispanic'}; 
count=1; 
for k=1:4 %by race
    for j=1:3
        f2=subplot(4,3,count);
        for i=1:c 
            I=lookat(k,i); 
            %CI
            x2=[2005 2005]; 
            y2=[lower_mat(I,j) upper_mat(I,j)];
            plot(x2, y2, '-k'); 
            hold on
            x2=[2007 2007]; 
            y2=[lower_mat(I,j+3) upper_mat(I,j+3)];
            plot(x2, y2, '-k'); 
            hold on
            x2=[2009 2009]; 
            y2=[lower_mat(I,j+6) upper_mat(I,j+6)];
            plot(x2, y2, '-k'); 
            hold on
            x2=[2011 2011]; 
            y2=[lower_mat(I,j+9) upper_mat(I,j+9)];
            plot(x2, y2, '-k'); 
            hold on
            x2=[2013 2013]; 
            y2=[lower_mat(I,j+12) upper_mat(I,j+12)];
            plot(x2, y2, '-k'); 
            hold on
            y=[plot_mat(I,j), plot_mat(I, j+3), plot_mat(I,j+6), plot_mat(I,j+9),plot_mat(I,j+12)]; 
            plot(x, y,'-', 'Color', cmap(i,:)); %, 'MarkerFaceColor', cmap(i,:)'MarkerEdgeColor', cmap(i,:), 'MarkerSize', 3,
        end 
        ylim([0 65]); 
        xlim([2004 2014]);
        hold off; 
        set(gca, 'xtick', x); 
        set(gca, 'xticklabel', []); 
 
        if count<4
            title(title_mat{j}); 
            if count==1
                pos_1=get(f2, 'Position'); 
                F1=f2; 
            elseif count==2
                set(gca, 'yticklabel', []); 
                linkaxes([f1 f2],'y'); %make y axis the same
                pos1=get(f1,'Position'); %find the current position [x,y,width,height]
                pos2=get(f2,'Position'); %find the current position [x,y,width,height]
                pos2(1)=pos1(1) + pos2(3); %move the second so it touches the first 
                set (f2,'Position',pos2);  
                pos_2=get(f2, 'Position'); 
                F2=f2; 
            else
                set(gca, 'yticklabel', []); 
                linkaxes([f1 f2],'y'); %make y axis the same
                pos1=get(f1,'Position'); %find the current position [x,y,width,height]
                pos2=get(f2,'Position'); %find the current position [x,y,width,height]
                pos2(1)=pos1(1) + pos2(3); %move the second so it touches the first 
                set (f2,'Position',pos2); 
                pos_3=get(f2, 'Position'); 
                F3=f2; 
            end 
        else
            if (count==4 || count==7 || count==10) %not the first in the row
                ylabel( ylabel_mat{k}); 
                linkaxes([F1 f2],'x'); %make y axis the same
                pos1=get(F1,'Position'); %find the current position [x,y,width,height]
                pos2=get(f2,'Position'); %find the current position [x,y,width,height]
                pos2(2)=pos1(2) - pos2(4); %move the second so it touches the first 
                set (f2,'Position',pos2); 
                F1=f2; 
            elseif(count==5 || count==8 || count==11)
                set(gca, 'yticklabel', []); 
                linkaxes([F2 f2],'x'); %make y axis the same
                pos1=get(F2,'Position'); %find the current position [x,y,width,height]
                pos2=get(f2,'Position'); %find the current position [x,y,width,height]
                pos2(2)=pos1(2) - pos2(4); %move the second so it touches the first 
                set (f2,'Position',pos2); 

                linkaxes([f1 f2],'y'); %make y axis the same
                pos1=get(f1,'Position'); %find the current position [x,y,width,height]
                pos2=get(f2,'Position'); %find the current position [x,y,width,height]
                pos2(1)=pos1(1) + pos2(3); %move the second so it touches the first 
                set (f2,'Position',pos2);  
                F2=f2; 
            elseif (count==6 || count==9 || count==12)
                set(gca, 'yticklabel', []); 
                linkaxes([F3 f2],'x'); %make y axis the same
                pos1=get(F3,'Position'); %find the current position [x,y,width,height]
                pos2=get(f2,'Position'); %find the current position [x,y,width,height]
                pos2(2)=pos1(2) - pos2(4); %move the second so it touches the first 
                set (f2,'Position',pos2); 

                linkaxes([f1 f2],'y'); %make y axis the same
                pos1=get(f1,'Position'); %find the current position [x,y,width,height]
                pos2=get(f2,'Position'); %find the current position [x,y,width,height]
                pos2(1)=pos1(1) + pos2(3); %move the second so it touches the first 
                set (f2,'Position',pos2);  
                pos_2=get(f2, 'Position'); 
                set (f2,'Position',pos2); 
                F3=f2; 
            end 
        end 
        f1=f2;
        count=count+1; 
    end 
end
%legend ('All', 'Girls', 'Boys', 'Location', 'SouthOutside'); 
%all yellow, girls red, boys blue

