
ques1= {'Q18'; 'Q23'; 'Q56'};
ques2= {'Q20'; 'Q24'; 'Q57'}; 
label= {'alcohol', 'marijuana', 'cigarettes'}; 
files=dir(fullfile('C:','Users','kruggles7','Documents','MATLAB', 'Rajan', 'heatmaps_final','NaN_files', '*.txt'));
final_mat=zeros(3, 15, 6); 
for i=1:numel(ques1); 
    cd ..
    cd ..
    cd data
    cd results_020314
    cd NaN
    question_mat1=importdata([ques1{i} '--NaN.txt'], '\t');
    question_mat2=importdata([ques2{i} '--NaN.txt'], '\t'); 
    cd ..
    cd ..
    cd ..
    cd programs
    cd schooldrugs
    [ permat1, permat2, ratio_mat ] = plot_demographic_graphsv3 ( question_mat1, question_mat2, label{i} );
    final_mat(i,:,:)=ratio_mat; 
end
