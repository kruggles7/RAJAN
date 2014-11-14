 function [conf_mat, total, x_mat, n_mat, conf_mat2] = demographics_2013_CI( question_mat, race, sex, grade, weight, years )

    %resize and deal with the number of years in each
    [r,c]=size(question_mat);
    label_=question_mat(:,1); 
    question_mat=question_mat(:,2:c); 
    sex=sex(:,2:c); 
    race=race(:,2:c); 
    weight=weight(:,2:c); 
    [r,c]=size(question_mat);
    minimum=1; 
    maximum=max(max(question_mat)); 
    cat_n=maximum; 
    conf_mat=cell(76,cat_n,r); %(demographics, number categorical responses, years) 
    n_mat=zeros(75,r); %total number for conf_mat calculation
    x_mat=zeros(75,cat_n,r); %number in that categoriy for conf_mat

    %set up matrices
    for i=1:r
        count=2; 
        conf_mat{1,1,i}=years(i); 
        for j=minimum:maximum; 
            conf_mat{1,count,i}=j; 
            count=count+1; 
        end 
        conf_mat{2,1,i}='total'; 
        conf_mat{3,1,i}='girls';
        conf_mat{4,1,i}='boys';
        conf_mat{5,1,i}='W'; 
        conf_mat{6,1,i}='B'; 
        conf_mat{7,1,i}='H'; 
        conf_mat{8,1,i}='O'; 
        conf_mat{9,1,i}='9'; 
        conf_mat{10,1,i}='10'; 
        conf_mat{11,1,i}='11'; 
        conf_mat{12,1,i}='12'; 
        
        conf_mat{13,1,i}='Wg';  
        conf_mat{14,1,i}='Wb'; 
        conf_mat{15,1,i}='Bg'; 
        conf_mat{16,1,i}='Bb'; 
        conf_mat{17,1,i}='Hg'; 
        conf_mat{18,1,i}='Hb'; 
        conf_mat{19,1,i}='Og'; 
        conf_mat{20,1,i}='Ob'; 
        
        conf_mat{21,1,i}='9g'; 
        conf_mat{22,1,i}='9b'; 
        conf_mat{23,1,i}='10g'; 
        conf_mat{24,1,i}='10b'; 
        conf_mat{25,1,i}='11g'; 
        conf_mat{26,1,i}='11b';
        conf_mat{27,1,i}='12g'; 
        conf_mat{28,1,i}='12b'; 
        
        conf_mat{29,1,i}='W9'; 
        conf_mat{30,1,i}='W10'; 
        conf_mat{31,1,i}='W11'; 
        conf_mat{32,1,i}='W12'; 
        conf_mat{33,1,i}='B9'; 
        conf_mat{34,1,i}='B10';
        conf_mat{35,1,i}='B11'; 
        conf_mat{36,1,i}='B12'; 
        conf_mat{37,1,i}='H9'; 
        conf_mat{38,1,i}='H10'; 
        conf_mat{39,1,i}='H11'; 
        conf_mat{40,1,i}='H12'; 
        conf_mat{41,1,i}='O9'; 
        conf_mat{42,1,i}='O10';
        conf_mat{43,1,i}='O11'; 
        conf_mat{44,1,i}='O12'; 
        
        conf_mat{45,1,i}='W9g'; 
        conf_mat{46,1,i}='W10g'; 
        conf_mat{47,1,i}='W11g'; 
        conf_mat{48,1,i}='W12g'; 
        conf_mat{49,1,i}='W9b'; 
        conf_mat{50,1,i}='W10b'; 
        conf_mat{51,1,i}='W11b'; 
        conf_mat{52,1,i}='W12b';
        
        conf_mat{53,1,i}='B9g'; 
        conf_mat{54,1,i}='B10g'; 
        conf_mat{55,1,i}='B11g'; 
        conf_mat{56,1,i}='B12g'; 
        conf_mat{57,1,i}='B9b'; 
        conf_mat{58,1,i}='B10b'; 
        conf_mat{59,1,i}='B11b'; 
        conf_mat{60,1,i}='B12b'; 
        
        conf_mat{61,1,i}='H9g'; 
        conf_mat{62,1,i}='H10g'; 
        conf_mat{63,1,i}='H11g'; 
        conf_mat{64,1,i}='H12g'; 
        conf_mat{65,1,i}='H9b'; 
        conf_mat{66,1,i}='H10b'; 
        conf_mat{67,1,i}='H11b'; 
        conf_mat{68,1,i}='H12b'; 
        
        conf_mat{69,1,i}='O9g'; 
        conf_mat{70,1,i}='O10g'; 
        conf_mat{71,1,i}='O11g'; 
        conf_mat{72,1,i}='O12g'; 
        conf_mat{73,1,i}='O9b'; 
        conf_mat{74,1,i}='O10b'; 
        conf_mat{75,1,i}='O11b'; 
        conf_mat{76,1,i}='O12b'; 
        
    end
    total=conf_mat; 
    for i=1:r
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
      %for stats fihnd total in each year
        n_mat (1,i)= total_ans(i); 
        n_mat (2,i)=total_girls(i); 
        n_mat (3,i)=total_boys(i); 
        n_mat (4,i)=total_w(i); 
        n_mat (5,i)=total_b(i); 
        n_mat (6,i)=total_h(i); 
        n_mat (7,i)=total_o(i); 
        n_mat (8,i)=total_9(i); 
        n_mat (9,i)=total_10(i); 
        n_mat (10,i)=total_11(i); 
        n_mat (11,i)=total_12(i);

        n_mat (12,i)=total_Wg(i); 
        n_mat (13,i)=total_Wb(i); 
        n_mat (14,i)=total_Bg(i); 
        n_mat (15,i)=total_Bb(i);  
        n_mat (16,i)=total_Hg(i); 
        n_mat (17,i)=total_Hb(i); 
        n_mat (18,i)=total_Og(i); 
        n_mat (19,i)=total_Ob(i); 

        n_mat (20,i)=total_9G(i); 
        n_mat (21,i)=total_9B(i); 
        n_mat (22,i)=total_10G(i); 
        n_mat (23,i)=total_10B(i); 
        n_mat (24,i)=total_11G(i); 
        n_mat (25,i)=total_11B(i); 
        n_mat (26,i)=total_12G(i); 
        n_mat (27,i)=total_12B(i); 

        n_mat (28,i)=total_9_W(i); 
        n_mat (29,i)=total_10_W(i); 
        n_mat (30,i)=total_11_W(i); 
        n_mat (31,i)=total_12_W(i); 
        n_mat (32,i)=total_9_B(i); 
        n_mat (33,i)=total_10_B(i); 
        n_mat (34,i)=total_11_B(i); 
        n_mat (35,i)=total_12_B(i); 
        n_mat (36,i)=total_9_H(i); 
        n_mat (37,i)=total_10_H(i); 
        n_mat (38,i)=total_11_H(i); 
        n_mat (39,i)=total_12_H(i); 
        n_mat (40,i)=total_9_O(i); 
        n_mat (41,i)=total_10_O(i); 
        n_mat (42,i)=total_11_O(i); 
        n_mat (43,i)=total_12_O(i); 

        n_mat (44,i)=total_9G_W(i); 
        n_mat (45,i)=total_10G_W(i); 
        n_mat (46,i)=total_11G_W(i); 
        n_mat (47,i)=total_12G_W(i); 
        n_mat (48,i)=total_9B_W(i); 
        n_mat (49,i)=total_10B_W(i); 
        n_mat (50,i)=total_11B_W(i); 
        n_mat (51,i)=total_12B_W(i); 

        n_mat (52,i)=total_9G_B(i); 
        n_mat (53,i)=total_10G_B(i); 
        n_mat (54,i)=total_11G_B(i); 
        n_mat (55,i)=total_12G_B(i); 
        n_mat (56,i)=total_9B_B(i); 
        n_mat (57,i)=total_10B_B(i); 
        n_mat (58,i)=total_11B_B(i); 
        n_mat (59,i)=total_12B_B(i); 

        n_mat (60,i)=total_9G_H(i); 
        n_mat (61,i)=total_10G_H(i); 
        n_mat (62,i)=total_11G_H(i); 
        n_mat (63,i)=total_12G_H(i); 
        n_mat (64,i)=total_9B_H(i); 
        n_mat (65,i)=total_10B_H(i); 
        n_mat (66,i)=total_11B_H(i); 
        n_mat (67,i)=total_12B_H(i); 

        n_mat (68,i)=total_9G_O(i); 
        n_mat (69,i)=total_10G_O(i); 
        n_mat (70,i)=total_11G_O(i); 
        n_mat (71,i)=total_12G_O(i); 
        n_mat (72,i)=total_9B_O(i); 
        n_mat (73,i)=total_10B_O(i); 
        n_mat (74,i)=total_11B_O(i); 
        n_mat (75,i)=total_12B_O(i); 
        
        %**************************************
        w=weight(i,:)';  
        count=1; 
        for j=minimum:maximum  
            index_yes{i}=find(question_mat(i,:)==j);  
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
        
            %find prevelance values*******************************
            total{2,count+1,i}=total_yes(i)/total_ans(i)*100; %total
            total{3,count+1,i}=yes_girls(i)/total_girls(i)*100; %girls
            total{4,count+1,i}=yes_boys(i)/total_boys(i)*100; %boys
            total{5,count+1,i}=yes_W(i)/total_w(i)*100; %whites
            total{6,count+1,i}=yes_B(i)/total_b(i)*100; %blacks
            total{7,count+1,i}=yes_H(i)/total_h(i)*100; %hispanics
            total{8,count+1,i}=yes_O(i)/total_o(i)*100; %other
            total{9,count+1,i}=yes_9(i)/total_9(i)*100; 
            total{10,count+1,i}=yes_10(i)/total_10(i)*100; 
            total{11,count+1,i}=yes_11(i)/total_11(i)*100; 
            total{12,count+1,i}=yes_12(i)/total_12(i)*100; 

            total{13,count+1,i}=yes_WG(i)/total_Wg(i)*100; %WG
            total{14,count+1,i}=yes_WB(i)/total_Wb(i)*100; %WB
            total{15,count+1,i}=yes_BG(i)/total_Bg(i)*100; %BG
            total{16,count+1,i}=yes_BB(i)/total_Bb(i)*100; %BB
            total{17,count+1,i}=yes_HG(i)/total_Hg(i)*100; %HG
            total{18,count+1,i}=yes_HB(i)/total_Hb(i)*100; %HB
            total{19,count+1,i}=yes_OG(i)/total_Og(i)*100; %OG
            total{20,count+1,i}=yes_OB(i)/total_Ob(i)*100; %OB

            total{21,count+1,i}=yes_9g(i)/total_9G(i)*100; 
            total{22,count+1,i}=yes_9b(i)/total_9B(i)*100; 
            total{23,count+1,i}=yes_10g(i)/total_10G(i)*100; 
            total{24,count+1,i}=yes_10b(i)/total_10B(i)*100; 
            total{25,count+1,i}=yes_11g(i)/total_11G(i)*100; 
            total{26,count+1,i}=yes_11b(i)/total_11B(i)*100; 
            total{27,count+1,i}=yes_12g(i)/total_12G(i)*100;
            total{28,count+1,i}=yes_12b(i)/total_12B(i)*100; 

            total{29,count+1,i}=yes_9W(i)/total_9_W(i)*100; 
            total{30,count+1,i}=yes_10W(i)/total_10_W(i)*100; 
            total{31,count+1,i}=yes_11W(i)/total_11_W(i)*100; 
            total{32,count+1,i}=yes_12W(i)/total_12_W(i)*100; 
            total{33,count+1,i}=yes_9B(i)/total_9_B(i)*100; 
            total{34,count+1,i}=yes_10B(i)/total_10_B(i)*100; 
            total{35,count+1,i}=yes_11B(i)/total_11_B(i)*100; 
            total{36,count+1,i}=yes_12B(i)/total_12_B(i)*100; 
            total{37,count+1,i}=yes_9H(i)/total_9_H(i)*100; 
            total{38,count+1,i}=yes_10H(i)/total_10_H(i)*100; 
            total{39,count+1,i}=yes_11H(i)/total_11_H(i)*100; 
            total{40,count+1,i}=yes_12H(i)/total_12_H(i)*100; 
            total{41,count+1,i}=yes_9O(i)/total_9_O(i)*100; 
            total{42,count+1,i}=yes_10O(i)/total_10_O(i)*100; 
            total{43,count+1,i}=yes_11O(i)/total_11_O(i)*100; 
            total{44,count+1,i}=yes_12O(i)/total_12_O(i)*100; 

            total{45,count+1,i}=yes_9WG(i)/total_9G_W(i)*100;  
            total{46,count+1,i}=yes_10WG(i)/total_10G_W(i)*100;  
            total{47,count+1,i}=yes_11WG(i)/total_11G_W(i)*100; 
            total{48,count+1,i}=yes_12WG(i)/total_12G_W(i)*100;  
            total{49,count+1,i}=yes_9WB(i)/total_9B_W(i)*100; 
            total{50,count+1,i}=yes_10WB(i)/total_10B_W(i)*100;  
            total{51,count+1,i}=yes_11WB(i)/total_11B_W(i)*100;  
            total{52,count+1,i}=yes_12WB(i)/total_12B_W(i)*100; 

            total{53,count+1,i}=yes_9BG(i)/total_9G_B(i)*100;  
            total{54,count+1,i}=yes_10BG(i)/total_10G_B(i)*100;  
            total{55,count+1,i}=yes_11BG(i)/total_11G_B(i)*100; 
            total{56,count+1,i}=yes_12BG(i)/total_12G_B(i)*100;  
            total{57,count+1,i}=yes_9BB(i)/total_9B_B(i)*100;
            total{58,count+1,i}=yes_10BB(i)/total_10B_B(i)*100; 
            total{59,count+1,i}=yes_11BB(i)/total_11B_B(i)*100; 
            total{60,count+1,i}=yes_12BB(i)/total_12B_B(i)*100; 

            total{61,count+1,i}=yes_9HG(i)/total_9G_H(i)*100;  
            total{62,count+1,i}=yes_10HG(i)/total_10G_H(i)*100; 
            total{63,count+1,i}=yes_11HG(i)/total_11G_H(i)*100; 
            total{64,count+1,i}=yes_12HG(i)/total_12G_H(i)*100; 
            total{65,count+1,i}=yes_9HB(i)/total_9B_H(i)*100; 
            total{66,count+1,i}=yes_10HB(i)/total_10B_H(i)*100; 
            total{67,count+1,i}=yes_11HB(i)/total_11B_H(i)*100;
            total{68,count+1,i}=yes_12HB(i)/total_12B_H(i)*100; 

            total{69,count+1,i}=yes_9OG(i)/total_9G_O(i)*100; 
            total{70,count+1,i}=yes_10OG(i)/total_10G_O(i)*100; 
            total{71,count+1,i}=yes_11OG(i)/total_11G_O(i)*100;
            total{72,count+1,i}=yes_12OG(i)/total_12G_O(i)*100;  
            total{73,count+1,i}=yes_9OB(i)/total_9B_O(i)*100; 
            total{74,count+1,i}=yes_10OB(i)/total_10B_O(i)*100; 
            total{75,count+1,i}=yes_11OB(i)/total_11B_O(i)*100; 
            total{76,count+1,i}=yes_12OB(i)/total_12B_O(i)*100;   

            %for confidence intervals
            x_mat(1,count,i)=total_yes(i); 
            x_mat(2,count,i)=yes_girls(i); 
            x_mat(3,count,i)=yes_boys(i); 
            x_mat(4,count,i)=yes_W(i);
            x_mat(5,count,i)=yes_B(i);
            x_mat(6,count,i)=yes_H(i);
            x_mat(7,count,i)=yes_O(i);
            x_mat(8,count,i)=yes_9(i);
            x_mat(9,count,i)=yes_10(i);
            x_mat(10,count,i)=yes_11(i);
            x_mat(11,count,i)=yes_12(i);
            
            x_mat(12,count,i)=yes_WG(i); 
            x_mat(13,count,i)=yes_WB(i); 
            x_mat(14,count,i)=yes_BG(i); 
            x_mat(15,count,i)=yes_BB(i);  
            x_mat(16,count,i)=yes_HG(i); 
            x_mat(17,count,i)=yes_HB(i); 
            x_mat(18,count,i)=yes_OG(i); 
            x_mat(19,count,i)=yes_OB(i); 
            
            x_mat(20,count,i)=yes_9g(i); 
            x_mat(21,count,i)=yes_9b(i); 
            x_mat(22,count,i)=yes_10g(i); 
            x_mat(23,count,i)=yes_10b(i); 
            x_mat(24,count,i)=yes_11g(i); 
            x_mat(25,count,i)=yes_11b(i); 
            x_mat(26,count,i)=yes_12g(i); 
            x_mat(27,count,i)=yes_12b(i);
            
            x_mat(28,count,i)=yes_9W(i); 
            x_mat(29,count,i)=yes_10W(i); 
            x_mat(30,count,i)=yes_11W(i); 
            x_mat(31,count,i)=yes_12W(i); 
            x_mat(32,count,i)=yes_9B(i); 
            x_mat(33,count,i)=yes_10B(i); 
            x_mat(34,count,i)=yes_11B(i); 
            x_mat(35,count,i)=yes_12B(i); 
            x_mat(36,count,i)=yes_9H(i); 
            x_mat(37,count,i)=yes_10H(i); 
            x_mat(38,count,i)=yes_11H(i); 
            x_mat(39,count,i)=yes_12H(i); 
            x_mat(40,count,i)=yes_9O(i); 
            x_mat(41,count,i)=yes_10O(i); 
            x_mat(42,count,i)=yes_11O(i); 
            x_mat(43,count,i)=yes_12O(i);
            
            x_mat(44,count,i)=yes_9WG(i); 
            x_mat(45,count,i)=yes_10WG(i); 
            x_mat(46,count,i)=yes_11WG(i); 
            x_mat(47,count,i)=yes_12WG(i); 
            x_mat(48,count,i)=yes_9WB(i); 
            x_mat(49,count,i)=yes_10WB(i); 
            x_mat(50,count,i)=yes_11WB(i); 
            x_mat(51,count,i)=yes_12WB(i);

            x_mat(52,count,i)=yes_9BG(i); 
            x_mat(53,count,i)=yes_10BG(i); 
            x_mat(54,count,i)=yes_11BG(i); 
            x_mat(55,count,i)=yes_12BG(i); 
            x_mat(56,count,i)=yes_9BB(i); 
            x_mat(57,count,i)=yes_10BB(i); 
            x_mat(58,count,i)=yes_11BB(i); 
            x_mat(59,count,i)=yes_12BB(i);
            
            x_mat(60,count,i)=yes_9HG(i); 
            x_mat(61,count,i)=yes_10HG(i); 
            x_mat(62,count,i)=yes_11HG(i); 
            x_mat(63,count,i)=yes_12HG(i); 
            x_mat(64,count,i)=yes_9HB(i); 
            x_mat(65,count,i)=yes_10HB(i); 
            x_mat(66,count,i)=yes_11HB(i); 
            x_mat(67,count,i)=yes_12HB(i); 

            x_mat(68,count,i)=yes_9OG(i); 
            x_mat(69,count,i)=yes_10OG(i); 
            x_mat(70,count,i)=yes_11OG(i); 
            x_mat(71,count,i)=yes_12OG(i); 
            x_mat(72,count,i)=yes_9OB(i); 
            x_mat(73,count,i)=yes_10OB(i); 
            x_mat(74,count,i)=yes_11OB(i); 
            x_mat(75,count,i)=yes_12OB(i);
            count=count+1; 
        end 
    end

    %confidence interval
    z=1.96; 
    for i=1:75 
        for j=1:r
            n=n_mat(i,j); 
            for k=1:cat_n
                x=x_mat(i,k, j); %x_mat=zeros(59,5,r); 
                p=x/n;  %x is the number of subjects saying "yes", n is the total subjects
                upper=((p+z*sqrt(p*(1-p)/n))*100); 
                lower=((p-z*sqrt(p*(1-p)/n))*100); 
                upper=sprintf('%0.1f',round(upper*10)/10);
                lower=sprintf('%0.1f',round(lower*10)/10);
                n_round=total{i+1, k+1, j}; 
                n_round=sprintf('%0.1f',round(n_round*10)/10);
                conf_mat{i+1,k+1, j}=[n_round ' (' lower ', ' upper ')']; 
            end 
        end 
    end 
    
    
    count_c=1; 
    [r,c,z]=size(conf_mat); 
    conf_mat2=cell(r,c*z+z); 
    for i=1:z
        new_mat=conf_mat(:,1:c,i); 
        conf_mat2(:,count_c:count_c+c-1)=new_mat; 
        count_c=count_c+c+1; 
    end 

 end 
