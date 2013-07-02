%find the total number of samples and missing for each year when we are
%looking at both sex and race 


question_mat=importdata('Q74--NaN.txt', '\t');
%question_mat=importdata('Q75--NaN.txt', '\t');
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt','\t'); 
heatmap=1;
graph=0;
[ per_mat_map ] = create_hm_2 ( question_mat, 'Q74', heatmap, graph );


% question_mat=importdata('Q75--NaN.txt', '\t');
% heatmap=1;
% graph=0;
% [ per_mat_map ] = create_hm_2 ( question_mat, 'Q75', heatmap, graph );