% %has reverse code information incorporated into this analysis
% 
% % This program goes through all the binary_NaN files and gets the relative risk of every combination
% % of variables and displays them in a chart as follows:
% 
% % V1 | V2 | RR2001 | RR 2003 | RR2005 | RR2007 | RR2009 | RR2011
% %____|____|________|_________|________|________|________|________
% %	 |	  |		   |		 |		  |		   |		|
% 
% % It then does the same thing for odds ratio
% 
% 
% k=1; %counter for rows in rel_risk_cell and odds_ratio_cell
% 
% files1=dir(fullfile('C:','Users','rugglk01','Dropbox (Personal)', 'CDC', 'data','results_061514','NaN', '*.txt'));
% cd ..
% cd ..
% cd matrices
% load reverse_code.mat
% cd ..
% cd data
% cd results_061514
% cd NaN
% 
% P=length(files1);
% for p=1:P
% 	quest_1=importdata(files1(p).name, '\t');
% 	filename1='';
% 	a1=char(files1(p).name);
% 	b1=strfind(a1,'-');
%     for q=1:(b1(1)-1)
% 		c1=a1(q);
% 		filename1=[filename1 c1];
%     end
%     ct=[]; 
% 	for q=2:(b1(1)-1)
%         c1=a1(q) ;
%         if c1~=0
%             ct=[ct c1]; 
%         end  
%     end 
%     ct=str2num(ct);
%     q1_RC=reverse_code(ct,1); 
%     
%     %filename2
%     files2=dir(fullfile('C:','Users','rugglk01','Dropbox (Personal)', 'CDC', 'data','results_061514','NaN', '*.txt'));
% 	N=length(files2);
% 	for n=1:N
% 		quest_2=importdata(files2(n).name, '\t');
% 		filename2='';
% 		a2=char(files2(n).name);
% 		b2=strfind(a2,'-');
% 		for m=1:(b2(1)-1)
% 			c2=a2(m);
% 			filename2=[filename2 c2];
%         end
%         ct=[]; 
%         for m=2:(b2(1)-1)
%             c2=a2(m); 
%             if c2~=0
%                 ct=[ct c2] ; 
%             end 
%         end 
%         ct=str2num(ct);
%         q2_RC=reverse_code(ct,1); 
% 		
%         %PROCESS THE COMBO 
% 		if ( isnan(q2_RC)==0 && isnan(q1_RC)==0)
% 		
% 			[r1,c1]=size(quest_1);
% 			[r2,c2]=size(quest_2); 
%             year=[2001 2003 2005 2007 2009 2011 2013]; 
%             year1=quest_1(:,1); 
%             year2=quest_2(:,1); 
%             year_final=double.empty; 
%             quest_1F=double.empty; 
%             quest_2F=double.empty; 
%             counter=1; 
%             s=0; %start for 1
%             e=1; %start for 2
%             for ii=1:numel(year)
%                 y=year(ii); 
%                 indx1=find(year1==y); 
%                 indx2=find(year2==y); 
%                 if numel(indx1)>0 && numel(indx2)>0 %both in the matrix
%                     year_final(counter,1)=y; 
%                     quest_1F(counter,:)=quest_1(indx1,:); 
%                     quest_2F(counter,:)=quest_2(indx2,:); 
%                     e=ii; 
%                     if (counter==1)
%                         s=ii; 
%                     end 
%                     counter=counter+1; 
%                 end 
%             end 
%             [r,c]=size(quest_1F); 
%             K=s+2; 
%             for i=1:r
%                 %Q1:
%                 if q1_RC==1
%                     index_no_1{i}=find(quest_1F(i,:)==1); %students who answered yes to Q1
%                     index_yes_1{i}=find(quest_1F(i,:)==0); %students who answered no to Q1
%                     index_miss_1{i}=find(quest_1F(i,:)==9); %students who didn't answer Q1  
%                 else 
%                     index_yes_1{i}=find(quest_1F(i,:)==1); %students who answered yes to Q1
%                     index_no_1{i}=find(quest_1F(i,:)==0); %students who answered no to Q1
%                     index_miss_1{i}=find(quest_1F(i,:)==9); %students who didn't answer Q1
%                 end 
%                 %Q2:
%                 if q2_RC==1
%                     index_no_2{i}=find(quest_2F(i,:)==1);
%                     index_yes_2{i}=find(quest_2F(i,:)==0);
%                     index_miss_2{i}=find(quest_2F(i,:)==9);
%                 else 
%                     index_yes_2{i}=find(quest_2F(i,:)==1);
%                     index_no_2{i}=find(quest_2F(i,:)==0);
%                     index_miss_2{i}=find(quest_2F(i,:)==9);
%                 end 
% 
%                 index_yes_both{i}=intersect(index_yes_1{i}, index_yes_2{i});  %students who said yes to both Qs
%                 index_no_both{i}=intersect(index_no_1{i}, index_no_2{i});  %student who said no to both Qs
%                 index_yes1_no2{i}=intersect(index_yes_1{i}, index_no_2{i});  %students who said yes to Q1 and no to Q2
%                 index_no1_yes2{i}=intersect(index_no_1{i}, index_yes_2{i});  %students who said no to Q1 and yes to Q2
%                 index_miss_both{i}=intersect(index_miss_1{i}, index_miss_2{i});  %students who left out both qs
% 
% 
%                 total_yes_both(i)=length(index_yes_both{i});  %total who said yes to both questions
%                 total_no_both(i)=length(index_no_both{i});  %total who said no to both questions
%                 total_yes1_no2(i)=length(index_yes1_no2{i}); %total who said yes to Q1 and no to Q2
%                 total_no1_yes2(i)=length(index_no1_yes2{i}); %total who said no to Q1 and yes to Q2
% 				
%                 a=total_yes_both(i);
%                 d=total_no_both(i);
%                 c=total_yes1_no2(i);
%                 b=total_no1_yes2(i);
% 				
% 				yesboth{k,1}=[filename1];
% 				yesboth{k,2}=[filename2];
% 				yesboth{k,K}=a;
%                 noboth{k,1}=[filename1]; 
%                 noboth{k,2}=[filename2]; 
%                 noboth{k,K}=d;
%                 yes1_no2{k,1}=[filename1]; 
%                 yes1_no2{k,2}=[filename2]; 
%                 yes1_no2{k,K}=c ;
%                 yes2_no1{k,1}=[filename1]; 
%                 yes2_no1{k,2}=[filename2]; 
%                 yes2_no1{k,K}=b;
%                  
%                 K=K+1 ;
%             end	
%             k=k+1;	
% 		end
%     end
% end



cd ..
cd ..
cd matrices
load order
load q_labels_010414.mat
load cross_tab_all.mat
cd ..

q1=yesboth(:,1); 
q2=yesboth(:,2);
q_num=q2(1:56,1);
xlab=q_num; 
yesboth_final=double.empty; 
noboth_final=double.empty; 
yes1_no2_final=double.empty; 
yes2_no1_final=double.empty; 
K=1; 

for j=6
    
    for i=1:length(q_num)-1
        q_char=(q_num{i}) ;
        indx1=find(strcmp(q1(:),q_char)==1); 
        n=1; 
        for k=1:length(indx1)-1
            indx=indx1(k); 
            if isempty(yesboth{indx,j+2})==0 
                yesboth_final(n,i)=yesboth{indx,j+2}; 
            end 
            
            if isempty(noboth{indx,j+2})==0 
                noboth_final(n,i)=noboth{indx,j+2}; 
            end 
            
            if isempty(yes1_no2{indx,j+2})==0 
                yes1_no2_final(n,i)=yes1_no2{indx,j+2}; 
            end 
            
            if isempty(yes2_no1{indx,j+2})==0 
                yes2_no1_final(n,i)=yes2_no1{indx,j+2}; 
            end 
            n=n+1; 
        end 
    end 
    [r,c]=size(yesboth_final); 
    yesboth_final2=zeros(r,c);
    noboth_final2=zeros(r,c);
    yes1_no2_final2=zeros(r,c);
    yes2_no1_final2=zeros(r,c);
    qlabel2=cell(r,1); 
    for i=1:length(order); 
        in=order(i); 
        yesboth_final2(i,:)=yesboth_final(in,:); 
        noboth_final2(i,:)=noboth_final(in,:); 
        yes1_no2_final2(i,:)=yes1_no2_final(in,:); 
        yes2_no1_final2(i,:)=yes2_no1_final(in,:); 
        qlabel2(i,1)=qlabel(in,1); 
    end  
    yesboth_final3=zeros(r,c);
    noboth_final3=zeros(r,c);
    yes1_no2_final3=zeros(r,c);
    yes2_no1_final3=zeros(r,c);
    for i=1:length(order); 
        in=order(i); 
        yesboth_final3(:,i)=yesboth_final2(:,in); 
        noboth_final3(:,i)=noboth_final2(:,in); 
        yes1_no2_final3(:,i)=yes1_no2_final2(:,in); 
        yes2_no1_final3(:,i)=yes2_no1_final2(:,in); 
    end
end 
yesboth_final3=yesboth_final3(1:55,:); 
noboth_final3=noboth_final3(1:55,:); 
yes1_no2_final3=yes1_no2_final3(1:55,:); 
yes2_no1_final3=yes2_no1_final3(1:55,:); 