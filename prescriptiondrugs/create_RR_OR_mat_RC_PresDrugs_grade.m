%has reverse code information incorporated into this analysis

% This program goes through all the binary_NaN files and gets the relative risk of every combination
% of variables and displays them in a chart as follows:

% V1 | V2 | RR2001 | RR 2003 | RR2005 | RR2007 | RR2009 | RR2011
%____|____|________|_________|________|________|________|________
%	 |	  |		   |		 |		  |		   |		|

% It then does the same thing for odds ratio


k=2; %counter for rows in rel_risk_cell and odds_ratio_cell

files1=dir(fullfile('C:','Users','kruggles7','Documents','MATLAB', 'CDC', 'data','results_020314','NaN', '*.txt'));
cd ..
cd ..
cd matrices
load reverse_code.mat
cd .. 
cd data
cd controls
grades=importdata('grade-NaN.txt', '\t'); 
cd ..
cd results_020314
cd NaN
[r,c]=size(grades); 
grades=grades(6,2:c); 

quest_1=importdata('Q79--NaN.txt', '\t');
filename1='Q79'; 
q1_RC=reverse_code(79,1); 
[r,c]=size(quest_1); 
quest_1=quest_1(2,2:c); 
  
files2=dir(fullfile('C:','Users','kruggles7','Documents','MATLAB', 'CDC', 'data','results_020314','NaN', '*.txt'));
N=length(files2);
for j=1:4
    G=find(grades==j); 
    Q1=quest_1(G); 
    odds_ratio_cell{1,j+1}=j; 
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
        [r1,c1]=size(quest_1);
        [r2,c2]=size(quest_2); 
        quest_2=quest_2(r2,2:c2);  
        Q2=quest_2(G); 
        
        if q1_RC==1
            index_no_1=find(Q1==1); %students who answered yes to Q1
            index_yes_1=find(Q1==0); %students who answered no to Q1
            index_miss_1=find(Q1==9); %students who didn't answer Q1  
        else 
            index_yes_1=find(Q1==1); %students who answered yes to Q1
            index_no_1=find(Q1==0); %students who answered no to Q1
            index_miss_1=find(Q1==9); %students who didn't answer Q1
        end 
        
        %Q2:
        if q2_RC==1
            index_no_2=find(Q2==1);
            index_yes_2=find(Q2==0);
            index_miss_2=find(Q2==9);
        else 
            index_yes_2=find(Q2==1);
            index_no_2=find(Q2==0);
            index_miss_2=find(Q2==9);
        end 
        index_yes_both=intersect(index_yes_1, index_yes_2);  %students who said yes to both Qs
        index_no_both=intersect(index_no_1, index_no_2);  %student who said no to both Qs
        index_yes1_no2=intersect(index_yes_1, index_no_2);  %students who said yes to Q1 and no to Q2
        index_no1_yes2=intersect(index_no_1, index_yes_2);  %students who said no to Q1 and yes to Q2
        index_miss_both=intersect(index_miss_1, index_miss_2);  %students who left out both qs
        total_yes_both=length(index_yes_both);  %total who said yes to both questions
        total_no_both=length(index_no_both);  %total who said no to both questions
        total_yes1_no2=length(index_yes1_no2); %total who said yes to Q1 and no to Q2
        total_no1_yes2=length(index_no1_yes2); %total who said no to Q1 and yes to Q2

    %						Q1
    %						
    %				|  yes	|	no
    %		  ______|_______|_________	
    %   Q2		yes	|	a	|	b
    %		  ______|_______|_________
    %			no	|	c	|	d

        a=total_yes_both;
        d=total_no_both;
        c=total_yes1_no2;
        b=total_no1_yes2;
        P1= a/(a+b);
        P2= c/(c+d);
        OR= ( P1/(1-P1) ) / ( P2/(1-P2) );

        %odds_ratio cell matrix:
        odds_ratio_cell{n+1,1}=[filename2];
        x=num2cell(OR);
        odds_ratio_cell(n+1,j+1)=x;
    end 
end 