files=dir(fullfile('C:','Users','Kelly','Documents','MATLAB', 'rajan','programs', 'results_020314', 'NaN', '*.txt'));
% reads all the text files in the folder 'binary_NaN_files' and saves them in an array called files
% make sure that folder contains only the NaN files for the questions you want to run create_hm_graph for
N=length(files);
p_mat=cell(N,2); 
for i=10%:N
    cd .. 
    cd results_020314
    cd NaN
    question_mat=importdata(files(i).name, '\t');
	filename='';
	a=char(files(i).name);
	b=strfind(a,'-');
	for p=1:(b(1)-1)
		c=a(p);
		filename=[filename c];
    end
    filename

    cd .. 
    cd ..
    sex=importdata('sex-NaN.txt', '\t');
    race=importdata('race-NaN.txt', '\t'); 
    weight=importdata('weight.txt','\t'); 
    cd statistics
    
    [r,c]=size(question_mat); 
    indx=find(question_mat==9); 
    question_mat(indx)=NaN; 

    [r,c]=size(question_mat); 
    c_new=c-1; 
    stat_mat=nan(c_new*6,2); 
    stat_mat(1:c_new,1)=question_mat(1,2:c); 
    stat_mat(1:c_new,2)=2001; 
    stat_mat(c_new+1:c_new*2,1)=question_mat(2,2:c); 
    stat_mat(c_new+1:c_new*2,2)=2003; 
    stat_mat(c_new*2+1:c_new*3,1)=question_mat(3,2:c); 
    stat_mat(c_new*2+1:c_new*3,2)=2005; 
    stat_mat(c_new*3+1:c_new*4,1)=question_mat(4,2:c); 
    stat_mat(c_new*3+1:c_new*4,2)=2007; 
    stat_mat(c_new*4+1:c_new*5,1)=question_mat(5,2:c); 
    stat_mat(c_new*4+1:c_new*5,2)=2009; 
    stat_mat(c_new*5+1:c_new*6,1)=question_mat(6,2:c); 
    stat_mat(c_new*5+1:c_new*6,2)=2011; 

    indx=find(isnan(stat_mat(:,1))==0); 
    stat_mat2=stat_mat(indx,:); 
    stats=regstats(stat_mat2(:,1),stat_mat2(:,2),'quadratic','fstat'); 
    p_val=stats.fstat.pval; 
    p_mat{i,1}=filename; 
    p_mat{i,2}=p_val; 
end 

