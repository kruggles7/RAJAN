cd .. 
cd .. 
cd matrices
load qlabel_090914
cd .. 
cd programs
cd odds_ratios
cd OR_2014_11_04_2decimals
error=0; 
demograph=input('Enter in the demographic you want to look at (all, girls, boys, white, black or hispanic): ', 's'); 
if strcmp(demograph,'all')==1
    load OR_2013
    load OR_CI_2013
elseif strcmp(demograph, 'girls')==1
    load OR_2013_girls
    load OR_CI_2013_girls
elseif strcmp(demograph, 'boys')==1
    load OR_2013_boys
    load OR_CI_2013_boys
elseif strcmp(demograph, 'white')==1
    load OR_2013_WHITE
    load OR_CI_2013_WHITE
elseif strcmp(demograph, 'black')==1
    load OR_2013_BLACK
    load OR_CI_2013_BLACK
elseif strcmp(demograph, 'hispanic')==1
    load OR_2013_HISPANIC
    load OR_CI_2013_HISPANIC
else 
    error=1;
end
cd ..

if (error==0)
    ques=input ('Enter in the question number you want to use (ex. Q01): ', 's'); 

    indx=find (strcmp(odds_ratio_cell(:,1),ques)==1); 
    if isempty(indx)==0
        plot_mat=odds_ratio_cell(indx,3:9);
        CI_mat=OR_CI(indx,3:9); 
        [r,c]=size(plot_mat); 
        table_OR=cell(r+1,c+1); 
        q2=odds_ratio_cell(indx,2);
        for j=1:numel(q2)
            indx2=find(strcmp(q2{j},qlabel(:,2))==1); 
            if numel(indx2)>0
                table_OR{j+1,1}=qlabel{indx2,1}; 
            end 
        end 
        x={'2001' '2003' '2005' '2007' '2009' '2011' '2013'}; 
        table_OR(1,2:c+1)=x; 
        for j=1:r
            for k=1:c
                %check for empty 
                i=cellfun(@isempty,plot_mat(j,k)); 
                if i==0
                    n_round=plot_mat{j,k}; 
                    n_round=sprintf('%0.2f',round(n_round*100)/100);
                    table_OR{j+1,k+1}=[n_round ' (' num2str(CI_mat{j,k}) ')']; 
                end 
            end 
        end 
    end 
end 
