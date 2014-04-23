%TREND BASED ON RAW

mat2001=plot_mat2(6,:); 
mat2011=plot_mat2(1,:); 
delta=mat2011-mat2001;
for i=1:55
    delta2(1,i)=delta(1,i)/mat2001(1,i);
end 
indx=find(isinf(delta2)==1); 
delta2(indx)=0; 
d=delta2(1,:)*100; 
indxu1=find(d>75); 
indxd1=find(d<-75); 
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
cd matrices
load sorted_trend_q2_raw
bar_y=cell2mat(sorted_trend_q2_raw(:,2)); 
indxu=find(bar_y>75);
indxd=find(bar_y<-75); 
bar_color=zeros(length(bar_y),1); 
bar_color(indxu)=1; 
bar_color(indxd)=-1; 


bh=bar(bar_y); 
ch=get(bh,'Children');  
set (ch,'CData',bar_color) ; 
colormap(winter); 
hold on
x=[0 length(sorted_trend_q2_raw(:,2))+1];
y=[75 75];
y2=[-75 -75]; 
plot(x, y, '--k'); 
plot(x, y2, '--k'); 
%set (gca, 'XTickLabel',sorted_trend_q1(:,1)); 
set (gca, 'XTickLabel',[]); 
set (gca, 'XTick',[]); 
xlim([0 length(sorted_trend_q2_raw(:,2))+1])
ylim([-175 175]); 
%rotateXLabels(45); 

%rows which have >75% in the d are going to be the ones we highlight 
x=[2001; 2003; 2005; 2007; 2009; 2011]; 
for i=1:length(indxu1); 
    in=indxu1(i); 
    P(i,:)=plot_mat2(:,in); 
end 

P=fliplr(P); 

plot(x,P(1,:), '--ks', 'MarkerFaceColor', 'k'); 
hold on
plot(x,P(2,:),':kd', 'MarkerFaceColor', 'k'); 
plot(x,P(3,:), '-.k^', 'MarkerFaceColor', 'k');  
hold off
xlim([2000 2012]);
max3=max(P(1,:)); 
max4=max(P(2,:)); 
max5=max(P(3,:)); 
maxT=max([max3; max4; max5]); 
maxT=maxT+0.1*maxT; 
ylim([0 maxT]); 
set(gca, 'XTick', x); 
set(gca, 'XTickLabel', x); 

legend ('Has ever used methamphetamines', 'Smoked cigarettes in school*', 'Has used cocaine*', 'Location', 'SouthWest');  
xlabel('Year', 'FontSize',12); 
ylabel('Odds Ratio with gun carrying behavior', 'FontSize',12);  
set (gca, 'FontSize',12); 
    

