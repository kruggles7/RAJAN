cd .. 
cd odds_ratios
cd OR_2014_11_04_2decimals
load OR_2013_WHITE_BOYS_Q79_CAT2.mat
load OR_CI_2013_WHITE_BOYS_Q79_CAT2.mat
OR_boys=odds_ratio_cell;
OR_CI_boys=OR_CI; 
load OR_2013_WHITE_GIRLS_Q79_CAT2.mat
load OR_CI_2013_WHITE_GIRLS_Q79_CAT2.mat
OR_girls=odds_ratio_cell;
OR_CI_girls=OR_CI; 
cd .. 
cd ..
cd ..
cd matrices
load qlabel_090914
cd .. 
cd programs
cd sun

%BOYS
plot_mat=OR_boys(:,7:9);
CI_mat=OR_CI_boys(:,7:9); 
[r,c]=size(plot_mat); 
table_OR_boys=cell(r+1,c+1); 
q2=OR_boys(:,2);
for j=1:numel(q2)
    indx2=find(strcmp(q2{j},qlabel(:,2))==1); 
    if numel(indx2)>0
        table_OR_boys{j+1,1}=qlabel{indx2,1}; 
    end 
end 
x={'2009' '2011' '2013'}; 
table_OR_boys(1,2:c+1)=x; 
for j=1:r
    for k=1:c
        %check for empty 
        i=cellfun(@isempty,plot_mat(j,k)); 
        if i==0
            n_round=plot_mat{j,k}; 
            n_round=sprintf('%0.2f',round(n_round*100)/100);
            table_OR_boys{j+1,k+1}=[n_round ' (' num2str(CI_mat{j,k}) ')']; 
        end 
    end 
end  

%GIRLS
plot_mat=OR_girls(:,7:9);
CI_mat=OR_CI_girls(:,7:9); 
[r,c]=size(plot_mat); 
table_OR_girls=cell(r+1,c+1); 
q2=OR_girls(:,2);
for j=1:numel(q2)
    indx2=find(strcmp(q2{j},qlabel(:,2))==1); 
    if numel(indx2)>0
        table_OR_girls{j+1,1}=qlabel{indx2,1}; 
    end 
end 
x={'2009' '2011' '2013'}; 
table_OR_girls(1,2:c+1)=x; 
for j=1:r
    for k=1:c
        %check for empty 
        i=cellfun(@isempty,plot_mat(j,k)); 
        if i==0
            n_round=plot_mat{j,k}; 
            n_round=sprintf('%0.2f',round(n_round*100)/100);
            table_OR_girls{j+1,k+1}=[n_round ' (' num2str(CI_mat{j,k}) ')']; 
        end 
    end 
end  