
function [race_RR_cell] = rel_risk_race_allvs1 (race_choice)

race_mat=importdata('race-NaN.txt', '\t');

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
	
	[r,c]=size(quest_mat);
	
%	race1=the chosen race, race2=every other race
%	ex: race1=white, race2=non-white
	
	for i=1:r
		if (strcmp(race_choice,'W')==1)
			index_race1{i}=find(race_mat(i,:)==1);
			index_race2{i}=find(race_mat(i,:)==2 | race_mat(i,:)==3 | race_mat(i,:)==4);
		elseif(strcmp(race_choice,'B')==1);
			index_race1{i}=find(race_mat(i,:)==2);
			index_race2{i}=find(race_mat(i,:)==1 | race_mat(i,:)==3 | race_mat(i,:)==4 );
		elseif(strcmp(race_choice,'H')==1)
			index_race1{i}=find(race_mat(i,:)==3);
			index_race2{i}=find(race_mat(i,:)==1 | race_mat(i,:)==2 | race_mat(i,:)==4 );
		elseif(strcmp(race_choice,'O')==1)
			index_race1{i}=find(race_mat(i,:)==4);
			index_race2{i}=find(race_mat(i,:)==1 | race_mat(i,:)==2 | race_mat(i,:)==3 );
		else
			print 'Not a valid response'
	%		break;
		end
	end

	
	for i=1:r
		index_yes{i}=find(quest_mat(i,:)==1); %students who answered yes to the Q
		index_no{i}=find(quest_mat(i,:)==0); %students who answered no to the Q
	end

	for i=1:r
		index_yes_race1{i}=intersect(index_yes{i}, index_race1{i});  %race1 who said yes
		index_no_race1{i}=intersect(index_no{i}, index_race1{i});  %race1 who said no
		index_yes_race2{i}=intersect(index_yes{i}, index_race2{i});  %race2 who said no
		index_no_race2{i}=intersect(index_no{i}, index_race2{i});  %race2 who said no
	end	


	for i=1:r
		total_yes_race1(i)=length(index_yes_race1{i});
		total_no_race1(i)=length(index_no_race1{i}); 
		total_yes_race2(i)=length(index_yes_race2{i});
		total_no_race2(i)=length(index_no_race2{i}); 
	end

	%				|  yes	|	no
	%	____________|_______|_________	
	%		race1	|	a	|	b
	%	____________|_______|_________
	%		race2	|	c	|	d

	for i=1:r
		a(i)=total_yes_race1(i);
		b(i)=total_no_race1(i);
		c(i)=total_yes_race2(i);
		d(i)=total_no_race2(i);
	end

	%formula for relative risk:
	for i=1:r
		RR(i)= ( a(i)/(a(i)+b(i)) ) / ( c(i)/(c(i)+d(i)) );
	end

	%relative risk cell matrix:
	race_RR_cell{k,1}=[filename]; 
	x=num2cell(RR);
	race_RR_cell(k,2:1+r)=x(:);  %from 2 on, for r spaces: 2+r-1 ie. 1+r
	
	k=k+1;
	
end