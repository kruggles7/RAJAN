%has reverse code information incorporated into this analysis

% This program goes through all the binary_NaN files and gets the relative risk of every combination
% of variables and displays them in a chart as follows:

% V1 | V2 | RR2001 | RR 2003 | RR2005 | RR2007 | RR2009 | RR2011
%____|____|________|_________|________|________|________|________
%	 |	  |		   |		 |		  |		   |		|

% It then does the same thing for odds ratio

%Hispanic Girls only 
R=3;
G=1;
filename1='Q11-Q16'; 
k=1; 

cd .. 
cd Controls_061514
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt', '\t'); 
cd ..
cd matlab

Q={'Q11', 'Q12', 'Q13', 'Q14', 'Q16'}; 
files1=dir(fullfile('/ifs/data/proteomics/projects/cdc/matlab/results_053015/NaN/', '*.txt')); 
%files1=dir(fullfile('C:/Users/rugglk01/Dropbox (Personal)/CDC/data/results_053015/NaN/', '*.txt')); 
load reverse_code_091914

N=length(files1);
QUEST_MAT=double.empty; 
count=1; 
for j=1:N
    cd results_053015
    cd NaN
    question_mat=importdata(files1(j).name, '\t');
    cd .. 
    cd ..
	filename='';
	a=char(files1(j).name);
	b=strfind(a,'-');
	for p=1:(b(1)-1)
		c=a(p);
		filename=[filename c];
    end
    
    indx=find(strcmp(filename, Q)==1); 
    if numel(indx)>0
        [r,c]=size(question_mat);
        label_=question_mat(2:r,1); 
        QUEST_MAT(:,:,count)=question_mat; 
        count=count+1; 
    end 
end 

for j=1:N
    cd results_053015
    cd NaN
    quest_2=importdata(files1(j).name, '\t');
    cd .. 
    cd ..
	filename2='';
	a=char(files1(j).name);
	b=strfind(a,'-');
	for p=1:(b(1)-1)
		c=a(p);
		filename2=[filename2 c];
    end
    ct=[]; 
    for q=2:(b(1)-1)
        c1=a(q) ;
        if c1~=0
            ct=[ct c1]; 
        end  
    end 
    ct=str2num(ct);
    q2_RC=reverse_code(ct,1); 

    %PROCESS THE COMBO 
    if (isnan(q2_RC)==0) 

        [r1,c1, z]=size(QUEST_MAT);
        [r2,c2]=size(quest_2) ;
        year=[2001 2003 2005 2007 2009 2011 2013]; 
        quest_1=QUEST_MAT(:,:,1); 
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
        [r1,c1]=size(quest_1F); 
        K=s+2; 
        for i=1:r1
            %Q1:
            index_final{i}=find(race(i,:)== R & sex(i,:)==G );
            index_yes{i}=find(QUEST_MAT(i,2:c1,1)==1 & QUEST_MAT(i,2:c1,2)==1 & QUEST_MAT(i,2:c1,3)==1  & QUEST_MAT(i,2:c1,4)==1  & QUEST_MAT(i,2:c1,5)==1 ); %students who answered yes to Q1
            index_no{i}=find(QUEST_MAT(i,2:c1,1)==0 & QUEST_MAT(i,2:c1,2)==0 & QUEST_MAT(i,2:c1,3)==0  & QUEST_MAT(i,2:c1,4)==0  & QUEST_MAT(i,2:c1,5)==0); %students who answered no to Q1
            index_yes_1{i}=intersect(index_yes{i},index_final{i});
            index_no_1{i}=intersect(index_no{i},index_final{i});
            index_miss{i}=find(QUEST_MAT(i,2:c1,1)==9 | QUEST_MAT(i,2:c1,2)==9 | QUEST_MAT(i,2:c1,3)==9  | QUEST_MAT(i,2:c1,4)==9 | QUEST_MAT(i,2:c1,5)==9 ); %students who didn't answer Q1
            index_miss_1{i}=intersect(index_miss{i}, index_final{i}); 
            %Q2:
            if q2_RC==1
                index_no{i}=find(quest_2F(i,:)==1);
                index_yes{i}=find(quest_2F(i,:)==0);
                index_yes_2{i}=intersect(index_yes{i},index_final{i});
                index_no_2{i}=intersect(index_no{i},index_final{i});
                index_miss{i}=find(quest_2F(i,:)==9);
                index_miss_2{i}=intersect(index_miss{i}, index_final{i}); 
            else 
                index_yes{i}=find(quest_2F(i,:)==1);
                index_no{i}=find(quest_2F(i,:)==0);
                index_yes_2{i}=intersect(index_yes{i},index_final{i});
                index_no_2{i}=intersect(index_no{i},index_final{i});
                index_miss{i}=find(quest_2F(i,:)==9);
                index_miss_2{i}=intersect(index_miss{i}, index_final{i}); 
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

cd OR_results
save('OR_2013_HISPANIC_GIRLS_MentalHealth', 'odds_ratio_cell'); 
save('OR_CI_2013_HISPANIC_GIRLS_MentalHealth', 'OR_CI'); 
OR_CI=cell.empty; 
odds_ratio_cell=cell.empty; 
cd ..