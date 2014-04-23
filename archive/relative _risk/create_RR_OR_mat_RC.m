%has reverse code information incorporated into this analysis

% This program goes through all the binary_NaN files and gets the relative risk of every combination
% of variables and displays them in a chart as follows:

% V1 | V2 | RR2001 | RR 2003 | RR2005 | RR2007 | RR2009 | RR2011
%____|____|________|_________|________|________|________|________
%	 |	  |		   |		 |		  |		   |		|

% It then does the same thing for odds ratio


k=1; %counter for rows in rel_risk_cell and odds_ratio_cell

%files1=dir(fullfile('C:','Users','kruggles7','Dropbox','RAJAN', 'CDC_FINAL', 'results_071113','NaN', '*.txt'));
files1=dir(fullfile('C:','Users','Kelly','Documents','MATLAB', 'rajan','nan_results', '*.txt'));

cd matrices
load reverse_code.mat
cd .. 
cd ..
cd ..
cd nan_results

P=length(files1);
for p=1:P
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
    
    %filename2
    files2=dir(fullfile('C:','Users','Kelly','Documents','MATLAB', 'rajan','nan_results', '*.txt'));
	N=length(files2);
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
		if ( isnan(q2_RC)==0 && isnan(q1_RC)==0) % won't compare a question to itself
		
			[r1,c1]=size(quest_1);
			[r2,c2]=size(quest_2); 
			
			% 2 questions must have been asked in the same years of else wont work (r1 must = r2)
			if (r1~=r2)
				break;
			else

				r=r1;
				
				for i=1:r
					%Q1:
                    if q1_RC==1
                        index_no_1{i}=find(quest_1(i,:)==1); %students who answered yes to Q1
                        index_yes_1{i}=find(quest_1(i,:)==0); %students who answered no to Q1
                        index_miss_1{i}=find(quest_1(i,:)==9); %students who didn't answer Q1  
                    else 
                        index_yes_1{i}=find(quest_1(i,:)==1); %students who answered yes to Q1
                        index_no_1{i}=find(quest_1(i,:)==0); %students who answered no to Q1
                        index_miss_1{i}=find(quest_1(i,:)==9); %students who didn't answer Q1
                    end 
					%Q2:
                    if q2_RC==1
                        index_no_2{i}=find(quest_2(i,:)==1);
                        index_yes_2{i}=find(quest_2(i,:)==0);
                        index_miss_2{i}=find(quest_2(i,:)==9);
                    else 
                        index_yes_2{i}=find(quest_2(i,:)==1);
                        index_no_2{i}=find(quest_2(i,:)==0);
                        index_miss_2{i}=find(quest_2(i,:)==9);
                    end 
				end

				%combined:
				for i=1:r
					index_yes_both{i}=intersect(index_yes_1{i}, index_yes_2{i});  %students who said yes to both Qs
					index_no_both{i}=intersect(index_no_1{i}, index_no_2{i});  %student who said no to both Qs
					index_yes1_no2{i}=intersect(index_yes_1{i}, index_no_2{i});  %students who said yes to Q1 and no to Q2
					index_no1_yes2{i}=intersect(index_no_1{i}, index_yes_2{i});  %students who said no to Q1 and yes to Q2
					index_miss_both{i}=intersect(index_miss_1{i}, index_miss_2{i});  %students who left out both qs
				end	


				for i=1:r
					total_yes_both(i)=length(index_yes_both{i});  %total who said yes to both questions
					total_no_both(i)=length(index_no_both{i});  %total who said no to both questions
					total_yes1_no2(i)=length(index_yes1_no2{i}); %total who said yes to Q1 and no to Q2
					total_no1_yes2(i)=length(index_no1_yes2{i}); %total who said no to Q1 and yes to Q2
				end

				%						Q1
				%						
				%				|  yes	|	no
				%		  ______|_______|_________	
				%   Q2		yes	|	a	|	b
				%		  ______|_______|_________
				%			no	|	c	|	d
				
				for i=1:r
					a(i)=total_yes_both(i);
					d(i)=total_no_both(i);
					c(i)=total_yes1_no2(i);
					b(i)=total_no1_yes2(i);
				end

				%formula for relative risk:
				for i=1:r
					RR(i)= ( a(i)/(a(i)+b(i)) ) / ( c(i)/(c(i)+d(i)) );
				end
				
				for i=1:r
					P1(i)= a(i)/(a(i)+b(i));
					P2(i)= c(i)/(c(i)+d(i));
				end
				
				%formula for odds ratio:
				for i=1:r
					OR(i)= ( P1(i)/(1-P1(i)) ) / ( P2(i)/(1-P2(i)) );
                    OR2(i)=(a(i)*d(i))/(b(i)*c(i)); 
				end
				
				
				%rel_risk cell matrix:
				rel_risk_cell{k,1}=[filename1];
				rel_risk_cell{k,2}=[filename2];
				x=num2cell(RR);
				rel_risk_cell(k,3:8)=x(:);
				
				%odds_ratio cell matrix:
				odds_ratio_cell{k,1}=[filename1];
				odds_ratio_cell{k,2}=[filename2];
				x=num2cell(OR);
				odds_ratio_cell(k,3:8)=x(:);
                
                odds_ratio_cell2{k,1}=[filename1]; 
				odds_ratio_cell2{k,2}=[filename2];
				x2=num2cell(OR2);
				odds_ratio_cell2(k,3:8)=x2(:);
				
				k=k+1;	
            end	
            
%         else 
%             odds_ratio_cell2{k,1}=[filename1]; 
%             odds_ratio_cell2{k,2}=[filename2]; 
%             for b=3:8
%                 odds_ratio_cell2{k,b}=Inf; 
%             end 
		end
	end
end