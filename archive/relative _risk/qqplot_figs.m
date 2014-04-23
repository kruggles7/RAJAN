function [ ] = qqplot_figs( mat, label )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[r,c]=size(mat); 
for i=1:r
    temp=mat(i,:); 
    qqplot(temp); 
    i_char=num2str(i); 
    print (gcf, '-dpng', [label '_' i_char '_qqplot.png']); 
    close 
end
