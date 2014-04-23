% This program creates 4 matrices: 'boys_RR_cell' and 'girls_RR_cell' - which displays the relative risk
% (for either boys or girls, depending on the matrix) for each question for every year it was asked, and
% 'boys_OR_cell' and 'girls_OR_cell' - which do the same for the odds ratio


gender_mat=importdata('sex-NaN.txt', '\t');

k=1; %counter for rows in the matrices

files=dir(fullfile('C:','Users','Rachel','Dropbox','Perl_Matlab', 'relative_risk', 'binary_NaN_files', '*.txt'));
P=length(files);
for p=1:P
	quest_mat=importdata(files(p).name, '\t');
	filename='';
	a=char(files(p).name);
	b=strfind(a,'-');
	for q=1:(b(1)-1)
		c=a(q);
		filename=[filename c];
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
		
		for i=1:r
			P1(i)= a(i)/(a(i)+b(i));
			P2(i)= c(i)/(c(i)+d(i));
		end
		
		%formula for odds ratio:
		for i=1:r
			ORb(i)= ( P1(i)/(1-P1(i)) ) / ( P2/(1-P2(i)) );
			ORg(i)= 1 / ORb(i);
		end
		
		%boys relative risk cell matrix:
		boys_RR_cell{k,1}=[filename];
		x=num2cell(RRb);
		boys_RR_cell(k,2:2+r-1)=x(:);
		
		%girls relative risk cell matrix:
		girls_RR_cell{k,1}=[filename];
		y=num2cell(RRg);
		girls_RR_cell(k,2:r+1)=y(:);
		
		%boys odds ratio cell matrix:
		boys_OR_cell{k,1}=[filename];
		x=num2cell(ORb);
		boys_OR_cell(k,2:2+r-1)=x(:);
		
		%girls odds ratio cell matrix:
		girls_OR_cell{k,1}=[filename];
		y=num2cell(ORg);
		girls_OR_cell(k,2:r+1)=y(:);
		
		k=k+1;
		
end