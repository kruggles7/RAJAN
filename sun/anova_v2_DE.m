files=dir(fullfile('C:','Users','kruggles7','Documents','MATLAB', 'Rajan', 'cdc', 'data', 'cat_010314', '*.txt'));
% reads all the text files in the folder 'binary_NaN_files' and saves them in an array called files
% make sure that folder contains only the NaN files for the questions you want to run create_hm_graph for
N=length(files);
p_mat=cell(28,11);
f_mat=cell(28,11); 
cd .. 
cd ..
cd data
cd cat_results_010314
question_mat=importdata('Q76-cat-NaN.txt', '\t');
[r,c]=size(question_mat);
question_mat(:,1)=0; 

i=1; 
p_mat{2,1}='total';
p_mat{3,1}='girls';  
p_mat{4,1}='boys'; 
p_mat{5,1}='white'; 
p_mat{6,1}='black'; 
p_mat{7,1}='hispanic'; 
p_mat{8,1}='other'; 
p_mat{9,1}='white-girls'; 
p_mat{10,1}='black-girls'; 
p_mat{11,1}='hispanic-girls'; 
p_mat{12,1}='other-girls'; 
p_mat{13,1}='white-boys'; 
p_mat{14,1}='black-boys'; 
p_mat{15,1}='hispanic-boys'; 
p_mat{16,1}='other-boys'; 
p_mat{17,1}='9th'; 
p_mat{18,1}='10th'; 
p_mat{19,1}='11th'; 
p_mat{20,1}='12th'; 
p_mat{21,1}='9th-girls'; 
p_mat{22,1}='10th-girls'; 
p_mat{23,1}='11th-girls'; 
p_mat{24,1}='12th-girls'; 
p_mat{25,1}='9th-boys'; 
p_mat{26,1}='10th-boys'; 
p_mat{27,1}='11th-boys'; 
p_mat{28,1}='12th-boys'; 

f_mat(:,1)=p_mat(:,1); 

cd .. 
cd controls
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt', '\t'); 
weight=importdata('weight.txt','\t'); 
grade=importdata('grade-NaN.txt','\t'); 
cd ..

[r,c]=size(question_mat); 
indx=find(question_mat==0); 
question_mat(indx)=NaN; 

q_mat=question_mat; 
indx=find(q_mat<=3); 
q_mat(indx)=0; 
indx=find(q_mat>3); 
q_mat(indx)=1;

if (r<6)
    n=6-r; 
    sex=sex(5:6, :); 
    race=race(5:6, :); 
    weight=weight(5:6,:); 
    grade=grade(5:6,:); 
end 

[r,c]=size(q_mat); 
c_new=c-1; 
a_mat=nan(c_new,r); 
s_mat=nan(c_new,r);
r_mat=nan(c_new,r);
g_mat=nan(c_new,r); 
for j=1:c_new
    for k=1:r
        a_mat(j,k)=q_mat(k,j+1)*weight(r,j+1); 
        s_mat(1:c_new,k)=sex(k,2:c); 
        r_mat(1:c_new,k)=race(k,2:c);
        g_mat(1:c_new,k)=grade(k,2:c);
    end 
end 


[p, table,stats]=anova1(a_mat); 
p_mat{2, i+1}=p;
f_mat{2, i+1}=table{2,5}; 

index_girls=find(s_mat==1);
temp_mat=nan(c_new,r); 
temp_mat(index_girls)=a_mat(index_girls); 
[p, table,stats]=anova1(temp_mat);
p_mat{3, i+1}=p;
f_mat{3, i+1}=table{2,5}; 

index_boys=find(s_mat==2);
temp_mat=nan(c_new,r); 
temp_mat(index_boys)=a_mat(index_boys); 
[p, table,stats]=anova1(temp_mat);
p_mat{4, i+1}=p; 
f_mat{4, i+1}=table{2,5}; 

index_W=find(r_mat==1);
temp_mat=nan(c_new,r); 
temp_mat(index_W)=a_mat(index_W); 
[p, table,stats]=anova1(temp_mat);
p_mat{5, i+1}=p;
f_mat{5, i+1}=table{2,5}; 

index_B=find(r_mat==2);
temp_mat=nan(c_new,r); 
temp_mat(index_B)=a_mat(index_B); 
[p, table,stats]=anova1(temp_mat);
p_mat{6, i+1}=p;
f_mat{6, i+1}=table{2,5}; 

index_H=find(r_mat==3);
temp_mat=nan(c_new,r); 
temp_mat(index_H)=a_mat(index_H); 
[p, table,stats]=anova1(temp_mat);
p_mat{7, i+1}=p;
f_mat{7, i+1}=table{2,5}; 

index_O=find(r_mat==4);
temp_mat=nan(c_new,r); 
temp_mat(index_O)=a_mat(index_O); 
[p, table,stats]=anova1(temp_mat);
p_mat{8, i+1}=p;
f_mat{8, i+1}=table{2,5}; 

index_WG=intersect(index_W, index_girls); 
temp_mat=nan(c_new,6); 
temp_mat(index_WG)=a_mat(index_WG); 
[p, table,stats]=anova1(temp_mat);
p_mat{9, i+1}=p;
f_mat{9, i+1}=table{2,5}; 

index_BG=intersect(index_B, index_girls); 
temp_mat=nan(c_new,r); 
temp_mat(index_BG)=a_mat(index_BG); 
[p, table,stats]=anova1(temp_mat);
p_mat{10, i+1}=p;
f_mat{10, i+1}=table{2,5}; 

index_HG=intersect(index_H, index_girls); 
temp_mat=nan(c_new,r); 
temp_mat(index_HG)=a_mat(index_HG); 
[p, table,stats]=anova1(temp_mat);
p_mat{11, i+1}=p;
f_mat{11, i+1}=table{2,5}; 

index_OG=intersect(index_O, index_girls); 
temp_mat=nan(c_new,r); 
temp_mat(index_OG)=a_mat(index_OG); 
[p, table,stats]=anova1(temp_mat);
p_mat{12, i+1}=p;
f_mat{12, i+1}=table{2,5}; 

index_WB=intersect(index_W, index_boys);   
temp_mat=nan(c_new,r); 
temp_mat(index_WB)=a_mat(index_WB); 
[p, table,stats]=anova1(temp_mat);
p_mat{13, i+1}=p;
f_mat{13, i+1}=table{2,5}; 

index_BB=intersect(index_B, index_boys);  
temp_mat=nan(c_new,r); 
temp_mat(index_BB)=a_mat(index_BB); 
[p, table,stats]=anova1(temp_mat);
p_mat{14, i+1}=p; 
f_mat{14, i+1}=table{2,5}; 

index_HB=intersect(index_H, index_boys); 
temp_mat=nan(c_new,r); 
temp_mat(index_HB)=a_mat(index_HB); 
[p, table,stats]=anova1(temp_mat);
p_mat{15, i+1}=p; 
f_mat{15, i+1}=table{2,5};  

index_OB=intersect(index_O, index_boys);  
temp_mat=nan(c_new,r); 
temp_mat(index_OB)=a_mat(index_OB); 
[p, table,stats]=anova1(temp_mat);
p_mat{16, i+1}=p;
f_mat{16, i+1}=table{2,5}; 

index_9=find(g_mat==1);  
temp_mat=nan(c_new,r); 
temp_mat(index_9)=a_mat(index_9); 
[p, table,stats]=anova1(temp_mat);
p_mat{17, i+1}=p;
f_mat{17, i+1}=table{2,5}; 

index_10=find(g_mat==2);  
temp_mat=nan(c_new,r); 
temp_mat(index_10)=a_mat(index_10); 
[p, table,stats]=anova1(temp_mat);
p_mat{18, i+1}=p;
f_mat{18, i+1}=table{2,5}; 

index_11=find(g_mat==3);  
temp_mat=nan(c_new,r); 
temp_mat(index_11)=a_mat(index_11); 
[p, table,stats]=anova1(temp_mat);
p_mat{19, i+1}=p;
f_mat{19, i+1}=table{2,5}; 

index_12=find(g_mat==4);  
temp_mat=nan(c_new,r); 
temp_mat(index_12)=a_mat(index_12); 
[p, table,stats]=anova1(temp_mat);
p_mat{20, i+1}=p;
f_mat{20, i+1}=table{2,5}; 

index_9G=intersect(index_9, index_girls);   
temp_mat=nan(c_new,r); 
temp_mat(index_9G)=a_mat(index_9G); 
[p, table,stats]=anova1(temp_mat);
p_mat{21, i+1}=p;
f_mat{21, i+1}=table{2,5}; 

index_10G=intersect(index_10, index_girls);  
temp_mat=nan(c_new,r); 
temp_mat(index_10G)=a_mat(index_10G); 
[p, table,stats]=anova1(temp_mat);
p_mat{22, i+1}=p;
f_mat{22, i+1}=table{2,5}; 

index_11G=intersect(index_11, index_girls);   
temp_mat=nan(c_new,r); 
temp_mat(index_11G)=a_mat(index_11G); 
[p, table,stats]=anova1(temp_mat);
p_mat{23, i+1}=p;
f_mat{23, i+1}=table{2,5};

index_12G=intersect(index_12, index_girls);  
temp_mat=nan(c_new,r); 
temp_mat(index_12G)=a_mat(index_12G); 
[p, table,stats]=anova1(temp_mat);
p_mat{24, i+1}=p;
f_mat{24, i+1}=table{2,5};


index_9B=intersect(index_9, index_boys);   
temp_mat=nan(c_new,r); 
temp_mat(index_9B)=a_mat(index_9B); 
[p, table,stats]=anova1(temp_mat);
p_mat{25, i+1}=p;
f_mat{25, i+1}=table{2,5}; 

index_10B=intersect(index_10, index_boys);  
temp_mat=nan(c_new,r); 
temp_mat(index_10B)=a_mat(index_10B); 
[p, table,stats]=anova1(temp_mat);
p_mat{26, i+1}=p;
f_mat{26, i+1}=table{2,5}; 

index_11B=intersect(index_11, index_boys); 
temp_mat=nan(c_new,r); 
temp_mat(index_11B)=a_mat(index_11B); 
[p, table,stats]=anova1(temp_mat);
p_mat{27, i+1}=p;
f_mat{27, i+1}=table{2,5};

index_12B=intersect(index_12, index_boys); 
temp_mat=nan(c_new,r); 
temp_mat(index_12B)=a_mat(index_12B); 
[p, table,stats]=anova1(temp_mat);
p_mat{28, i+1}=p;
f_mat{28, i+1}=table{2,5};
close all
