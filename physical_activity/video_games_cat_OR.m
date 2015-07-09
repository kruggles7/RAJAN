cd ..
cd ..
cd matrices
load OR_2013_100714
load OR_CI_2013_100714
OR_2013=odds_ratio_cell; 
OR_2013_CI=OR_CI;
cd OR_categorical
cd PhysicalActivity
load Q72_cat_OR
load Q72_response_2_OR_2013_cat
load Q72_response_2_OR_2013_cat_CI
OR2=odds_ratio_cell; 
OR_CI2=OR_CI; 
load Q72_response_3_OR_2013_cat
load Q72_response_3_OR_2013_cat_CI
OR3=odds_ratio_cell; 
OR_CI3=OR_CI; 
load Q72_response_4_OR_2013_cat
load Q72_response_4_OR_2013_cat_CI
OR4=odds_ratio_cell; 
OR_CI4=OR_CI; 
load Q72_response_5_OR_2013_cat
load Q72_response_5_OR_2013_cat_CI
OR5=odds_ratio_cell; 
OR_CI5=OR_CI; 
load Q72_response_6_OR_2013_cat
load Q72_response_6_OR_2013_cat_CI
OR6=odds_ratio_cell; 
OR_CI6=OR_CI; 
load Q72_response_7_OR_2013_cat
load Q72_response_7_OR_2013_cat_CI
OR7=odds_ratio_cell; 
OR_CI7=OR_CI; 
cd ..
cd ..
load qlabel_090914
cd ..
cd programs
cd physical_activity

indx=find(strcmp(OR_2013(:,1),'Q72')==1); 
OR_2013_=OR_2013(indx,:); 
OR_2013_CI_=OR_2013_CI(indx,:); 

[r,c]=size(OR2);

final=zeros(r,7); 
lower=zeros(r,7); 
upper=zeros(r,7); 
for i=1:r
    
    %check for empty 
    k=cellfun(@isempty,OR2(i,9)); %only 2013 data
    if (k==0)
        N=OR2{i,9}; 
        final(i,1)=N; 
        C=OR_CI2{i,9}; 
        a=char(C);
        b=strfind(a,', ');
        up_=''; 
        dn_=''; 
        for p=1:(b(1)-1)
            temp=a(p);
            dn_=[dn_ temp];
        end 
        lower(i,1)=str2double(dn_); 
        for p=(b(1)+1):numel(a)
            temp=a(p); 
            up_=[up_ temp]; 
        end 
        upper(i,1)=str2double(up_); 
    end
    
    k=cellfun(@isempty,OR3(i,9)); %only 2013 data
    if (k==0)
        N=OR3{i,9}; 
        final(i,2)=N; 
        C=OR_CI3{i,9}; 
        a=char(C);
        b=strfind(a,', ');
        up_=''; 
        dn_=''; 
        for p=1:(b(1)-1)
            temp=a(p);
            dn_=[dn_ temp];
        end 
        lower(i,2)=str2double(dn_); 
        for p=(b(1)+1):numel(a)
            temp=a(p); 
            up_=[up_ temp]; 
        end 
        upper(i,2)=str2double(up_); 
    end 
    
    k=cellfun(@isempty,OR4(i,9)); %only 2013 data
    if (k==0)
        N=OR4{i,9}; 
        final(i,3)=N; 
        C=OR_CI4{i,9}; 
        a=char(C);
        b=strfind(a,', ');
        up_=''; 
        dn_=''; 
        for p=1:(b(1)-1)
            temp=a(p);
            dn_=[dn_ temp];
        end 
        lower(i,3)=str2double(dn_); 
        for p=(b(1)+1):numel(a)
            temp=a(p); 
            up_=[up_ temp]; 
        end 
        upper(i,3)=str2double(up_); 
    end 
    
    k=cellfun(@isempty,OR5(i,9)); %only 2013 data
    if (k==0)
        N=OR5{i,9}; 
        final(i,4)=N; 
        C=OR_CI5{i,9}; 
        a=char(C);
        b=strfind(a,', ');
        up_=''; 
        dn_=''; 
        for p=1:(b(1)-1)
            temp=a(p);
            dn_=[dn_ temp];
        end 
        lower(i,4)=str2double(dn_); 
        for p=(b(1)+1):numel(a)
            temp=a(p); 
            up_=[up_ temp]; 
        end 
        upper(i,4)=str2double(up_); 
    end 
    
    k=cellfun(@isempty,OR6(i,9)); %only 2013 data
    if (k==0)
        N=OR6{i,9}; 
        final(i,5)=N; 
        C=OR_CI6{i,9}; 
        a=char(C);
        b=strfind(a,', ');
        up_=''; 
        dn_=''; 
        for p=1:(b(1)-1)
            temp=a(p);
            dn_=[dn_ temp];
        end 
        lower(i,5)=str2double(dn_); 
        for p=(b(1)+1):numel(a)
            temp=a(p); 
            up_=[up_ temp]; 
        end 
        upper(i,5)=str2double(up_); 
    end 
    
    k=cellfun(@isempty,OR7(i,9)); %only 2013 data
    if (k==0)
        N=OR7{i,9}; 
        final(i,6)=N; 
        C=OR_CI7{i,9}; 
        a=char(C);
        b=strfind(a,', ');
        up_=''; 
        dn_=''; 
        for p=1:(b(1)-1)
            temp=a(p);
            dn_=[dn_ temp];
        end 
        lower(i,6)=str2double(dn_); 
        for p=(b(1)+1):numel(a)
            temp=a(p); 
            up_=[up_ temp]; 
        end 
        upper(i,6)=str2double(up_); 
    end 
end 
% 
% %significantly positive increases----------------------------
% signif_pos=cell.empty; 
% count=1; 
% x=2:7; 
% plot_mat=double.empty; 
% for i=1:r
%     max_=max(final(i,:)); 
%     min_=min(final(i,:)); 
%     diff=max_-min_; 
%     diff2=0; 
%     diff3=final(i,1)-final(i,6); %slope
%     for j=1:6
%         for k=1:6
%             if lower(i,j)>upper(i,k) || upper(i,k)<lower(i,j)
%                 diff2=1; 
%             end 
%         end 
%     end 
%     
%     if sum(final(i,:)>0) && diff2==1 && diff>0.7 && diff3<0 %positive slope
%         signif_pos{count,1}=qlabel{i,1}; 
%         signif_pos{count,2}=diff;
%         signif_pos{count,3}=final(i,1); 
%         signif_pos{count,4}=final(i,6); 
%         plot_mat(count,:,1)=final(i,:); 
%         E=(upper(i,:)-lower(i,:))/2; 
%         plot_mat(count,:,2)=E; 
%         plot_mat(count,:,3)=lower(i,:); 
%         plot_mat(count,:,4)=upper(i,:); 
%         count=count+1; 
%         %plot(x, final(i,:), '-o');
%         %hold on
%         %errorbar(x, final(i,:),E); 
%     end 
% end 
% 
% [r2,c2,z]=size(plot_mat); 
% for i=1:r2
%     h2=subplot(1,r2,i);
%     scatter(x, plot_mat(i,:,1), 'fill'); 
%      hold on
% %     for j=1:6
% %         plot(x(j),plot_mat(i,j,3), x(j), plot_mat(i,j,4), 'LineStyle', '-', 'LineWidth', 0.5, 'Color', 'k'); 
% %     end 
%     errorbar(x,plot_mat(i,:,1),plot_mat(i,:,2), '.', 'Color', 'k'); 
%     hold off
%     ylim([0 3]); 
%     set(gca, 'XTick', 2:7); 
%     set(gca, 'XTickLabel', {'0', '1', '2', '3', '4', '5'}); 
%     if (i>1)
%         set(gca, 'YTick', []); 
%         linkaxes([h1 h2],'y'); 
%         pos1=get(h1,'Position'); 
%         pos2=get(h2,'Position'); 
%         pos2(4)=pos1(4); 
%         set(h2,'Position',pos2); 
%         pos1(2)=pos2(2); 
%         set(h1, 'Position', pos1); 
%         pos2(1)=pos1(1)+pos1(3); 
%         set(h2,'Position', pos2); 
%     else 
%         ylabel('Odds Ratio'); 
%     end 
%     h1=h2; 
%     
% end 
% saveas (gcf, 'Q72_changingOR_positive.fig'); 
% close all
% 
% %significantly negative increases----------------------------
% signif_neg=cell.empty; 
% count=1; 
% x=2:7; 
% plot_mat=double.empty; 
% for i=1:r
%     max_=max(final(i,:)); 
%     min_=min(final(i,:)); 
%     diff=max_-min_; 
%     diff2=0; 
%     diff3=final(i,1)-final(i,6); %slope
%     for j=1:6
%         for k=1:6
%             if lower(i,j)>upper(i,k) || upper(i,k)<lower(i,j)
%                 diff2=1; 
%             end 
%         end 
%     end 
%     
%     if sum(final(i,:)>0) && diff2==1 && diff>0.5 && diff3>0 %positive slope
%         signif_neg{count,1}=qlabel{i,1}; 
%         signif_neg{count,2}=diff;
%         signif_neg{count,3}=final(i,1); 
%         signif_neg{count,4}=final(i,6); 
%         plot_mat(count,:,1)=final(i,:); 
%         E=(upper(i,:)-lower(i,:))/2; 
%         plot_mat(count,:,2)=E; 
%         plot_mat(count,:,3)=lower(i,:); 
%         plot_mat(count,:,4)=upper(i,:); 
%         count=count+1; 
% %         plot(x, final(i,:), '-o');
% %         hold on
% %         E=(upper(i,:)-lower(i,:))/2; 
% %         errorbar(x, final(i,:),E); 
%     end 
% end 
% 
% [r2,c2,z]=size(plot_mat); 
% for i=1:r2
%     h2=subplot(1,r2,i);
%     scatter(x, plot_mat(i,:,1), 'fill'); 
%      hold on
% %     for j=1:6
% %         plot(x(j),plot_mat(i,j,3), x(j), plot_mat(i,j,4), 'LineStyle', '-', 'LineWidth', 0.5, 'Color', 'k'); 
% %     end 
%     errorbar(x,plot_mat(i,:,1),plot_mat(i,:,2), '.', 'Color', 'k'); 
%     hold off
%     ylim([0 3]); 
%     set(gca, 'XTick', 2:7); 
%     set(gca, 'XTickLabel', {'0', '1', '2', '3', '4', '5'}); 
%     if (i>1)
%         set(gca, 'YTick', []); 
%         linkaxes([h1 h2],'y'); 
%         pos1=get(h1,'Position'); 
%         pos2=get(h2,'Position'); 
%         pos2(4)=pos1(4); 
%         set(h2,'Position',pos2); 
%         pos1(2)=pos2(2); 
%         set(h1, 'Position', pos1); 
%         pos2(1)=pos1(1)+pos1(3); 
%         set(h2,'Position', pos2); 
%     else 
%         ylabel('Odds Ratio'); 
%     end 
%     h1=h2; 
%     
% end 
% saveas (gcf, 'Q72_changingOR_negative.fig'); 
% close all
% 
% 
% high_OR=cell.empty; 
% count=1; 
% x=2:7; 
% plot_mat=double.empty; 
% for i=1:r
%     min_=min(lower(i,:)); 
%     if sum(final(i,:)>0) && min_>1
%         high_OR{count,1}=qlabel{i,1}; 
%         high_OR{count,2}=final(i,1); 
%         high_OR{count,3}=final(i,6); 
%         plot_mat(count,:,1)=final(i,:); 
%         E=(upper(i,:)-lower(i,:))/2; 
%         plot_mat(count,:,2)=E; 
%         plot_mat(count,:,3)=lower(i,:); 
%         plot_mat(count,:,4)=upper(i,:); 
%         count=count+1; 
% %         plot(x, final(i,:), '-o');
% %         hold on
% %         E=(upper(i,:)-lower(i,:))/2; 
% %         errorbar(x, final(i,:),E); 
%     end 
% end 
% [r2,c2,z]=size(plot_mat); 
% for i=1:r2
%     h2=subplot(1,r2,i);
%     scatter(x, plot_mat(i,:,1), 'fill'); 
%     hold on
%     errorbar(x,plot_mat(i,:,1),plot_mat(i,:,2), '.', 'Color', 'k'); 
%     hold off
%     ylim([0 2.5]); 
%     set(gca, 'XTick', 2:7); 
%     set(gca, 'XTickLabel', {'0', '1', '2', '3', '4', '5'}); 
%     if (i>1)
%         set(gca, 'YTick', []); 
%         linkaxes([h1 h2],'y'); 
%         pos1=get(h1,'Position'); 
%         pos2=get(h2,'Position'); 
%         pos2(4)=pos1(4); 
%         set(h2,'Position',pos2); 
%         pos1(2)=pos2(2); 
%         set(h1, 'Position', pos1); 
%         pos2(1)=pos1(1)+pos1(3); 
%         set(h2,'Position', pos2); 
%     else 
%         ylabel('Odds Ratio'); 
%     end 
%     h1=h2; 
%     
% end 
% saveas (gcf, 'Q72_highOR.fig'); 
% close all
% 
% low_OR=cell.empty; 
% count=1; 
% x=2:7; 
% plot_mat=double.empty; 
% for i=1:r
%     max_=max(upper(i,:)); 
%     if sum(final(i,:)>0) && max_<1
%         low_OR{count,1}=qlabel{i,1}; 
%         low_OR{count,2}=final(i,1); 
%         low_OR{count,3}=final(i,6); 
%         plot_mat(count,:,1)=final(i,:); 
%         E=(upper(i,:)-lower(i,:))/2; 
%         plot_mat(count,:,2)=E; 
%         plot_mat(count,:,3)=lower(i,:); 
%         plot_mat(count,:,4)=upper(i,:); 
%         count=count+1; 
% %         plot(x, final(i,:), '-o');
% %         hold on
% %         E=(upper(i,:)-lower(i,:))/2; 
% %         errorbar(x, final(i,:),E); 
%     end 
% end 
% 
% [r2,c2,z]=size(plot_mat); 
% for i=1:r2
%     h2=subplot(1,r2,i);
%     scatter(x, plot_mat(i,:,1), 'fill'); 
%     hold on
%     errorbar(x,plot_mat(i,:,1),plot_mat(i,:,2), '.', 'Color', 'k'); 
%     hold off
%     ylim([0 2.5]); 
%     set(gca, 'XTick', 2:7); 
%     set(gca, 'XTickLabel', {'0', '1', '2', '3', '4', '5'}); 
%     if (i>1)
%         set(gca, 'YTick', []); 
%         linkaxes([h1 h2],'y'); 
%         pos1=get(h1,'Position'); 
%         pos2=get(h2,'Position'); 
%         pos2(4)=pos1(4); 
%         set(h2,'Position',pos2); 
%         pos1(2)=pos2(2); 
%         set(h1, 'Position', pos1); 
%         pos2(1)=pos1(1)+pos1(3); 
%         set(h2,'Position', pos2); 
%     else 
%         ylabel('Odds Ratio'); 
%     end 
%     h1=h2; 
%     
% end 
% saveas (gcf, 'Q72_lowOR.fig'); 
% close all
% 
% 
% 
