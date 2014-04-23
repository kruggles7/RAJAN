k=1; %counter for rows in rel_risk_cell and odds_ratio_cell

files1=dir(fullfile('C:','Users','kruggles7','Documents','MATLAB', 'Rajan','NaN_results', '*.txt'));
load quest_55.mat
cd NaN_results
missing=double.empty; 
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
    indx=find(quest_55==ct); 
    if numel(indx)>0
        [r,c]=size(quest_1); 
        missing(k,1)=ct; 
        for i=1:r
            indx_t=find(isnan(quest_1(i,2:c))~=1); 
            total=numel(indx_t); 
            indx_m=find(quest_1(i,2:c)==9); 
            miss=numel(indx_m); 
            missing(k,i+1)=(miss/total)*100; 
        end 
        k=k+1; 
    end 
end