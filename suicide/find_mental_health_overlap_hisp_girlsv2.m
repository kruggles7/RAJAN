
%This one differs from version 1 in that version 1 looked at the proportion
%of total participants who answered yes to both questions.  This one looks
%at of those answering yes to question 1, what percent also answered yes to
%question 2. 

R=3;
G=1;
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
%weight=importdata('weight-NaN.txt', '\t'); 
cd ..
Q={'Q11', 'Q12', 'Q13', 'Q16', 'Q14'}; 
Q_lab={'Felt sad or hopeless', 'Considered suicide', 'Made a plan to commit suicide','Attempted Suicide', 'Injured from suicide attempt' }; 

%files1=dir(fullfile('/ifs/data/proteomics/projects/cdc/matlab/results_053015/NaN/', '*.txt')); 
files1=dir(fullfile('C:/Users/rugglk01/Dropbox (Personal)/CDC/data/results_053015/NaN/', '*.txt')); 

[r,c]=size(race); 
race=race(:,2:c); 
sex=sex(:,2:c); 

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
    indx_final=find(race(k,:)== R & sex(k,:)==G );
    for j=1:z
        mat1=QUEST_MAT(k,2:c,j); 
        indx1=find(mat1==1); 
        indx_nan1=find(isnan(mat1)==0 & mat1<9); 
        indx1_=intersect(indx1, indx_final); 
        indx_nan1_=intersect(indx_nan1, indx_final); 
        for i=1:z
            mat2=QUEST_MAT(k,2:c,i); 
            indx2=find(mat2==1); 
            indx_nan2=find(isnan(mat2)==0 & mat2<9); 
            indx2_=intersect(indx2, indx_final); 
            indx_nan2_=intersect(indx_nan2, indx_final); 
            over=intersect(indx1_,indx2_); 
            count_mat(j,i,k)=numel(over); 
            over_nan=intersect(indx_nan1_, indx_nan2_); 
            total_mat(j,i,k)=numel(indx1_); 
            per_mat(j,i,k)=numel(over)/numel(indx1_)*100; 
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
per_mat_all_hisp=count_mat_all./total_mat_all*100; 
%round
per_mat_all_hisp=per_mat_all_hisp*10; 
per_mat_all_hisp=round(per_mat_all_hisp); 
per_mat_all_hisp=per_mat_all_hisp/10; 
cd ..
cd programs
cd suicide
M=100; 
heatmap_rb(per_mat_all_hisp, Q_lab, Q_lab, 1, M, 0, 'Colormap','money', 'UseLogColormap', false, 'ShowAllTicks',true, 'Colorbar',true,'TextColor','k', 'FontSize', 12); 
saveas (gcf, 'mental_health_overlap_hisp_girlsv2.fig' ); %can make pdf, jnp, or jpg 
print (gcf, '-dpdf',  'mental_health_overlap_hisp_girlsv2'); 
close