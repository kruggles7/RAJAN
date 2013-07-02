% This program creates 2 matrices - 'boys_RR_cell' and 'girls_rRR_cell' - which displays the relative risk
% (for either boys or girls, depending on the matrix) for each question for every year it was asked


gender_mat=importdata('sex-NaN.txt', '\t');

k=1; %counter for rows in the matrices

files=dir(fullfile('C:','Users','Kelly','Documents','RAJAN', 'Rachel', 'relative_risk', 'binary_files', '*.txt'));
P=length(files);
for p=1:P
	quest_mat=importdata(files(p).name, '\t');
	filename='';
	a=char(files(p).name);
	b=strfind(a,'-');
    q_num='';
	for q=1:(b(1)-1)
		c=a(q);
		filename=[filename c];
	end
    for q=2:b(1)-1
        c2=a(q); 
        q_num=[q_num c2]; 
    end 
	
	[r1,c1]=size(quest_mat);
	[r2,c2]=size(gender_mat); 
	
	r=r1;
		
		for i=1:r
			index_yes{i}=find(quest_mat(i,:)==1); %students who answered yes to the Q
			index_no{i}=find(quest_mat(i,:)==0); %students who answered no to the Q
			index_boys{i}=find(gender_mat(i,:)==2); %boys
			index_girls{i}=find(gender_mat(i,:)==1); %girls
		end

		for i=1:r
			index_yes_boys{i}=intersect(index_yes{i}, index_boys{i});  %boys who said yes
			index_no_boys{i}=intersect(index_no{i}, index_boys{i});  %boys who said no
			index_yes_girls{i}=intersect(index_yes{i}, index_girls{i});  %girls who said yes
			index_no_girls{i}=intersect(index_no{i}, index_girls{i});  %girls who said no
		end	


		for i=1:r
			total_yes_boys(i)=length(index_yes_boys{i});  %total boys who said yes
			total_no_boys(i)=length(index_no_boys{i});  %total boys who said no
			total_yes_girls(i)=length(index_yes_girls{i}); %total girls said yes
			total_no_girls(i)=length(index_no_girls{i}); %total girls who said no
		end
			
		%				|  yes	|	no
		%	____________|_______|_________	
		%		boys	|	a	|	b
		%	____________|_______|_________
		%		girls	|	c	|	d
		
		for i=1:r
			a(i)=total_yes_boys(i);
			b(i)=total_no_boys(i);
			c(i)=total_yes_girls(i);
			d(i)=total_no_girls(i);
		end

		%formula for relative risk:
		for i=1:r
			RRb(i)= ( a(i)/(a(i)+b(i)) ) / ( c(i)/(c(i)+d(i)) );
			RRg(i)= ( c(i)/(c(i)+d(i)) ) / ( a(i)/(a(i)+b(i)) );
		end
		
		%boys relative risk cell matrix:
		boys_RR_cell{k,1}=[q_num];
		x=num2cell(RRb);
		boys_RR_cell(k,2:2+r-1)=x(:);
		
		%girls relative risk cell matrix:
		girls_RR_cell{k,1}=[q_num];
		y=num2cell(RRg);
		girls_RR_cell(k,2:r+1)=y(:);
		
		k=k+1;
		
end