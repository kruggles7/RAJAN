mat2001=log_rel_risk(:,1); 
mat2011=log_rel_risk(:,6); 
delta=mat2011-mat2001; 
delta=delta/mat2001; 
d=delta(:,1)*100; 
indxu=find(d>15); 
indxd=find(d<-15); 
n=1; 


dull_blue=[24/255 116/255 205/255];
dull_green=[46/255 139/255 87/255];
orange=[255/255 127/255 0/255];
mauve=[205/255 96/255 144/255];
purple=[153/255 50/255 205/255];
brick=[165/255 42/255 42/255];
dark_green=[0/255 100/255 0/255]; 

%make sorted_trend_q1 in excel by sorting the net % chagne 2001-2011 and
%sorting by question
bar_y=cell2mat(sorted_trend_q2(:,2)); 
indxu=find(bar_y>15);
indxd=find(bar_y<-15); 
bar_color=zeros(length(bar_y),1); 
bar_color(indxu)=1; 
bar_color(indxd)=-1; 


bh=bar(bar_y); 
ch=get(bh,'Children');  
set (ch,'CData',bar_color) ; 
colormap(winter); 
hold on
x=[0 length(sorted_trend_q2(:,2))+1];
y=[15 15];
y2=[-15 -15]; 
plot(x, y, '--k'); 
plot(x, y2, '--k'); 
%set (gca, 'XTickLabel',sorted_trend_q1(:,1)); 
set (gca, 'XTickLabel',[]); 
set (gca, 'XTick',[]); 
xlim([0 length(sorted_trend_q2(:,2))+1])
ylim([-35 35]); 
%rotateXLabels(45); 

