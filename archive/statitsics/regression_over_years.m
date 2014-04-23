
files=dir(fullfile('C:','Users','Kelly','Documents','MATLAB', 'rajan', 'parsed_questions_111413', 'NaN', '*.txt'));
% reads all the text files in the folder 'binary_NaN_files' and saves them in an array called files
% make sure that folder contains only the NaN files for the questions you want to run create_hm_graph for
N=length(files);
for i=1%4%1:N
    cd .. 
    cd ..
    cd parsed_questions_111413
    cd NaN
    question_mat=importdata(files(i).name, '\t');
	%%%
    cd ..
    cd ..
    cd programs
    cd statistics
	filename='';
	a=char(files(i).name);
	b=strfind(a,'-');
	for p=1:(b(1)-1)
		c=a(p);
		filename=[filename c];
	end
	%%% ^ this piece of the program just makes the variable 'filename' out of everything before the '-' in 'Q#--NaN'
	[ per_mat_map, indx ] = regression_years ( question_mat, filename );
end