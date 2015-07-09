
clear 
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
conf_mat{1,4}='2+ hours';  

conf_mat{1,5}='0 hours'; 
conf_mat{1,6}='0.5-2 hours'; 
conf_mat{1,7}='2+ hours'; 

conf_mat{1,8}='0 hours'; 
conf_mat{1,9}='0.5-2 hours'; 
conf_mat{1,10}='2+ hours'; 

conf_mat{1,11}='0 hours'; 
conf_mat{1,12}='0.5-2 hours'; 
conf_mat{1,13}='2+ hours';  

conf_mat{1,14}='0 hours'; 
conf_mat{1,15}='0.5-1 hours'; 
conf_mat{1,16}='2+ hours';  

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

N_MAT=conf_mat; 

n_mat=zeros(59,r); 
x_mat=zeros(59,3,r); 
n_CI_mat=zeros(59,r); 
c=1; 


for i=1:r
%	total(i)=TOTAL(i,1);
    for j=1:7
        n=zeros(59,1); 
        x=zeros(59,1); 
        
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
     
        w=weight(i,:)'; 
        %TOTAL FOR CI 
        if (j==1)
            index_total_b{i}=intersect(index_noNaN{i},index_boys{i}); %index of all boys who answered 
            index_total_g{i}=intersect(index_noNaN{i},index_girls{i}); %index of all girls who answered
            total_ans(i)=nansum(w(index_noNaN{i})); 
            total_girls(i)=nansum(w(index_total_g{i})); %total # of girls who answered
            total_boys(i)=nansum(w(index_total_b{i}));  %total number of boys who answered
            total_W{i}=nansum(w(intersect(index_noNaN{i}, index_W{i}))); %total # of white students who answered
            total_B{i}=nansum(w(intersect(index_noNaN{i}, index_B{i}))); %total # of black students who answered
            total_H{i}=nansum(w(intersect(index_noNaN{i}, index_H{i}))); %total # of hispanic students who answered
            total_O{i}=nansum(w(intersect(index_noNaN{i}, index_O{i}))); %total # of "other" students who answered

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
            total_9(i)=nansum(w(intersect((index_9{i}),index_noNaN{i}))); 
            total_10(i)=nansum(w(intersect((index_10{i}),index_noNaN{i}))); 
            total_11(i)=nansum(w(intersect((index_11{i}),index_noNaN{i})));  
            total_12(i)=nansum(w(intersect((index_12{i}),index_noNaN{i})));

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

            total_9_W(i)=nansum(w(intersect(index_noNaN{i},index_W9{i}))); 
            total_9_B(i)=nansum(w(intersect(index_noNaN{i},index_B9{i}))); 
            total_9_H(i)=nansum(w(intersect(index_noNaN{i},index_H9{i}))); 
            total_9_O(i)=nansum(w(intersect(index_noNaN{i},index_O9{i})));

            total_10_W(i)=nansum(w(intersect(index_noNaN{i},index_W10{i}))); 
            total_10_B(i)=nansum(w(intersect(index_noNaN{i},index_B10{i}))); 
            total_10_H(i)=nansum(w(intersect(index_noNaN{i},index_H10{i}))); 
            total_10_O(i)=nansum(w(intersect(index_noNaN{i},index_O10{i})));

            total_11_W(i)=nansum(w(intersect(index_noNaN{i},index_W11{i}))); 
            total_11_B(i)=nansum(w(intersect(index_noNaN{i},index_B11{i}))); 
            total_11_H(i)=nansum(w(intersect(index_noNaN{i},index_H11{i}))); 
            total_11_O(i)=nansum(w(intersect(index_noNaN{i},index_O11{i}))); 

            total_12_W(i)=nansum(w(intersect(index_noNaN{i},index_W12{i}))); 
            total_12_B(i)=nansum(w(intersect(index_noNaN{i},index_B12{i}))); 
            total_12_H(i)=nansum(w(intersect(index_noNaN{i},index_H12{i})));  
            total_12_O(i)=nansum(w(intersect(index_noNaN{i},index_O12{i})));
            
            n (1)= total_ans(i); 
            n (2)=total_girls(i); 
            n (3)=total_boys(i); 
            n (4)=total_Wg(i); 
            n (5)=total_Wb(i); 
            n (6)=total_Bg(i); 
            n (7)=total_Bb(i);  
            n (8)=total_Hg(i); 
            n (9)=total_Hb(i); 
            n (10)=total_Og(i); 
            n (11)=total_Ob(i); 
            n (12)=total_w(i); 
            n (13)=total_b(i); 
            n (14)=total_h(i); 
            n (15)=total_o(i); 
            n (16)=total_9(i); 
            n (17)=total_10(i); 
            n (18)=total_11(i); 
            n (19)=total_12(i);
            n (20)=total_9G(i); 
            n (21)=total_9B(i); 
            n (22)=total_10G(i); 
            n (23)=total_10B(i); 
            n (24)=total_11G(i); 
            n (25)=total_11B(i); 
            n (26)=total_12G(i); 
            n (27)=total_12B(i); 

            n (28)=total_9G_H(i); 
            n (29)=total_10G_H(i); 
            n (30)=total_11G_H(i); 
            n (31)=total_12G_H(i); 
            n (32)=total_9B_H(i); 
            n (33)=total_10B_H(i); 
            n (34)=total_11B_H(i); 
            n (35)=total_12B_H(i); 

            n (36)=total_9G_W(i); 
            n (37)=total_10G_W(i); 
            n (38)=total_11G_W(i); 
            n (39)=total_12G_W(i); 
            n (40)=total_9B_W(i); 
            n (41)=total_10B_W(i); 
            n (42)=total_11B_W(i); 
            n (43)=total_12B_W(i); 

            n (44)=total_9G_B(i); 
            n (45)=total_10G_B(i); 
            n (46)=total_11G_B(i); 
            n (47)=total_12G_B(i); 
            n (48)=total_9B_B(i); 
            n (49)=total_10B_B(i); 
            n (50)=total_11B_B(i); 
            n (51)=total_12B_B(i); 

            n (52)=total_9G_O(i); 
            n (53)=total_10G_O(i); 
            n (54)=total_11G_O(i); 
            n (55)=total_12G_O(i); 
            n (56)=total_9B_O(i); 
            n (57)=total_10B_O(i); 
            n (58)=total_11B_O(i); 
            n (59)=total_12B_O(i); 
            
            
            n_CI_mat(:,i)=n_CI_mat(:,i)+ n; 
        end 
        
        %FOR PREVALENCE 
        total_ans(i)=nansum(w(index_nomiss{i})); 
        index_total_b{i}=intersect(index_nomiss{i},index_boys{i}); %index of all boys who answered 
        index_total_g{i}=intersect(index_nomiss{i},index_girls{i}); %index of all girls who answered

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
        if (j==1)
            n (1)= total_ans(i); 
            n (2)=total_girls(i); 
            n (3)=total_boys(i); 
            n (4)=total_Wg(i); 
            n (5)=total_Wb(i); 
            n (6)=total_Bg(i); 
            n (7)=total_Bb(i);  
            n (8)=total_Hg(i); 
            n (9)=total_Hb(i); 
            n (10)=total_Og(i); 
            n (11)=total_Ob(i); 
            n (12)=total_w(i); 
            n (13)=total_b(i); 
            n (14)=total_h(i); 
            n (15)=total_o(i); 
            n (16)=total_9(i); 
            n (17)=total_10(i); 
            n (18)=total_11(i); 
            n (19)=total_12(i);
            n (20)=total_9G(i); 
            n (21)=total_9B(i); 
            n (22)=total_10G(i); 
            n (23)=total_10B(i); 
            n (24)=total_11G(i); 
            n (25)=total_11B(i); 
            n (26)=total_12G(i); 
            n (27)=total_12B(i); 

            n (28)=total_9G_H(i); 
            n (29)=total_10G_H(i); 
            n (30)=total_11G_H(i); 
            n (31)=total_12G_H(i); 
            n (32)=total_9B_H(i); 
            n (33)=total_10B_H(i); 
            n (34)=total_11B_H(i); 
            n (35)=total_12B_H(i); 

            n (36)=total_9G_W(i); 
            n (37)=total_10G_W(i); 
            n (38)=total_11G_W(i); 
            n (39)=total_12G_W(i); 
            n (40)=total_9B_W(i); 
            n (41)=total_10B_W(i); 
            n (42)=total_11B_W(i); 
            n (43)=total_12B_W(i); 

            n (44)=total_9G_B(i); 
            n (45)=total_10G_B(i); 
            n (46)=total_11G_B(i); 
            n (47)=total_12G_B(i); 
            n (48)=total_9B_B(i); 
            n (49)=total_10B_B(i); 
            n (50)=total_11B_B(i); 
            n (51)=total_12B_B(i); 

            n (52)=total_9G_O(i); 
            n (53)=total_10G_O(i); 
            n (54)=total_11G_O(i); 
            n (55)=total_12G_O(i); 
            n (56)=total_9B_O(i); 
            n (57)=total_10B_O(i); 
            n (58)=total_11B_O(i); 
            n (59)=total_12B_O(i); 
            
            
            n_mat(:,i)=n_mat(:,i)+ n; 
        end
              
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
        
        x(1)=total_yes(i); 
        x(2)=yes_girls(i); 
        x(3)=yes_boys(i); 
        x(4)=yes_WG(i); 
        x(5)=yes_WB(i); 
        x(6)=yes_BG(i); 
        x(7)=yes_BB(i);  
        x(8)=yes_HG(i); 
        x(9)=yes_HB(i); 
        x(10)=yes_OG(i); 
        x(11)=yes_OB(i); 
        x(12)=yes_W(i); 
        x(13)=yes_B(i); 
        x(14)=yes_H(i); 
        x(15)=yes_O(i); 
        x(16)=yes_9(i); 
        x(17)=yes_10(i); 
        x(18)=yes_11(i); 
        x(19)=yes_12(i);
        x(20)=yes_9g(i); 
        x(21)=yes_9b(i); 
        x(22)=yes_10g(i); 
        x(23)=yes_10b(i); 
        x(24)=yes_11g(i); 
        x(25)=yes_11b(i); 
        x(26)=yes_12g(i); 
        x(27)=yes_12b(i);

        x(28)=yes_9HG(i); 
        x(29)=yes_10HG(i); 
        x(30)=yes_11HG(i); 
        x(31)=yes_12HG(i); 
        x(32)=yes_9HB(i); 
        x(33)=yes_10HB(i); 
        x(34)=yes_11HB(i); 
        x(35)=yes_12HB(i); 

        x(36)=yes_9WG(i); 
        x(37)=yes_10WG(i); 
        x(38)=yes_11WG(i); 
        x(39)=yes_12WG(i); 
        x(40)=yes_9WB(i); 
        x(41)=yes_10WB(i); 
        x(42)=yes_11WB(i); 
        x(43)=yes_12WB(i);

        x(44)=yes_9BG(i); 
        x(45)=yes_10BG(i); 
        x(46)=yes_11BG(i); 
        x(47)=yes_12BG(i); 
        x(48)=yes_9BB(i); 
        x(49)=yes_10BB(i); 
        x(50)=yes_11BB(i); 
        x(51)=yes_12BB(i);

        x(52)=yes_9OG(i); 
        x(53)=yes_10OG(i); 
        x(54)=yes_11OG(i); 
        x(55)=yes_12OG(i); 
        x(56)=yes_9OB(i); 
        x(57)=yes_10OB(i); 
        x(58)=yes_11OB(i); 
        x(59)=yes_12OB(i);
        
        if (j==1)
            x_mat(:,1,i)=x_mat(:,1,i)+x;  
        elseif (j>1 && j<5) %1-20 times
            x_mat(:,2, i)=x_mat(:,2, i)+x; 
        elseif (j>4);  
            x_mat(:,3, i)=x_mat(:,3, i)+x;
        end 
        
    end 
end

%%confidence interval

lower_mat=double.empty; 
upper_mat=double.empty; 
plot_mat=double.empty; 
z=1.96; 
for k=1:59 
    count=2; 
    for i=1:r
        n=n_mat(k,i); 
        n_CI=n_CI_mat(k,i); 
        for j=1:3
            x=x_mat(k,j,i); %x_mat=zeros(59,5,r); 
            p=x/n_CI;  %x is the number of subjects saying "yes", n is the total subjects
            P=x/n; 
            upper=((P+z*sqrt(p*(1-p)/n_CI))*100); 
            lower=((P-z*sqrt(p*(1-p)/n_CI))*100); 
            lower_mat(k,count-1)=lower; 
            upper_mat(k,count-1)=upper; 
            upper=sprintf('%0.1f',round(upper*10)/10);
            lower=sprintf('%0.1f',round(lower*10)/10);  
            P=P*100; 
            plot_mat(k,count-1)=P; 
            p_num=sprintf('%0.1f', round(P*10)/10); 
            conf_mat{k+1,count}=[p_num ' [' lower ', ' upper ']']; 
            N_MAT{k+1,count}=x; 
            count=count+1; 
        end 
    end 
end 
