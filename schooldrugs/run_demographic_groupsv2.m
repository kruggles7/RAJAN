
% ques1= {'Q18'; 'Q23'; 'Q56'};
% ques2= {'Q20'; 'Q24'; 'Q57'}; 
% label= {'alcohol', 'marijuana', 'cigarettes'}; 
% files=dir(fullfile('C:','Users','kruggles7','Documents','MATLAB', 'Rajan', 'heatmaps_final','NaN_files', '*.txt'));
% final_mat=zeros(3, 15, 6); 
% for i=1:numel(ques1); 
%     cd ..
%     cd ..
%     cd data
%     cd results_020314
%     cd NaN
%     question_mat1=importdata([ques1{i} '--NaN.txt'], '\t');
%     question_mat2=importdata([ques2{i} '--NaN.txt'], '\t'); 
%     cd ..
%     cd ..
%     cd ..
%     cd programs
%     cd schooldrugs
%     [ permat1, permat2, ratio_mat ] = plot_demographic_graphs ( question_mat1, question_mat2, label{i} );
%     final_mat(i,:,:)=ratio_mat; 
% end

label_year={'2001', '2003','2005','2007','2009','2011'}; 
label_cell2={'Total', 'Boys', 'Girls', 'W', 'B', 'H', 'O', 'W Boys', 'W Girls', 'B Boys', 'B Girls', 'H Boys', 'H Girls', 'O Boys', 'O Girls'}; 
x=2001:2:2011; 
colors={'g', 'm', 'b'}; 
markers={'o', '*', 's'}; 
count=1; 
for i=1:15
    for j=1:3
        f2=subplot(30,count:count+1,1); 
        y=final_mat(j,i,:); 
        y=reshape(y,1,6); 
        plot(x, y, 'Color', colors{j}, 'Marker', markers{j}, 'MarkerFaceColor', colors{j}, 'MarkerSize', 2);
        hold on 
    end 
    hold off 
    ylabel([label_cell2{i}]); 
    set(f2, 'xTick', x); 
    ylim ([0 1]); 
    if i<15
        %set(f2, 'xTick', []); 
        %set(f2, 'yTick', []); 
        set(f2,'xTickLabel',[]);
    else 
        %set(f2, 'yTick', []); 
        set(f2, 'xTickLabel', label_year); 
    end 
    if i>1 %move the plot upward
        pos1=get(f1,'Position'); 
        pos2=get(f2,'Position'); 
        %set heights equal
        pos2(4)=pos1(4); 
        set (f2, 'Position', pos2); 
        %set x of first equal to second 
        pos1(2)=pos2(2); 
        set(f1, 'Position', pos1); 
        %move the second to touch first
        pos2(1)= pos1(1) - pos2(3); %was pos1(3)
        set (f2, 'Position', pos2); 
    end 
    f1=f2;  
    count=count+2; 
end 
saveas (gcf, ['school_drug_ratio.fig']); 
print (gcf, '-dpng', ['school_drug_ratio.png']); 
close all