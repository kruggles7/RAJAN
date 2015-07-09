heatmap=1;
graph=0;

files1=dir(fullfile('C:','Users','rugglk01','Dropbox (Personal)','CDC','data','results_053015','NaN', '*.txt'));

% reads all the text files in the folder 'binary_NaN_files' and saves them in an array called files
% make sure that folder contains only the NaN files for the questions you want to run create_hm_graph for
N=length(files1);

for i=1:N
    cd ..
    cd ..
    cd data
    cd Controls_061514
    sex=importdata('sex-NaN.txt', '\t');
    race=importdata('race-NaN.txt', '\t'); 
    weight=importdata('weights-NaN.txt','\t'); 
    cd ..
    cd results_053015
    cd NaN
    question_mat=importdata(files1(i).name, '\t');
	%%%
    cd .. 
    cd ..
    cd ..
    cd programs
    cd heatmaps
	filename='';
	a=char(files1(i).name);
	b=strfind(a,'-');
	for p=1:(b(1)-1)
		c=a(p);
		filename=[filename c];
	end
	%%% ^ this piece of the program just makes the variable 'filename' out of everything before the '-' in 'Q#--NaN'
	[ per_mat_map ] = create_hm_graph_2003_2013 ( question_mat, filename, race, sex, weight );
end