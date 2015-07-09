%has reverse code information incorporated into this analysis

% This program goes through all the binary_NaN files and gets the relative risk of every combination
% of variables and displays them in a chart as follows:

% V1 | V2 | RR2001 | RR 2003 | RR2005 | RR2007 | RR2009 | RR2011
%____|____|________|_________|________|________|________|________
%	 |	  |		   |		 |		  |		   |		|

% It then does the same thing for odds ratio

cd ..
cd Controls_061514
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt', '\t'); 
cd ..
cd matlab

k=1; %counter for rows in rel_risk_cell and odds_ratio_cell
CAT=2; %20 or more times 
files1=dir(fullfile('/ifs/data/proteomics/projects/cdc/matlab/results_053015/cat/', '*.txt')); 
load reverse_code_091914
R=1; %WHITE 
P=length(files1);
for G=1:2%gender
    for p=1:P %question
        cd results_053015
        cd cat
        files1(p).name;
        quest_1=importdata(files1(p).name, '\t');
        filename1='';
        a1=char(files1(p).name);
        b1=strfind(a1,'-');
        for q=1:(b1(1)-1)
            c1=a1(q);
            filename1=[filename1 c1];
        end
        ct=[]; 
        for q=2:(b1(1)-1)
            c1=a1(q) ;
            if c1~=0
                ct=[ct c1]; 
            end  
        end 
        ct=str2num(ct);
        q1_RC=reverse_code(ct,1); 
        cd ..
        cd ..
        if (ct == 78) %tanning 
            %filename2
            files2=dir(fullfile('/ifs/data/proteomics/projects/cdc/matlab/results_053015/NaN/', '*.txt'));
            N=length(files2);
            cd results_053015
            cd NaN
            for n=1:N
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
                    if c2~=0
                        ct=[ct c2] ; 
                    end 
                end 
                ct=str2num(ct);
                q2_RC=reverse_code(ct,1); 

                %PROCESS THE COMBO 
                if ( isnan(q2_RC)==0 && isnan(q1_RC)==0) 

                    [r1,c1]=size(quest_1);
                    [r2,c2]=size(quest_2) ;
                    year=[2001 2003 2005 2007 2009 2011 2013]; 
                    year1=quest_1(:,1); 
                    year2=quest_2(:,1); 
                    year_final=double.empty; 
                    quest_1F=double.empty; 
                    quest_2F=double.empty; 
                    counter=1; 
                    s=0; %start for 1
                    e=1; %start for 2
                    for ii=1:numel(year)
                        y=year(ii); 
                        indx1=find(year1==y); 
                        indx2=find(year2==y); 
                        if numel(indx1)>0 && numel(indx2)>0 %both in the matrix
                            year_final(counter,1)=y; 
                            quest_1F(counter,:)=quest_1(indx1,2:c1); 
                            quest_2F(counter,:)=quest_2(indx2,2:c2); 
                            e=ii; 
                            if (counter==1)
                                s=ii; 
                            end 
                            counter=counter+1; 
                        end 
                    end 
                    [r,c]=size(quest_1F); 
                    K=s+2; 
                    for i=1:r
                        %Q1:
                        index_final{i}=find(race(i,:)== R & sex(i,:)==G );
                        index_yes{i}=find(quest_1F(i,:)>=CAT); %students who answered yes to Q1
                        index_yes_1{i}=intersect(index_yes{i},index_final{i});
                        index_no{i}=find(quest_1F(i,:)<CAT & quest_1F(i,:)>0); %students who answered no to Q1
                        index_no_1{i}=intersect(index_no{i},index_final{i});
                        index_miss_1{i}=find(quest_1F(i,:)==0); %students who didn't answer Q1  
                        %Q2:
                        if q2_RC==1
                            index_no{i}=find(quest_2F(i,:)==1);
                            index_yes{i}=find(quest_2F(i,:)==0);
                            index_yes_2{i}=intersect(index_yes{i},index_final{i});
                            index_no_2{i}=intersect(index_no{i},index_final{i});
                            index_miss_2{i}=find(quest_2F(i,:)==9);
                        else 
                            index_yes{i}=find(quest_2F(i,:)==1);
                            index_no{i}=find(quest_2F(i,:)==0);
                            index_yes_2{i}=intersect(index_yes{i},index_final{i});
                            index_no_2{i}=intersect(index_no{i},index_final{i});
                            index_miss_2{i}=find(quest_2F(i,:)==9);
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
                        odds_ratio_cell(k,K)=x;
                        OR_CI{k,1}=[filename1]; 
                        OR_CI{k,2}=[filename2];
                        upper=sprintf('%0.2f',round(CI_upper*100)/100);
                        lower=sprintf('%0.2f',round(CI_lower*100)/100);
                        OR_CI{k,K}=[lower ', ' upper]; 

                        K=K+1 ;
                    end	
                    k=k+1;	
                end
            end
            cd ..
            cd ..
        end
    end 

    cd OR_results
    if R==1
        if G==1
            save('OR_2013_WHITE_GIRLS_Q78', 'odds_ratio_cell'); 
            save('OR_CI_2013_WHITE_GIRLS_Q78', 'OR_CI'); 
        elseif G==2
            save('OR_2013_WHITE_BOYS_Q78', 'odds_ratio_cell'); 
            save('OR_CI_2013_WHITE_BOYS_Q78', 'OR_CI'); 
        end      
    end
    cd ..
end 