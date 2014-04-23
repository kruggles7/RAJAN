files=dir(fullfile('C:','Users','kruggles7','Documents','MATLAB', 'Rajan', 'results_020314', 'NaN', '*.txt'));
% reads all the text files in the folder 'binary_NaN_files' and saves them in an array called files
% make sure that folder contains only the NaN files for the questions you want to run create_hm_graph for
N=length(files);
cd .. 
cd results_020314
cd NaN
for i=1:N
	filename='';
	a=char(files(i).name);
	b=strfind(a,'-');
	for p=1:(b(1)-1)
		c=a(p);
		filename=[filename c];
    end
    filename
    if (strcmp(filename,'Q74')==1)
         p_mat=cell(16,6);
        t_mat=cell(16,6); 
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
        t_mat(:,1)=p_mat(:,1); 
        question_mat=importdata(files(i).name, '\t');
        cd .. 
        cd ..
        cd controls
        sex=importdata('sex-NaN.txt', '\t');
        race=importdata('race-NaN.txt', '\t'); 
        weight=importdata('weight.txt','\t'); 
        cd ..
        cd statistics

        [r,c]=size(question_mat); 
        indx=find(question_mat==9); 
        question_mat(indx)=NaN; 

        [r,c]=size(question_mat); 
        c_new=c-1; 
        stat_mat=nan(c_new*6,6); 
        stat_mat(1:c_new,1)=question_mat(1,2:c); 
        stat_mat(1:c_new,2)=2009; 
        stat_mat(1:c_new,3)=sex(1,2:c); 
        stat_mat(1:c_new,4)=race(1,2:c); 
        stat_mat(1:c_new,5)=weight(1,2:c); 

        stat_mat(c_new+1:c_new*2,1)=question_mat(2,2:c); 
        stat_mat(c_new+1:c_new*2,2)=2011; 
        stat_mat(c_new+1:c_new*2,3)=sex(2,2:c); 
        stat_mat(c_new+1:c_new*2,4)=race(2,2:c);
        stat_mat(c_new+1:c_new*2,5)=weight(2,2:c); 

        indx_nan=find(isnan(stat_mat(:,1))==0 & isnan(stat_mat(:,5))==0); 
        stat_mat2=stat_mat(indx_nan, :); 
        [r,c]=size(stat_mat2); 

        for t=1:r
            stat_mat2(t,6)=stat_mat2(t,1)*stat_mat2(t,5); 
        end 

        years=[2009 2011]; 
        count=2; 
        y=2; 
        for j=1
            year=years(j); 
            for k=2
                year2=years(k); 
                p_mat{1,y}=[num2str(year) '-' num2str(year2)];
                t_mat{1,y}=p_mat{1,y}; 
                indx1=find(stat_mat2(:,2)==year & isnan(stat_mat2(:,6))==0); 
                indx2=find(stat_mat2(:,2)==year2 & isnan(stat_mat2(:,6))==0); 
                m=max(numel(indx1),numel(indx2)); 
                X=nan(m,1); 
                Y=nan(m,1);
                X(1:numel(indx1),1)=stat_mat2(indx1,6); 
                Y(1:numel(indx2),1)=stat_mat2(indx2,6); 
                %[t, chi2, p]=crosstab(X,Y); 
                [h,p,c, STAT]=ttest(X,Y); 
                tstat_=STAT.tstat;
                t_mat{2,count}=tstat_; 
                p_mat{2,count}=p; 

                index_boys=find(stat_mat2(:,3)==2);
                indx1b=intersect(indx1,index_boys); 
                indx2b=intersect(indx2,index_boys); 
                m=max(numel(indx1b),numel(indx2b)); 
                X=nan(m,1); 
                Y=nan(m,1);
                X(1:numel(indx1b),1)=stat_mat2(indx1b,6); 
                Y(1:numel(indx2b),1)=stat_mat2(indx2b,6); 
                [h,p,c, STAT]=ttest(X,Y); 
                tstat_=STAT.tstat;
                t_mat{3,count}=tstat_;  
                p_mat{3,count}=p; 

                index_girls=find(stat_mat2(:,3)==1);
                indx1g=intersect(indx1,index_girls); 
                indx2g=intersect(indx2,index_girls); 
                m=max(numel(indx1g),numel(indx2g)); 
                X=nan(m,1); 
                Y=nan(m,1);
                X(1:numel(indx1g),1)=stat_mat2(indx1g,6); 
                Y(1:numel(indx2g),1)=stat_mat2(indx2g,6);  
                [h,p,c, STAT]=ttest(X,Y); 
                tstat_=STAT.tstat;
                t_mat{4,count}=tstat_; 
                p_mat{4,count}=p; 

                index_W=find(stat_mat2(:,4)==1);
                indx1W=intersect(indx1,index_W); 
                indx2W=intersect(indx2,index_W); 
                m=max(numel(indx1W),numel(indx2W)); 
                X=nan(m,1); 
                Y=nan(m,1);
                X(1:numel(indx1W),1)=stat_mat2(indx1W,6); 
                Y(1:numel(indx2W),1)=stat_mat2(indx2W,6);  
                [h,p,c, STAT]=ttest(X,Y); 
                tstat_=STAT.tstat;
                t_mat{5,count}=tstat_; 
                p_mat{5,count}=p;

                index_B=find(stat_mat2(:,4)==2);
                indx1B=intersect(indx1,index_B); 
                indx2B=intersect(indx2,index_B); 
                m=max(numel(indx1B),numel(indx2B)); 
                X=nan(m,1); 
                Y=nan(m,1); 
                X(1:numel(indx1B),1)=stat_mat2(indx1B,6);
                Y(1:numel(indx2B),1)=stat_mat2(indx2B,6);
                [h,p,c, STAT]=ttest(X,Y); 
                tstat_=STAT.tstat;
                t_mat{6,count}=tstat_;  
                p_mat{6,count}=p; 

                index_H=find(stat_mat2(:,4)==3);
                indx1H=intersect(indx1,index_H); 
                indx2H=intersect(indx2,index_H); 
                m=max(numel(indx1H),numel(indx2H)); 
                X=nan(m,1); 
                Y=nan(m,1);
                X(1:numel(indx1H),1)=stat_mat2(indx1H,6);
                Y(1:numel(indx2H),1)=stat_mat2(indx2H,6); 
                %[t, chi2, p]=crosstab(X,Y);            
                [h,p,c, STAT]=ttest(X,Y); 
                tstat_=STAT.tstat;
                t_mat{7,count}=tstat_; 
                p_mat{7,count}=p;

                index_O=find(stat_mat2(:,4)==4);
                indx1O=intersect(indx1,index_O); 
                indx2O=intersect(indx2,index_O); 
                m=max(numel(indx1O),numel(indx2O)); 
                X=nan(m,1);
                Y=nan(m,1);
                X(1:numel(indx1O),1)=stat_mat2(indx1O,6);
                Y(1:numel(indx2O),1)=stat_mat2(indx2O,6);
                [h,p,c, STAT]=ttest(X,Y); 
                tstat_=STAT.tstat;
                t_mat{8,count}=tstat_; 
                p_mat{8,count}=p;

                index_WG=intersect(index_girls,index_W); 
                indx1WG=intersect(indx1,index_WG); 
                indx2WG=intersect(indx2,index_WG); 
                m=max(numel(indx1WG),numel(indx2WG)); 
                X=nan(m,1); 
                Y=nan(m,1);
                X(1:numel(indx1WG),1)=stat_mat2(indx1WG,6);
                Y(1:numel(indx2WG),1)=stat_mat2(indx2WG,6);
                [h,p,c, STAT]=ttest(X,Y); 
                tstat_=STAT.tstat;
                t_mat{9,count}=tstat_; 
                p_mat{9,count}=p;

                index_BG=intersect(index_girls,index_B); 
                indx1BG=intersect(indx1,index_BG); 
                indx2BG=intersect(indx2,index_BG); 
                m=max(numel(indx1BG),numel(indx2BG)); 
                X=nan(m,1); 
                Y=nan(m,1);
                X(1:numel(indx1BG),1)=stat_mat2(indx1BG,6);
                Y(1:numel(indx2BG),1)=stat_mat2(indx2BG,6); 
                [h,p,c, STAT]=ttest(X,Y); 
                tstat_=STAT.tstat;
                t_mat{10,count}=tstat_; 
                p_mat{10,count}=p;

                index_HG=intersect(index_girls,index_H);  
                indx1HG=intersect(indx1,index_HG); 
                indx2HG=intersect(indx2,index_HG); 
                m=max(numel(indx1HG),numel(indx2HG)); 
                X=nan(m,1); 
                Y=nan(m,1);
                X(1:numel(indx1HG),1)=stat_mat2(indx1HG,6);
                Y(1:numel(indx2HG),1)=stat_mat2(indx2HG,6);
                [h,p,c, STAT]=ttest(X,Y); 
                tstat_=STAT.tstat;
                t_mat{11,count}=tstat_; 
                p_mat{11,count}=p;

                index_OG=intersect(index_girls,index_O);  
                indx1OG=intersect(indx1,index_OG); 
                indx2OG=intersect(indx2,index_OG); 
                m=max(numel(indx1OG),numel(indx2OG)); 
                X=nan(m,1); 
                Y=nan(m,1);
                X(1:numel(indx1OG),1)=stat_mat2(indx1OG,6);
                Y(1:numel(indx2OG),1)=stat_mat2(indx2OG,6);
                [h,p,c, STAT]=ttest(X,Y); 
                tstat_=STAT.tstat;
                t_mat{12,count}=tstat_; 
                p_mat{12,count}=p;

                index_WB=intersect(index_boys,index_W);  
                indx1WB=intersect(indx1,index_WB); 
                indx2WB=intersect(indx2,index_WB); 
                m=max(numel(indx1WB),numel(indx2WB)); 
                X=nan(m,1); 
                Y=nan(m,1);
                X(1:numel(indx1WB),1)=stat_mat2(indx1WB,6);
                Y(1:numel(indx2WB),1)=stat_mat2(indx2WB,6);
                [h,p,c, STAT]=ttest(X,Y); 
                tstat_=STAT.tstat;
                t_mat{13,count}=tstat_;  
                p_mat{13,count}=p;

                index_BB=intersect(index_boys,index_B); 
                indx1BB=intersect(indx1,index_BB); 
                indx2BB=intersect(indx2,index_BB); 
                m=max(numel(indx1BB),numel(indx2BB)); 
                X=nan(m,1); 
                Y=nan(m,1);
                X(1:numel(indx1BB),1)=stat_mat2(indx1BB,6);
                Y(1:numel(indx2BB),1)=stat_mat2(indx2BB,6);
                [h,p,c, STAT]=ttest(X,Y); 
                tstat_=STAT.tstat;
                t_mat{14,count}=tstat_; 
                p_mat{14,count}=p;

                index_HB=intersect(index_boys,index_H); 
                indx1HB=intersect(indx1,index_HB); 
                indx2HB=intersect(indx2,index_HB); 
                m=max(numel(indx1HB),numel(indx2HB)); 
                X=nan(m,1); 
                Y=nan(m,1);
                X(1:numel(indx1HB),1)=stat_mat2(indx1HB,6);
                Y(1:numel(indx2HB),1)=stat_mat2(indx2HB,6);
                [h,p,c, STAT]=ttest(X,Y); 
                tstat_=STAT.tstat;
                t_mat{15,count}=tstat_; 
                p_mat{15,count}=p;

                index_OB=intersect(index_boys,index_O);  
                indx1OB=intersect(indx1,index_OB); 
                indx2OB=intersect(indx2,index_OB); 
                m=max(numel(indx1OB),numel(indx2OB)); 
                X=nan(m,1); 
                Y=nan(m,1);
                X(1:numel(indx1OB),1)=stat_mat2(indx1OB,6);
                Y(1:numel(indx2OB),1)=stat_mat2(indx2OB,6);
                [h,p,c, STAT]=ttest(X,Y); 
                tstat_=STAT.tstat;
                t_mat{16,count}=tstat_; 
                p_mat{16,count}=p;
                count=count+1; 
                y=y+1; 
            end
        end 
    end 
end 

