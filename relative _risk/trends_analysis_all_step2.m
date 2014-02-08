%4. purple grey ***********
%C1=[99/255 86/255 136/255];
%5. green/blue ++
%C2=[95/255 158/255 160/255];
%6. blue/blue***********
%C3=[24/255 116/255 205/255];
%7. darker blue++
C1=[16/255 78/255 139/255];
%8. muted purple (darker than 4.)*******
%C4=[66/255 66/255 111/255];
%9. light green (a bit too light)++
C2=[112/255 219/255 147/255];
%10. brighter light purple ***
light_purple=[132/255 112/255 255/255];
%11. darker gray **********
C11=[56/255 56/255 56/255];
%12. salmon *******
C3=[205/255 51/255 51/255];
%13. maroon+++
C6=[142/255 35/255 35/255];
%14. green*********
%dull_green=[2/255 157/255 116/255];
C4=[64/255 224/255 208/255];
%15 brown/orange*********
C3=[255/255 127/255 0/255];
%16. mauve****
C9=[205/255 96/255 144/255];

% cd matrices
% load trends
% load q_labels
% cd ..
% 
% %%Changes in both -----------------------------------
% [r,c]=size(plot1); 
% ymax=max(max(abs(plot1))); 
% s=0; 
% mycmap=[0/255 139/255 69/255; 54/255 100/255 139/255; 205/255 51/255 51/255];  
% for i=1:r
%     if s==0
%         f1=subplot(r,1,i); 
%         temp=plot1(i,:); 
%         indxu=find(temp>50);
%         indxd=find(temp<-50); 
%         bar_color=zeros(length(temp),1); 
%         bar_color(indxu)=1; 
%         bar_color(indxd)=-1; 
%         bh=bar(temp); 
%         ch=get(bh,'Children');  
%         set (ch,'CData',bar_color) ; 
%         colormap(mycmap); 
%         ylim([-ymax ymax]); 
%         pos1=get(f1,'Position'); %find the current position [x,y,width,height]
%         s=1; 
%     else 
%         f2=subplot(r,1,i); 
%         temp=plot1(i,:); 
%         indxu=find(temp>50);
%         indxd=find(temp<-50); 
%         bar_color=zeros(length(temp),1); 
%         bar_color(indxu)=1; 
%         bar_color(indxd)=-1;  
%         bh=bar(temp); 
%         ch=get(bh,'Children');  
%         set (ch,'CData',bar_color) ; 
%         colormap(mycmap); 
%         ylim([-ymax ymax]); 
%         linkaxes([f1 f2],'x'); %make y axis the same
%         pos2=get(f2,'Position'); %find the current position [x,y,width,height]
%         pos2(2)=pos1(2) - pos2(4); %move the second so it touches the first 
%         set (f2,'Position',pos2); 
%         f1=f2; 
%         pos1=pos2; 
%     end 
%     if i==r
%         set (f1, 'YTickLabel', []); 
%         ylabel(cell1{i,2});
%     else
%         set(f1, 'XTickLabel',[]); 
%         set(f1, 'YTickLabel',[]);
%         set(f1, 'XTick', []); 
%         ylabel(cell1{i,2}); 
%     end  
% end 
% tightfig; 
% print (gcf,'-dpng','trend_changes_both.png');
% close
% 
% clear 
% cd matrices
% load trends
% load q_labels
% cd ..
% 
% %%only up -----------------------------------
% [r,c]=size(plot2); 
% ymax=max(max(abs(plot2))); 
% s=0; 
% mycmap=[54/255 100/255 139/255; 205/255 51/255 51/255]; 
% k=(r-1)/2; 
% for i=1:k
%     if s==0
%         f1=subplot(k,1,i); 
%         temp=plot2(i,:); 
%         indxu=find(temp>50);
%         indxd=find(temp<-50); 
%         bar_color=zeros(length(temp),1); 
%         bar_color(indxu)=1; 
%         bar_color(indxd)=-1; 
%         bh=bar(temp); 
%         ch=get(bh,'Children');  
%         set (ch,'CData',bar_color) ; 
%         colormap(mycmap); 
%         ylim([-ymax ymax]); 
%         pos1=get(f1,'Position'); %find the current position [x,y,width,height]
%         s=1; 
%     else 
%         f2=subplot(k,1,i); 
%         temp=plot2(i,:); 
%         indxu=find(temp>50);
%         indxd=find(temp<-50); 
%         bar_color=zeros(length(temp),1); 
%         bar_color(indxu)=1; 
%         bar_color(indxd)=-1;  
%         bh=bar(temp); 
%         ch=get(bh,'Children');  
%         set (ch,'CData',bar_color) ; 
%         colormap(mycmap); 
%         ylim([-ymax ymax]); 
%         linkaxes([f1 f2],'x'); %make y axis the same
%         pos2=get(f2,'Position'); %find the current position [x,y,width,height]
%         pos2(2)=pos1(2) - pos2(4); %move the second so it touches the first 
%         set (f2,'Position',pos2); 
%         f1=f2; 
%         pos1=pos2; 
%     end 
%     if i==k
%         set (f1, 'YTickLabel', []); 
%         ylabel(cell2{i,2});
%         xlim([0 56]); 
%         set (f1, 'XTick', 1.5:55.5); 
%         set (f1, 'XTickLabel', qlabel(1:55,1));
%         
%     else
%         set(f1, 'XTickLabel',[]); 
%         set(f1, 'YTickLabel',[]);
%         set(f1, 'XTick', []); 
%         xlim([0 56]); 
%         ylabel(cell2{i,2}); 
%     end  
% end 
% rotateXLabels(gca,90);
% tightfig; 
% print (gcf,'-dpng','trend_changes_up1.png');
% close
% 
% m=r-k; 
% s=0; 
% for i=1:m
%     if s==0
%         f1=subplot(m,1,i); 
%         temp=plot2((i+k),:); 
%         indxu=find(temp>50);
%         indxd=find(temp<-50); 
%         bar_color=zeros(length(temp),1); 
%         bar_color(indxu)=1; 
%         bar_color(indxd)=-1; 
%         bh=bar(temp); 
%         ch=get(bh,'Children');  
%         set (ch,'CData',bar_color) ; 
%         colormap(mycmap); 
%         ylim([-ymax ymax]); 
%         pos1=get(f1,'Position'); %find the current position [x,y,width,height]
%         s=1; 
%     else 
%         f2=subplot(m,1,i); 
%         temp=plot2((i+k),:); 
%         indxu=find(temp>50);
%         indxd=find(temp<-50); 
%         bar_color=zeros(length(temp),1); 
%         bar_color(indxu)=1; 
%         bar_color(indxd)=-1;  
%         bh=bar(temp); 
%         ch=get(bh,'Children');  
%         set (ch,'CData',bar_color) ; 
%         colormap(mycmap); 
%         ylim([-ymax ymax]); 
%         linkaxes([f1 f2],'x'); %make y axis the same
%         pos2=get(f2,'Position'); %find the current position [x,y,width,height]
%         pos2(2)=pos1(2) - pos2(4); %move the second so it touches the first 
%         set (f2,'Position',pos2); 
%         f1=f2; 
%         pos1=pos2; 
%     end 
%     if i==m
%         set (f1, 'YTickLabel', []); 
%         ylabel(cell2{(i+k),2});
%     else
%         set(f1, 'XTickLabel',[]); 
%         set(f1, 'YTickLabel',[]);
%         set(f1, 'XTick', []); 
%         ylabel(cell2{(i+k),2}); 
%     end  
% end 
% tightfig; 
% print (gcf,'-dpng','trend_changes_up2.png');
% close
% 
% %%only down -----------------------------------
% clear 
% cd matrices
% load trends
% cd ..
% 
% [r,c]=size(plot3); 
% ymax=max(max(abs(plot3))); 
% s=0; 
% mycmap=[0/255 139/255 69/255; 54/255 100/255 139/255];
% for i=1:r
%     if s==0
%         f1=subplot(r,1,i); 
%         temp=plot3(i,:); 
%         indxu=find(temp>50);
%         indxd=find(temp<-50); 
%         bar_color=zeros(length(temp),1); 
%         bar_color(indxu)=1; 
%         bar_color(indxd)=-1; 
%         bh=bar(temp); 
%         ch=get(bh,'Children');  
%         set (ch,'CData',bar_color) ; 
%         colormap(mycmap); 
%         ylim([-ymax ymax]); 
%         pos1=get(f1,'Position'); %find the current position [x,y,width,height]
%         s=1; 
%     else 
%         f2=subplot(r,1,i); 
%         temp=plot3(i,:); 
%         indxu=find(temp>50);
%         indxd=find(temp<-50); 
%         bar_color=zeros(length(temp),1); 
%         bar_color(indxu)=1; 
%         bar_color(indxd)=-1;  
%         bh=bar(temp); 
%         ch=get(bh,'Children');  
%         set (ch,'CData',bar_color) ; 
%         colormap(mycmap); 
%         ylim([-ymax ymax]); 
%         linkaxes([f1 f2],'x'); %make y axis the same
%         pos2=get(f2,'Position'); %find the current position [x,y,width,height]
%         pos2(2)=pos1(2) - pos2(4); %move the second so it touches the first 
%         set (f2,'Position',pos2); 
%         f1=f2; 
%         pos1=pos2; 
%     end 
%     if i==r
%         set (f1, 'YTickLabel', []); 
%         ylabel(cell3{i,2}); 
%     else
%         set(f1, 'XTickLabel',[]); 
%         set(f1, 'YTickLabel',[]);
%         set(f1, 'XTick', []); 
%         ylabel(cell3{i,2}) ; 
%     end  
% end 
% tightfig; 
% print (gcf,'-dpng','trend_changes_down.png');
% close
% 
% 
% x=1:55; 
% [r,c]=size(plot1);
% for i=1:r
%     plot(x,plot1(i,:),'b'); 
%     hold on
% end 
% hold off
% print (gcf,'-dpng','trend_lines_both.png');
% close
% 
% [r,c]=size(plot2);
% for i=1:r
%     plot(x,plot2(i,:),'r'); 
%     hold on
% end
% hold off
% print (gcf,'-dpng','trend_lines_up.png');
% close
% 
% [r,c]=size(plot3);
% for i=1:r
%     plot(x,plot3(i,:),'g'); 
%     hold on
% end 
% hold off
% print (gcf,'-dpng','trend_lines_down.png');
% close
% 
% [r,c]=size(plot4);
% for i=1:r
%     plot(x,plot4(i,:),'k'); 
%     hold on
% end 
% hold off
% print (gcf,'-dpng','trend_lines_none.png');
% close

% 
% x=1:55; 
% [r,c]=size(trends);
% for i=1:r
%     for j=1:55
%         if trends(i,j)>50
%             scatter(j,trends(i,j),5,'r');
%         elseif trends(i,j)<-50
%             scatter(j,trends(i,j),5,'g');
%         else 
%             scatter(j,trends(i,j),5,'k');
%         end
%         hold on
%     end 
% end 
% hold off
% print (gcf,'-dpng','trend_lines_total.png');
% close
% 
% x=1:55; 
% [r,c]=size(trends);
% for i=1:r
%     for j=1:55
%         if qlabel{i,3}==1
%             scatter(j,trends(i,j),5,C1,'fill');
%         elseif qlabel{i,3}==2
%             scatter(j,trends(i,j),5,C2,'fill');
%         elseif qlabel{i,3}==3
%             scatter(j,trends(i,j),5,C3,'fill');
%         elseif qlabel{i,3}==4
%             scatter(j,trends(i,j),5,C4,'fill');
%         elseif qlabel{i,3}==5
%             scatter(j,trends(i,j),5,C5,'fill');
%         elseif qlabel{i,3}==6
%             scatter(j,trends(i,j),5,C6,'fill');
%         else 
%             print ('Error!'); 
%         end
%         hold on
%     end 
% end 
% hold off
% print (gcf,'-dpng','trend_lines_total2.png');
% close
% 
x=1:55; 
[r,c]=size(trends);
plotmat1=double.empty; 
c1=double.empty; 
a=1; 
plotmat2=double.empty; 
c2=double.empty; 
b=1; 
plotmat3=double.empty; 
c3=double.empty; 
c=1; 
plotmat4=double.empty; 
c4=double.empty;
d=1; 
plotmat5=double.empty; 
c5=double.empty; 
e=1; 
plotmat6=double.empty; 
c6=double.empty; 
f=1; 
for i=1:r
    if qlabel{i,3}==1
        plotmat1(a,:)=trends(i,:); 
        c1{a,1}=qlabel{i,1}; 
        a=a+1; 
    elseif qlabel{i,3}==2
        plotmat2(b,:)=trends(i,:);
        c2{b,1}=qlabel{i,1};  
        b=b+1; 
    elseif qlabel{i,3}==3
        plotmat3(c,:)=trends(i,:); 
        c3{c,1}=qlabel{i,1}; 
        c=c+1; 
    elseif qlabel{i,3}==4
        plotmat4(d,:)=trends(i,:); 
        c4{d,1}=qlabel{i,1}; 
        d=d+1; 
    elseif qlabel{i,3}==5
        plotmat5(e,:)=trends(i,:);
        c5{e,1}=qlabel{i,1};  
        e=e+1; 
    elseif qlabel{i,3}==6
        plotmat6(f,:)=trends(i,:); 
        c6{f,1}=qlabel{i,1};  
        f=f+1; 
    else 
        print ('Error!'); 
    end
end 

change1=cell.empty; 
change2=cell.empty; 
change3=cell.empty; 
change4=cell.empty; 
change5=cell.empty; 
change6=cell.empty; 

x=1:55; 
[r,c]=size(plotmat1);
k=1; 
for i=1:r
    for j=1:55
        if plotmat1(i,j)>50
            scatter(j,plotmat1(i,j),5,'r','fill'); 
            change1{k,1}=c1{i,1}; 
            change1{k,2}=qlabel{j,1};
            change1{k,3}=plotmat1(i,j); 
            k=k+1; 
        elseif plotmat1(i,j)<-50
            scatter(j,plotmat1(i,j),5,'g','fill'); 
            change1{k,1}=c1{i,1}; 
            change1{k,2}=qlabel{j,1};
            change1{k,3}=plotmat1(i,j); 
            k=k+1; 
        else 
            scatter(j,plotmat1(i,j),5,'k','fill'); 
        end
        hold on
    end 
end 
hold off
ylim([-200 200])
set (gca, 'XTick', 1:55); 
set (gca, 'XTickLabel', qlabel(1:55,1));
rotateXLabels(gca,90);
print (gcf,'-dpng','trend_lines_physicaled_nutrition.png');
print (gcf,'-depsc2','trend_lines_physicaled_nutrition'); 
close


x=1:55; 
k=1; 
[r,c]=size(plotmat2);
for i=1:r
    for j=1:55
        if plotmat2(i,j)>50
            scatter(j,plotmat2(i,j),5,'r','fill'); 
            change2{k,1}=c2{i,1}; 
            change2{k,2}=qlabel{j,1};
            change2{k,3}=plotmat2(i,j); 
            k=k+1; 
        elseif plotmat2(i,j)<-50
            scatter(j,plotmat2(i,j),5,'g','fill'); 
            change2{k,1}=c2{i,1}; 
            change2{k,2}=qlabel{j,1};
            change2{k,3}=plotmat2(i,j); 
            k=k+1; 
        else 
            scatter(j,plotmat2(i,j),5,'k','fill'); 
        end
        hold on
    end 
end 
hold off
ylim([-200 200])
set (gca, 'XTick', 1:55); 
set (gca, 'XTickLabel', qlabel(1:55,1));
rotateXLabels(gca,90);
print (gcf,'-dpng','trend_lines_dieting_suicide_sex.png');
print (gcf,'-depsc2','trend_lines_dieting_suicide_sex'); 
close

x=1:55; 
k=1; 
[r,c]=size(plotmat3);
for i=1:r
    for j=1:55
        if plotmat3(i,j)>50
            scatter(j,plotmat3(i,j),5,'r','fill'); 
            change3{k,1}=c3{i,1}; 
            change3{k,2}=qlabel{j,1};
            change3{k,3}=plotmat3(i,j); 
            k=k+1; 
        elseif plotmat3(i,j)<-50
            scatter(j,plotmat3(i,j),5,'g','fill'); 
            change3{k,1}=c3{i,1}; 
            change3{k,2}=qlabel{j,1};
            change3{k,3}=plotmat3(i,j); 
            k=k+1; 
        else 
            scatter(j,plotmat3(i,j),5,'k','fill'); 
        end
        hold on
    end 
end 
hold off
ylim([-200 200])
set (gca, 'XTick', 1:55); 
set (gca, 'XTickLabel', qlabel(1:55,1));
rotateXLabels(gca,90);
print (gcf,'-dpng','trend_lines_weapon_violence.png');
print (gcf,'-depsc2','trend_lines_weapon_violence');
close

x=1:55; 
[r,c]=size(plotmat4);
k=1; 
for i=1:r
    for j=1:55
        if plotmat4(i,j)>50
            scatter(j,plotmat4(i,j),5,'r','fill'); 
            change4{k,1}=c4{i,1}; 
            change4{k,2}=qlabel{j,1};
            change4{k,3}=plotmat4(i,j); 
            k=k+1; 
        elseif plotmat4(i,j)<-50
            scatter(j,plotmat4(i,j),5,'g','fill'); 
            change4{k,1}=c4{i,1}; 
            change4{k,2}=qlabel{j,1};
            change4{k,3}=plotmat4(i,j); 
            k=k+1; 
        else 
            scatter(j,plotmat4(i,j),5,'k','fill'); 
        end
        hold on
    end 
end 
hold off
ylim([-200 200])
set (gca, 'XTick', 1:55); 
set (gca, 'XTickLabel', qlabel(1:55,1));
rotateXLabels(gca,90);
print (gcf,'-dpng','trend_lines_alcohol_smoking.png');
print (gcf,'-depsc2','trend_lines_alcohol_smoking');
close

x=1:55; 
k=1; 
[r,c]=size(plotmat5);
for i=1:r
    for j=1:55
        if plotmat5(i,j)>50
            scatter(j,plotmat5(i,j),5,'r','fill'); 
            change5{k,1}=c5{i,1};
            change5{k,2}=qlabel{j,1}; 
            change5{k,3}=plotmat5(i,j); 
            k=k+1; 
        elseif plotmat5(i,j)<-50
            scatter(j,plotmat5(i,j),5,'g','fill'); 
            change5{k,1}=c5{i,1}; 
            change5{k,2}=qlabel{j,1}; 
            change5{k,3}=plotmat5(i,j); 
            k=k+1; 
        else 
            scatter(j,plotmat5(i,j),5,'k','fill'); 
        end
        hold on
    end 
end 
hold off
ylim([-200 200])
set (gca, 'XTick', 1:55); 
set (gca, 'XTickLabel', qlabel(1:55,1));
rotateXLabels(gca,90);
print (gcf,'-dpng','trend_lines_drugs_school.png');
print (gcf,'-depsc2','trend_lines_drugs_school');
close

x=1:55; 
k=1; 
[r,c]=size(plotmat6);
for i=1:r
    for j=1:55
        if plotmat6(i,j)>50
            scatter(j,plotmat6(i,j),5,'r','fill'); 
            change6{k,1}=c6{i,1}; 
            change6{k,2}=qlabel{j,1};
            change6{k,3}=plotmat6(i,j); 
            k=k+1; 
        elseif plotmat6(i,j)<-50
            scatter(j,plotmat6(i,j),5,'g','fill'); 
            change6{k,1}=c6{i,1}; 
            change6{k,2}=qlabel{j,1}; 
            change6{k,3}=plotmat6(i,j); 
            k=k+1; 
        else 
            scatter(j,plotmat6(i,j),5,'k','fill'); 
        end
        hold on
    end 
end 
hold off
ylim([-200 200])
set (gca, 'XTick', 1:55); 
set (gca, 'XTickLabel', qlabel(1:55,1));
rotateXLabels(gca,90);
print (gcf,'-dpng','trend_lines_drugs.png');
print (gcf,'-depsc2','trend_lines_drugs');
close

% %stats
% stat_mat=double.empty; 
% for i=1:55
%     group1=trends(i,:); 
%     for j=1:55
%         group2=trends(j,:); 
%         [hval,pval]=ttest2(group1,group2); 
%         stat_mat(i,j)=pval; 
%     end 
% end 
