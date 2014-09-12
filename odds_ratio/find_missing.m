%h
k=1; %counter for rows in rel_risk_cell and odds_ratio_cell

files1=dir(fullfile('C:','Users','kruggles7','Documents','MATLAB', 'CDC', 'data','results_061514','NaN', '*.txt'));
cd ..
cd ..
cd matrices
load reverse_code.mat
cd ..
cd data
cd results_061514
cd NaN

P=length(files1);
missing=cell(numel(P),8); 
for p=1:P
	quest_1=importdata(files1(p).name, '\t');
	filename1='';
	a1=char(files1(p).name);
	b1=strfind(a1,'-');
    for q=1:(b1(1)-1)
		c1=a1(q);
		filename1=[filename1 c1];
    end
	missing{p,1}=filename1; 	
    [r1,c1]=size(quest_1);
    year=[2001 2003 2005 2007 2009 2011 2013]; 
    year1=quest_1(:,1); 
    year_final=double.empty; 
    quest_1F=double.empty; 
    counter=1; 
    s=0; %start for 1
    e=1; %start for 2
    for ii=1:numel(year)
        y=year(ii); 
        indx1=find(year1==y); 
        if numel(indx1)>0  %both in the matrix
            year_final(counter,1)=y; 
            quest_1F(counter,:)=quest_1(indx1,:); 
            e=ii; 
            if (counter==1)
                s=ii; 
            end 
            counter=counter+1; 
        end 
    end 
    [r,c]=size(quest_1F); 
    K=s+1; 
    for i=1:r
        index_no_1=find(quest_1F(i,:)==1); %students who answered yes to Q1
        index_yes_1=find(quest_1F(i,:)==0); %students who answered no to Q1
        index_miss_1=find(quest_1F(i,:)==9); %students who didn't answer Q1  
        total=numel(index_no_1)+numel(index_yes_1)+numel(index_miss_1); 
        missing{p,K}=numel(index_miss_1)/total*100; 
        K=K+1; 
    end 
end