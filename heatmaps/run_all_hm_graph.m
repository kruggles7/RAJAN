heatmap=1;
graph=0;

files=dir(fullfile('C:','Users','kruggles7','Documents','MATLAB', 'CDC', 'data','results_020314','NaN', '*.txt'));

% reads all the text files in the folder 'binary_NaN_files' and saves them in an array called files
% make sure that folder contains only the NaN files for the questions you want to run create_hm_graph for
N=length(files);

for i=1:N
    cd ..
    cd ..
    cd data
    cd controls 
    sex=importdata('sex-NaN.txt', '\t');
    race=importdata('race-NaN.txt', '\t'); 
    weight=importdata('weight.txt','\t'); 
    cd ..
    cd results_020314
    cd NaN
    question_mat=importdata(files(i).name, '\t');
	%%%
    cd .. 
    cd ..
    cd ..
    cd programs
    cd heatmaps
	filename='';
	a=char(files(i).name);
	b=strfind(a,'-');
	for p=1:(b(1)-1)
		c=a(p);
		filename=[filename c];
	end
	%%% ^ this piece of the program just makes the variable 'filename' out of everything before the '-' in 'Q#--NaN'
	[ per_mat_map ] = create_hm_graph ( question_mat, filename, race, sex, weight );
end