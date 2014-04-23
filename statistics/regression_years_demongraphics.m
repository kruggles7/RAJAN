files=dir(fullfile('C:','Users','kruggles7','Documents','MATLAB', 'Rajan', 'results_020314', 'NaN', '*.txt'));
% reads all the text files in the folder 'binary_NaN_files' and saves them in an array called files
% make sure that folder contains only the NaN files for the questions you want to run create_hm_graph for
N=length(files);
p_mat=cell(N,2); 
for i=1:N
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

    cd .. 
    cd ..
    cd controls
    sex=importdata('sex-NaN.txt', '\t');
    race=importdata('race-NaN.txt', '\t'); 
    weight=importdata('weight.txt','\t'); 
    grade=importdata('grade-NaN.txt','\t'); 
    cd ..
    cd statistics
    
    [r,c]=size(question_mat); 
    indx=find(question_mat==9); 
    question_mat(indx)=NaN; 

    [r,c]=size(question_mat); 

    c_new=c-1; 
    stat_mat=nan(c_new*6,2); 
    stat_mat(1:c_new,1)=question_mat(1,2:c); 
    stat_mat(1:c_new,2)=2001; 
    stat_mat(1:c_new,3)=sex(1,2:c); 
    stat_mat(1:c_new,4)=race(1,2:c); 
    stat_mat(c_new+1:c_new*2,1)=question_mat(2,2:c); 
    stat_mat(c_new+1:c_new*2,2)=2003; 
    stat_mat(c_new+1:c_new*2,3)=sex(2,2:c); 
    stat_mat(c_new+1:c_new*2,4)=race(2,2:c);
    stat_mat(c_new*2+1:c_new*3,1)=question_mat(3,2:c); 
    stat_mat(c_new*2+1:c_new*3,2)=2005; 
    stat_mat(c_new*2+1:c_new*3,3)=sex(3,2:c); 
    stat_mat(c_new*2+1:c_new*3,4)=race(3,2:c); 
    stat_mat(c_new*3+1:c_new*4,1)=question_mat(4,2:c); 
    stat_mat(c_new*3+1:c_new*4,2)=2007; 
    stat_mat(c_new*3+1:c_new*4,3)=sex(4,2:c); 
    stat_mat(c_new*3+1:c_new*4,4)=race(4,2:c); 
    stat_mat(c_new*4+1:c_new*5,1)=question_mat(5,2:c); 
    stat_mat(c_new*4+1:c_new*5,2)=2009; 
    stat_mat(c_new*4+1:c_new*5,3)=sex(5,2:c); 
    stat_mat(c_new*4+1:c_new*5,4)=race(5,2:c); 
    stat_mat(c_new*5+1:c_new*6,1)=question_mat(6,2:c); 
    stat_mat(c_new*5+1:c_new*6,2)=2011; 
    stat_mat(c_new*5+1:c_new*6,3)=sex(6,2:c); 
    stat_mat(c_new*5+1:c_new*6,4)=race(6,2:c); 
    
    indx=find(isnan(stat_mat(:,1))==0); 
    stat_mat2=stat_mat(indx,:); 
    
    index_girls=find(stat_mat2(:,3)==1);
    index_boys=find(stat_mat2(:,3)==2);
    index_W=find(stat_mat2(:,4)==1);
    index_B=find(stat_mat2(:,4)==2);
    index_H=find(stat_mat2(:,4)==3);
    index_O=find(stat_mat2(:,4)==4);
    index_WG=intersect(index_girls,index_W); 
    index_BG=intersect(index_girls,index_B); 
    index_HG=intersect(index_girls,index_H); 
    index_OG=intersect(index_girls,index_O); 
    index_WB=intersect(index_boys,index_W); 
    index_BB=intersect(index_boys,index_B); 
    index_HB=intersect(index_boys,index_H); 
    index_OB=intersect(index_boys,index_O); 
    
    stat_g=stat_mat2(index_girls,:); 
    stat_b=stat_mat2(index_boys,:); 
    stat_W=stat_mat2(index_W,:); 
    stat_B=stat_mat2(index_B,:); 
    stat_O=stat_mat2(index_O,:); 
    stat_H=stat_mat2(index_H,:); 
    stat_Wg=stat_mat2(index_WG,:); 
    stat_Wb=stat_mat2(index_WB,:); 
    stat_Bb=stat_mat2(index_BB,:); 
    stat_Bg=stat_mat2(index_BG,:); 
    stat_Ob=stat_mat2(index_OB,:); 
    stat_Og=stat_mat2(index_OG,:); 
    stat_Hb=stat_mat2(index_HB,:); 
    stat_Hg=stat_mat2(index_HG,:); 
    
    %stats=regstats(stat_mat2(:,1),stat_mat2(:,2),'quadratic','fstat'); 
    %p_val=stats.fstat.pval; 
    %p_mat{i,1}=filename; 
    %p_mat{i,2}=p_val; 
end 

