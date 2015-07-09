%%The proportion here is different from the total proportion because 
%I didn't apply a weight like we did with the heatmaps
%Find out if we should add a weight here!!! 

%This is for ALL of the population 
filename1='Q11-Q16'; 
k=1; 

cd .. 
cd ..
cd matrices
load reverse_code_091914
cd ..
cd data
cd Controls_061514
sex=importdata('sex-NaN.txt', '\t');
race=importdata('race-NaN.txt', '\t'); 
weight=importdata('weight-NaN.txt', '\t'); 
cd ..
Q={'Q11', 'Q12', 'Q13', 'Q16', 'Q14'}; 
Q_lab={'Felt sad or hopeless', 'Considered suicide', 'Made a plan to commit suicide','Attempted Suicide', 'Injured from suicide attempt' }; 
%files1=dir(fullfile('/ifs/data/proteomics/projects/cdc/matlab/results_053015/NaN/', '*.txt')); 
files1=dir(fullfile('C:/Users/rugglk01/Dropbox (Personal)/CDC/data/results_053015/NaN/', '*.txt')); 


N=length(files1);
QUEST_MAT=double.empty; 
count=1; 
for j=1:N
    cd results_053015
    cd NaN
    question_mat=importdata(files1(j).name, '\t');
    cd .. 
    cd ..
	filename='';
	a=char(files1(j).name);
	b=strfind(a,'-');
	for p=1:(b(1)-1)
		c=a(p);
		filename=[filename c];
    end
    
    indx=find(strcmp(filename, Q)==1); 
    if numel(indx)>0
        [r,c]=size(question_mat);
        label_=question_mat(2:r,1); 
        QUEST_MAT(:,:,count)=question_mat; 
        count=count+1; 
    end 
end 

[r,c,z]=size(QUEST_MAT); 
count_mat=zeros(z,z,k); 
total_mat=zeros(z,z,k); 
per_mat=zeros(z,z,k); 
for k=1:r
    for j=1:z
        mat1=QUEST_MAT(k,2:c,j); 
        indx1=find(mat1==1); 
        indx_nan1=find(isnan(mat1)==0 & mat1<9); 
        for i=1:z
            mat2=QUEST_MAT(k,2:c,i); 
            indx2=find(mat2==1); 
            indx_nan2=find(isnan(mat2)==0 & mat2<9); 
            over=intersect(indx1,indx2); 
            count_mat(j,i,k)=numel(over); 
            over_nan=intersect(indx_nan1, indx_nan2); 
            total_mat(j,i,k)=numel(over_nan); 
            per_mat(j,i,k)=numel(over)/numel(over_nan)*100; 
        end 
    end 
end 

%make one across 2003-2013
count_mat_all=zeros(z,z); 
total_mat_all=zeros(z,z); 
for k=2:r
    for j=1:z
        for i=1:z
            count_mat_all(j,i)=count_mat_all(j,i)+count_mat(j,i,k); 
            total_mat_all(j,i)=total_mat_all(j,i)+total_mat(j,i,k); 
        end 
    end 
end 
per_mat_all=count_mat_all./total_mat_all*100; 
%round
per_mat_all=per_mat_all*10; 
per_mat_all=round(per_mat_all); 
per_mat_all=per_mat_all/10; 
cd ..
cd programs
cd suicide
M=50; 
heatmap_rb(per_mat_all, Q_lab, Q_lab, 1, M, 0, 'Colormap','money', 'UseLogColormap', false, 'ShowAllTicks',true, 'Colorbar',true,'TextColor','k', 'FontSize', 12); 
saveas (gcf, 'mental_health_overlap_all.fig' ); %can make pdf, jnp, or jpg 
print (gcf, '-dpdf',  'mental_health_overlap_all');       
close