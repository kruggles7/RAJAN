quest_1=importdata('Q4--NaN.txt', '\t');
quest_2=importdata('Q5--NaN.txt', '\t');

graph=1;

filename1='Q4';
filename2='Q5';


[r1,c1]=size(quest_1);
[r2,c2]=size(quest_2); 

% 2 questions must have been asked in the same years of else wont work (r1 must = r2)
if (r1~=r2)
	break;
else

r=r1;

for i=1:r
	%Q1:
	index_yes_1{i}=find(quest_1(i,:)==1); %students who answered yes to Q1
	index_no_1{i}=find(quest_1(i,:)==0); %students who answered no to Q1
	index_miss_1{i}=find(quest_1(i,:)==9); %students who didn't answer Q1
	%Q2:
	index_yes_2{i}=find(quest_2(i,:)==1);
	index_no_2{i}=find(quest_2(i,:)==0);
	index_miss_2{i}=find(quest_2(i,:)==9);
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

% Matrix will look like this:
%				Q1
%			yes		no
%   Q2	yes	 a		b
%		no	 c		d

for i=1:r
	a(i)=total_yes_both(i);
	d(i)=total_no_both(i);
	c(i)=total_yes1_no2(i);
	b(i)=total_no1_yes2(i);
end

rel_risk_mat = zeros(2,2,r); %3D matrix - each "layer" is a year

for i=1:r
	rel_risk_mat(1,1,i)=a(i);
	rel_risk_mat(1,2,i)=b(i);
	rel_risk_mat(2,1,i)=c(i);
	rel_risk_mat(2,2,i)=d(i);
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
	OR(i)= ( P1(i)/(1-P1(i)) ) / ( P2/(1-P2(i)) );
end


%graph for relative risk over the years:
if (graph==1)
	year=2001:2:2011;
	plot(year,RR, '-ok');
	xlabel('Year');
	ylabel('Relative Risk')
	xlim([2000 2012]);
	set(gca,'xtick',2001:2:2011); 
	title([filename1 'and' filename2]);
	saveas(gca, [filename1 '_' filename2 '_RR_graph.pdf'] );
end

%graph for odds ratio over the years:
if (graph==1)
	year=2001:2:2011;
	plot(year,OR, '-ok');
	xlabel('Year');
	ylabel('Odds Ratio')
	xlim([2000 2012]);
	set(gca,'xtick',2001:2:2011); 
	title([filename1 'and' filename2]);
	saveas(gca, [filename1 '_' filename2 '_OR_graph.pdf'] );
end

end