heatmap=1;
graph=1;

files=dir(fullfile('C:','Users','Rachel','Dropbox','Perl_Matlab', 'matlab_create_all_NEW', 'binary_NaN_files', '*.txt'));
% reads all the text files in the folder 'binary_NaN_files' and saves them in an array called files
% make sure that folder contains only the NaN files for the questions you want to run create_hm_graph for
N=length(files);
for i=1:N
    question_mat=importdata(files(i).name, '\t');
	%%%
	filename='';
	a=char(files(i).name);
	b=strfind(a,'-');
	for p=1:(b(1)-1)
		c=a(p);
		filename=[filename c];
	end
	%%% ^ this piece of the program just makes the variable 'filename' out of everything before the '-' in 'Q#--NaN'
	[ per_mat_map ] = create_hm_graph ( question_mat, filename, heatmap, graph );
end