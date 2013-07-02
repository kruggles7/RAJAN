
heatmap=1;
graph=1;
sex=importdata('sex-NaN.txt', '\t');
race=importdata('RACE-NaN.txt', '\t'); 
TOTAL=importdata('TOTAL.txt', '\t'); 

title1=char('During the past 30 days, on how many days did you not', 'go to school because you felt you would be unsafe at', 'school or on your way to or from school?'); 
filename='unsafe_q4'; 
question_mat=importdata('q4-binary-NaN.txt', '\t'); 
[ per_mat_map_4 ] = combo_hm_NEW( question_mat, filename, title1, sex, race, TOTAL, heatmap, graph);

%title5=char('During the past 12 months, how many times has someone threatened or', 'injured you with a weapon such as a gun, knife, or club on school property?'); 
%filename5='threatened_q5'; 
%question_mat5=importdata('q5-binary-NaN.txt', '\t'); 
%[ mat_new_map_5 ] = combo_hm_NEW( question_mat5, filename5, title5, sex, race, TOTAL, heatmap, graph ); 