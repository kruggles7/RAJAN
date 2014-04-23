%make heatmaps out of the relative risk matrix 
load q_labels_010414.mat
cd controls 
sex=importdata('sex-NaN.txt', '\t');
cd ..
xlab={'2009', '2011'}; 
files=dir(fullfile('C:','Users','kruggles7','Documents','MATLAB', 'Rajan', 'raw_OR_plot','NaN_results_010314', '*.txt'));
N=length(files);

purple_grey=[99/255 86/255 136/255];
light_purple=[106/255 90/255 205/255];
green_blue=[67/255 205/255 128/255];
green=[0/255 205/255 102/255];
orange=[255/255 127/255 0/255];
blue=[24/255 116/255 205/255];
salmon=[205/255 51/255 51/255];
mauve=[205/255 96/255 144/255];
magenta=[205/255 41/255 144/255]; 
grey1=[192/255 192/255 192/255]; 
grey2=[97/255 97/255 97/255]; 

ques1='Q79'; 
ques2={'Q55' 'Q62' 'Q23' 'Q26' 'Q27' 'Q29' 'Q32'}; 
q1=ques1; 
plot_mat=double.empty; 
qlabel1=ques1; 
qlabel2=cell.empty; 
for i=1:numel(ques2)
    q2=ques2{i}; 
    qlabel2{i,1}=ques2{i}; 
    for k=1:N
        x=strfind(files(k).name,q1); 
        y=strfind(files(k).name,q2); 
        cd NaN_results_010314
        if numel(x)>0
            qmat1=importdata(files(k).name, '\t');
        elseif numel(y)>0
            qmat2=importdata(files(k).name, '\t'); 
        end 
        cd ..
    end 
    [r2,c2]=size(qmat2); 
    qmat2=qmat2(5:6,:); 
    [r,col]=size(qmat1); 
    for k=1:r
        index_yes1{k}=find(qmat1(k,:)==1);
        index_yes2{k}=find(qmat2(k,:)==1);
        index_no1{k}=find(qmat1(k,:)==0); 
        index_no2{k}=find(qmat2(k,:)==0); 
        index_nomiss1{k}=find(qmat1(k,:)==0 | qmat1(k,:)==1); %answers that were NOT missing (ie. 0's and 1's / no's and yes's)
        index_nomiss2{k}=find(qmat2(k,:)==0 | qmat2(k,:)==1);
    end
    for k=1:r
        index_yes_both{k}=intersect(index_yes1{k},index_yes2{k}); 
        index_no_both{k}=intersect(index_no1{k}, index_no2{k}); 
        index_yes1_no2{k}=intersect(index_yes1{k},index_no2{k}); 
        index_yes2_no1{k}=intersect(index_yes2{k},index_no1{k}); 
    end

    for k=1:r
        total_yes_both(k)=length(index_yes_both{k}); 
        total_no_both(k)=length(index_no_both{k}); 
        total_yes1_no2(k)=length(index_yes1_no2{k}); 
        total_yes2_no1(k)=length(index_yes2_no1{k}); 
    end
    for k=1:r
        a(k)=total_yes_both(k); 
        d(k)=total_no_both(k); 
        c(k)=total_yes1_no2(k); 
        b(k)=total_yes2_no1(k); 
        P1(k)=a(k)/(a(k)+b(k)); 
        P2(k)=c(k)/(c(k)+d(k)); 
    end 
    for k=1:r
        plot_mat(i, k)= ( P1(k)/(1-P1(k)) ) / ( P2(k)/(1-P2(k)) );
    end
end 
%make heatmap table
label_year={'2009','2011'}; 
per_mat_map=plot_mat;
max_mat=max(max(per_mat_map)); 
if max_mat>75
    M=100; 
elseif max_mat>50
    M=75; 
elseif max_mat>25
    M=50; 
else 
    M=25; 
end 
%get rid of deimals
per_mat_map=per_mat_map*10; 
per_mat_map=round(per_mat_map); 
per_mat_map=per_mat_map/10; 
for t=1:numel(ques2)
    indxt=find(strcmp(ques2{t},qlabel(:,2))==1); 
    table_lable{t}=qlabel{indxt,1};
end 
h=figure; 
[hImage]=heatmap_rb(per_mat_map, label_year, table_lable, 1, M, 0, 'Colormap','money', 'UseLogColormap', false, 'ShowAllTicks',true, 'Colorbar',true,'TextColor','k', 'FontSize', 12); 
%title (title1, 'FontSize', 12); 
set (gca, 'FontSize',12); 
%title(tabel_label); 
print (gcf,'-dpng', [ q1 '_OR_heatmap.png'] ); %can make pdf, jnp, or jpg 
