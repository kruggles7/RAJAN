
%White Girls only 
R=1;
G=1;
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
cd ..
[r,c]=size(sex); 
%files1=dir(fullfile('/ifs/data/proteomics/projects/cdc/matlab/results_053015/NaN/', '*.txt')); 
%files1=dir(fullfile('C:/Users/rugglk01/Dropbox (Personal)/CDC/data/results_053015/NaN/', '*.txt')); 
files1=dir(fullfile('C:/Users/kruggles7/Dropbox (Personal)/CDC/data/results_053015/NaN/', '*.txt')); 

%files2=dir(fullfile('C:/Users/rugglk01/Dropbox (Personal)/CDC/data/results_053015/cat/', '*.txt')); 
files2=dir(fullfile('C:/Users/kruggles7/Dropbox (Personal)/CDC/data/results_053015/cat/', '*.txt')); 
Q='Q78'; %how many times have you gone indoor tanning? 

n_count=0; 

[r,c]=size(sex); 
temp=zeros(r,c,2); 
for i=1:r
    indx=find(isnan(sex(i,:))==1);
    temp(i,indx,1)=NaN; 
    temp(i,indx,2)=NaN; 
end 
count_mat(:,:,1)=temp(:,2:c,1); %remove the year column 
count_mat(:,:,2)=temp(:,2:c,2); 

N=length(files1);

for J=1:N 
    cd results_053015
    cd cat
    quest_1=importdata(files2(J).name, '\t');
    cd ..
    cd ..
    
    filename1='';
    a=char(files2(J).name);
    b=strfind(a,'-');
    for p=1:(b(1)-1)
        c=a(p);
        filename1=[filename1 c];
    end        
    indx=find(strcmp(filename1, Q)==1); 
    
    if numel(indx)>0
        %get rid of the '0s' associated with the other subset of participants
        [r,c]=size(quest_1); 
        count_mat_final=nan(r,c-1,2); 
        for i=1:r
            indx_yes=find(quest_1(i,2:c)>=5); 
            indx_no=find(quest_1(i,2:c)<5); 
%             indx_miss=find(quest_1(i,2:c)==0); 
%             count_mat_final(i , :, :)=count_mat(i+4, : , :); 
%             count_mat_final(i, indx_miss, 1)=NaN; 
%             count_mat_final(i, indx_miss, 2)=NaN; 
%             count_mat_final(i, indx_no, 1)=NaN; 
%             count_mat_final(i, indx_yes, 2)=NaN; 
        end 
        for j=1:N
            cd results_053015
            cd NaN
            quest_2=importdata(files1(j).name, '\t');
            cd ..
            cd ..
            filename2='';
            a=char(files1(j).name);
            b=strfind(a,'-');
            for p=1:(b(1)-1)
                c=a(p);
                filename2=[filename2 c];
            end
            ct=[]; 
            for q=2:(b(1)-1)
                c1=a(q) ;
                if c1~=0
                    ct=[ct c1]; 
                end  
            end 
            ct=str2num(ct);
            q2_RC=reverse_code(ct,1); 

            %PROCESS THE COMBO 
            if (isnan(q2_RC)==0) 
                n_count=n_count+1; 
                [r1,c1]=size(quest_1);
                [r2,c2]=size(quest_2) ;
                [r3,c3]=size(sex); 
                year=[2001 2003 2005 2007 2009 2011 2013]; 
                if j==1
                    year1=quest_1(:,1); 
                    year3=sex(:,1); 
                    quest_1=quest_1(:,2:c1); 
                    sex=sex(:,2:c3); 
                    race=race(:,2:c3); 
                end 
                year2=quest_2(:,1); 
                quest_2=quest_2(:,2:c2); 
                year_final=double.empty; 
                quest_1F=double.empty; 
                quest_2F=double.empty; 
                sex_=double.empty; 
                race_=double.empty; 
                counter=1; 
                s=0; %start for 1
                e=1; %start for 2
                for ii=1:numel(year)
                    y=year(ii); 
                    indx1=find(year1==y); 
                    indx2=find(year2==y); 
                    indx3=find(year3==y); 
                    if numel(indx1)>0 && numel(indx2)>0 %both in the matrix
                        year_final(counter,1)=y; 
                        quest_1F(counter,:)=quest_1(indx1,:); 
                        quest_2F(counter,:)=quest_2(indx2,:); 
                        sex_(counter,:)=sex(indx3,:); 
                        race_(counter,:)=race(indx3,:); 
                        e=ii; 
                        if (counter==1)
                            s=ii; 
                        end 
                        counter=counter+1; 
                    end 
                end 
                K=s+2; 
                [r_,c]=size(quest_1F); 
                for i=1:r_
                    %Q1:
                    index_final{i}=find(race_(i,:)== R & sex_(i,:)==G );
                    index_yes{i}=find(quest_1F(i,:)>=5); %students who answered yes to Q1
                    index_no{i}=find(quest_1F(i,:)<5 & quest_1F(i,:)>0); %students who answered no to Q1
                    index_yes_1{i}=intersect(index_yes{i},index_final{i});
                    index_no_1{i}=intersect(index_no{i},index_final{i});
                    index_miss{i}=find(quest_1F(i,:)==0 ); %students who didn't answer Q1
                    index_miss_1{i}=intersect(index_miss{i}, index_final{i}); 
                    if (j==1)
                        count_mat_final(i,index_yes_1{i},1)=0; 
                        count_mat_final(i, index_no_1{i},2)=0; 
                    end 
                    %Q2:
                    if q2_RC==1
                        index_no{i}=find(quest_2F(i,:)==1);
                        index_yes{i}=find(quest_2F(i,:)==0);
                        index_yes_2{i}=intersect(index_yes{i},index_final{i});
                        index_no_2{i}=intersect(index_no{i},index_final{i});
                        index_miss{i}=find(quest_2F(i,:)==9);
                        index_miss_2{i}=intersect(index_miss{i}, index_final{i}); 
                    else 
                        index_yes{i}=find(quest_2F(i,:)==1);
                        index_no{i}=find(quest_2F(i,:)==0);
                        index_yes_2{i}=intersect(index_yes{i},index_final{i});
                        index_no_2{i}=intersect(index_no{i},index_final{i});
                        index_miss{i}=find(quest_2F(i,:)==9);
                        index_miss_2{i}=intersect(index_miss{i}, index_final{i}); 
                    end 

                    index_yes_both{i}=intersect(index_yes_1{i}, index_yes_2{i});  %students who said yes to both Qs
                    index_no1_yes2{i}=intersect(index_no_1{i}, index_yes_2{i});  %students who said no to Q1 and yes to Q2

                    count_mat_final(i, index_yes_both{i}, 1)=count_mat_final(i, index_yes_both{i}, 1) + 1; 
                    count_mat_final(i, index_no1_yes2{i}, 2)=count_mat_final(i, index_no1_yes2{i}, 2) + 1; 

                end 
            end	
        end 
    end 
end 

cat1=cat(2, count_mat_final(1,:,1), count_mat_final(2,:,1));
cat1=cat(2, cat1, count_mat_final(3,:,1)); 

cat2=cat(2, count_mat_final(1,:,2), count_mat_final(2,:,2));
cat2=cat(2, cat2, count_mat_final(3,:,2)); 
cat_(:,1)=cat1; 
cat_(:,2)=cat2; 
[p, an]=anova1(cat_); 

cat_2=fliplr(cat_); 
n1=numel(find(isnan(cat_2(:,1))==0)); 
n2=numel(find(isnan(cat_2(:,2))==0)); 
boxplot(cat_2); 
set(gca, 'xticklabel', {['Indoor tanning never or <20 times per year (N=' num2str(n1) ')'], ['Indoor tanning 20+ times per year (N=' num2str(n2) ')']}); 
ylabel('Number of risk behaviors each subject has participated in'); 
title ('During the past 12 months, how many times did you use an indoor tanning device?'); 


cd ..
cd matrices
save('risk_counts_WHITE_GIRLS_tanning20', 'count_mat'); 


indx1=find(isnan(cat_2(:,1))==0); 
indx2=find(isnan(cat_2(:,2))==0); 

N1=cat_2(indx1,1); 
N2=cat_2(indx2,2); 
