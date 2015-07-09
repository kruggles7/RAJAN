
 function [] = OR_2013_categoricalv2(ques1)

    k=1; %counter for rows in rel_risk_cell and odds_ratio_cell
    load reverse_code_091914
    cd ..
    cd results_103114
    cd cat
    file1=[ques1 '-cat-NaN.txt']; 
    quest_1=importdata(file1, '\t');
    filename1=ques1;
    a1=char(ques1);
    ct=''; 
    for q=2:numel(a1)
        c1=a1(q) ;
        ct=[ct c1]; 
    end 
    ct=str2num(ct);
    q1_RC=reverse_code(ct,1) ;
    [r,c]=size(quest_1); 
    max_q1=max(max(quest_1(:,2:c))); 

    %filename2-- make a matrix with all of the other stories 
    files2=dir(fullfile('/ifs/data/proteomics/projects/cdc/matlab/results_103114/NaN/', '*.txt'));
    cd ..
    cd NaN
    N=length(files2);
    quest_1F=nan(7,16411,N);  
    quest_2F=nan(7,16411,N);  
    year_final=double.empty; 
    for n=1:N %for each question 2
        quest_2=importdata(files2(n).name, '\t');
        filename2='';
        a2=char(files2(n).name);
        b2=strfind(a2,'-');
        for m=1:(b2(1)-1)
            c2=a2(m);
            filename2=[filename2 c2];
        end
        ct=[]; 
        for m=2:(b2(1)-1)
            c2=a2(m); 
            ct=[ct c2]; 
        end 
        files2(n).name;
        ct=str2num(ct);
        q2_RC=reverse_code(ct,1) ;
        if (isnan(q2_RC)==0 && isnan(q1_RC)==0) 
            [r1,c1]=size(quest_1);
            [r2,c2]=size(quest_2) ;
            year=[2001 2003 2005 2007 2009 2011 2013]; 
            year1=quest_1(:,1); 
            year2=quest_2(:,1); 
            counter=1; 
            s=0; %start for 1
            e=1; %start for 2
            for ii=1:numel(year)
                y=year(ii); 
                indx1=find(year1==y); 
                indx2=find(year2==y); 
                if numel(indx1)>0 && numel(indx2)>0 %both in the matrix
                    quest_1F(counter,1:c1-1,n)=quest_1(indx1,2:c1); 
                    quest_2F(counter,1:c2-1,n)=quest_2(indx2,2:c2); %for each question!
                    e=ii; 
                    if (s==0)
                        s=ii; 
                    end 
                end 
                counter=counter+1; 
            end 
            year_final(1,n)=s;
            year_final(2,n)=e; 
        end 
     end 
    
    for CAT=1%:max_q1 %for each categorical response for question 1
        [r,c,z]=size(quest_1F); 
        for n=78%1:z
            K=year_final(1,n); %start year for each question
            K_end=year_final(2,n); 
            if K>0
                for i=K:K_end %each year 
                    %Q1:
                    index_yes_1{i}=find(quest_1F(i,:,n)>=CAT); %students who answered yes to Q1
                    index_no_1{i}=find(quest_1F(i,:,n)<CAT & quest_1F(i,:,n)>0); %students who answered no to Q1
                    index_miss_1{i}=find(quest_1F(i,:,n)==0); %students who didn't answer Q1

                    %Q2:
                    if q2_RC==1
                        index_no_2{i}=find(quest_2F(i,:,n)==1);
                        index_yes_2{i}=find(quest_2F(i,:,n)==0);
                        index_miss_2{i}=find(quest_2F(i,:,n)==9);
                    else 
                        index_yes_2{i}=find(quest_2F(i,:,n)==1);
                        index_no_2{i}=find(quest_2F(i,:,n)==0);
                        index_miss_2{i}=find(quest_2F(i,:,n)==9);
                    end 
                 

                    index_yes_both{i}=intersect(index_yes_1{i}, index_yes_2{i});  %students who said yes to both Qs
                    index_no_both{i}=intersect(index_no_1{i}, index_no_2{i});  %student who said no to both Qs
                    index_yes1_no2{i}=intersect(index_yes_1{i}, index_no_2{i});  %students who said yes to Q1 and no to Q2
                    index_no1_yes2{i}=intersect(index_no_1{i}, index_yes_2{i});  %students who said no to Q1 and yes to Q2
                    index_miss_both{i}=intersect(index_miss_1{i}, index_miss_2{i});  %students who left out both qs


                    total_yes_both(i)=length(index_yes_both{i});  %total who said yes to both questions
                    total_no_both(i)=length(index_no_both{i});  %total who said no to both questions
                    total_yes1_no2(i)=length(index_yes1_no2{i}); %total who said yes to Q1 and no to Q2
                    total_no1_yes2(i)=length(index_no1_yes2{i}); %total who said no to Q1 and yes to Q2
                    %						Q1
                    %						
                    %				|  yes	|	no
                    %		  ______|_______|_________	
                    %   Q2		yes	|	a	|	b
                    %		  ______|_______|_________
                    %			no	|	c	|	d

                    a=total_yes_both(i);
                    d=total_no_both(i);
                    c=total_yes1_no2(i);
                    b=total_no1_yes2(i);

                    %formula for odds ratio:
                    OR= (a*d)/(b*c);

                    %find confidence interval for OR
                    lnOR=log(OR); 
                    seOR=sqrt((1/a)+(1/b)+(1/c)+(1/d)); 	
                    CI_upper=lnOR+1.96*seOR; 
                    CI_lower=lnOR-1.96*seOR; 
                    CI_upper=exp(CI_upper); 
                    CI_lower=exp(CI_lower); 
                    %odds_ratio cell matrix:
                    odds_ratio_cell{k,1}=[filename1];
                    odds_ratio_cell{k,2}=[filename2];
                    x=num2cell(OR);
                    odds_ratio_cell(k,i+2)=x;
                    OR_CI{k,1}=filename1; 
                    OR_CI{k,2}=filename2;
                    upper=sprintf('%0.2f',round(CI_upper*100)/100);
                    lower=sprintf('%0.2f',round(CI_lower*100)/100);
                    OR_CI{k,i+2}=[lower ', ' upper];
                end	
                k=k+1;
            end    	
        end
    end
    cd ..
    cd ..
    cd OR_results
    CAT_char=num2str(CAT); 
    matsave=[ques1 '_response_' CAT_char '_OR_2013_cat.mat']; 
    matsave_CI=[ques1 '_response_' CAT_char '_OR_2013_cat_CI.mat']; 
    save(matsave, 'odds_ratio_cell'); 
    save(matsave_CI, 'OR_CI'); 
    cd ..
end 
