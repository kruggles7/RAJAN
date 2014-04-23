heatmap=1;
graph=1;

ques= {'Q76'; 'Q77'; 'Q78'; 'Q79'}; 
[row,c]=size(ques); 
files=dir(fullfile('C:','Users','kruggles7','Documents','MATLAB', 'Rajan', 'heatmaps_final','NaN_files', '*.txt'));
% reads all the text files in the folder 'binary_NaN_files' and saves them in an array called files
% make sure that folder contains only the NaN files for the questions you want to run create_hm_graph for
N=length(files);
for i=1:N
    question_mat=importdata(files(i).name, '\t');
    filename='';
    a=char(files(i).name);
    b=strfind(a,'-');
    for p=1:(b(1)-1)
        c=a(p);
        filename=[filename c];
    end
    for j=1:row
        if (strcmp(ques{j},filename)==1)
        %%% ^ this piece of the program just makes the variable 'filename' out of everything before the '-' in 'Q#--NaN'
        [ per_mat_map ] = create_hm_graph_yeardiff ( question_mat, filename );
        end
    end 
end