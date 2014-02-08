%make heatmaps out of the relative risk matrix 
clear
xlab={'2001', '2003', '2005', '2007', '2009', '2011'}; 
cd matrices
load rel_risk_RC_111413.mat
load q_labels.mat
cd ..

trends=double.empty; 
count=1; 
plot1=double.empty; 
plot2=double.empty; 
plot3=double.empty; 
plot4=double.empty; 
cell1=cell.empty; 
cell2=cell.empty; 
cell3=cell.empty; 
cell4=cell.empty; 
c1=1; 
c2=1; 
c3=1; 
c4=1; 
for i=1:70
    i_char=num2str(i); 
    q1_=i_char; 
    num2=i; 
    if length(i_char)<2
        i_char=['0' i_char]; 
    end 
    q1=['Q' i_char]; 
    indx=find (strcmp(odds_ratio_cell(:,1),q1)==1); 
    if isempty(indx)==0
        plot_mat=cell2mat(odds_ratio_cell(indx,3:8)); 
        q2=odds_ratio_cell(indx,2);
        q2_=cell(length(q2)-1,1); 
        for p=1:length(q2)-1
            s=q2{p,1}; 
            q2_{p,1}=s(2:3); 
        end  
        plot_mat=plot_mat(1:55,:); 
        plot_mat=rot90(plot_mat);
        [r,c]=size(plot_mat); 
        plot_mat2=plot_mat;
%         %qqplot_figs(plot_mat2, [ q1 '_raw']); 
%         for j=1:r
%             temp_mat=plot_mat(j,:); 
%             noinf=temp_mat; 
%             indx=find(isinf(noinf)==1); 
%             noinf(indx)=-1; 
%             maxv=max(noinf); 
%             temp_mat(indx)=maxv; 
%             plot_mat(j,:)=temp_mat; 
%         end 
        
%         %median center
%         med=median(plot_mat,2); 
%         for j=1:r
%             med=median(plot_mat(j,:)); 
%             plot_mat(j,:)=plot_mat(j,:)/med; 
%         end 
%         log_rel_risk=log2(plot_mat); 
%         for j=1:r
%             temp=log_rel_risk(j,:); 
%             minv=min(temp); 
%             indx3=find(log_rel_risk(j,:)<-100000); 
%             log_rel_risk(j,indx3)=minv; 
%         end 
%         xlab=fliplr(xlab); 
            
        %Complete the Trend analysis
        mat2001=plot_mat(6,:); 
        mat2011=plot_mat(1,:);
        mat2001=mat2001'; 
        mat2011=mat2011'; 
        delta(:,1)=mat2011(:,1)-mat2001(:,1); 
        for j=1:length(mat2001)
            delta(j,1)=delta(j,1)/mat2001(j,1); 
        end 
        d=delta(1:55,1)*100; 
        indxu=find(d>50); 
        indxd=find(d<-50); 
        n=1; 
        trends(:,count)=d; %NEED TO TAKE OUT ONE OF THE QUESTIONS (56,57)
        count=count+1; 
        indxu=find(d>50);
        indxd=find(d<-50); 
        bar_color=zeros(length(d),1); 
        bar_color(indxu)=1; 
        bar_color(indxd)=-1; 
        if numel(indxu)>0 && numel(indxd)>0
            mycmap=[0/255 139/255 69/255; 54/255 100/255 139/255; 205/255 51/255 51/255];  
            group=1; 
            plot1(c1,:)=d; 
            indx=find(strcmp(q1,qlabel(:,2))==1); 
            if numel(indx)>0
                cell1(c1,:)=qlabel(indx,:); 
            end
            c1=c1+1; 
        elseif numel(indxu)>0
            mycmap=[54/255 100/255 139/255; 205/255 51/255 51/255];
            group=2; 
            plot2(c2,:)=d; 
            indx=find(strcmp(q1,qlabel(:,2))==1); 
            if numel(indx)>0
                cell2(c2,:)=qlabel(indx,:); 
            end
            c2=c2+1; 
        elseif numel(indxd)>0
            mycmap=[0/255 139/255 69/255; 54/255 100/255 139/255];
            group=3; 
            indx=find(strcmp(q1,qlabel(:,2))==1); 
            if numel(indx)>0
                cell3(c3,:)=qlabel(indx,:); 
            end
            plot3(c3,:)=d; 
            c3=c3+1; 
        else 
            mycmap=[54/255 100/255 139/255]; 
            group=4; 
            indx=find(strcmp(q1,qlabel(:,2))==1); 
            if numel(indx)>0
                cell4(c4,:)=qlabel(indx,:);  
            end 
            plot4(c4,:)=d; 
            c4=c4+1; 
        end 
        %bh=bar(d); 
        %ch=get(bh,'Children');  
        %set (ch,'CData',bar_color) ; 
        %colormap(winter); 
        %colormap(mycmap); 
        %hold on
        %x=[0 length(d)+1];
        %hold off
        %ylim([-150 150]); 
        %print (gcf,'-depsc2',[q1 '_trends']);
        %print (gcf,'-dpng',[q1 '_trends']);
        
    end 
end
%trends=trends(:,1:55); 
%cg=clustergram(trends, 'ColorMap', 'jet', 'DisplayRange', 25,
%'RowLabels',qlabel(:,1),'ColumnLabels',qlabel(:,1),'Cluster',2,'Symmetric','true');  ,'DisplayRange', 10,'Symmetric','true', 'Dendrogram',['' 25],
%cg=clustergram(trends,'RowLabels',qlabel(:,1),'ColumnLabels',qlabel(:,1),'Cluster',2, 'Colormap','jet','DisplayRange', 5,'Symmetric','false', 'LogTrans', 0 ); 
%hm=HeatMap(trends ); 

