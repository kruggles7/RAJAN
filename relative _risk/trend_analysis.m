mat2001=log_rel_risk(:,1); 
mat2011=log_rel_risk(:,6); 
delta=mat2011-mat2001; 
delta=delta/mat2001; 
d=delta(:,1)*100; 
indxu=find(d>20); 
indxd=find(d<-15); 
n=1; 
x=[2001 2003 2005 2007 2009 2011]; 
% %g={'-ko','--ks',':kv'}; 
% for i=1:numel(indxu)
%     mat2(n,:)=log_rel_risk(indxu(i),:); 
%     lab{n,1}=qlabel{indxu(i),1}; 
%     plot(x,mat2(n,:)); 
%     hold on; 
%     n=n+1; 
% end 
% legend (lab, 'location', 'NorthWest'); 
% hold off; 
% ylim([0 2]); 

bar(d)
% set(gca,'xtick',[2001 2003 2005 2007 2009 2011]); 
% for i=1:numel(indxd)
%     mat2(n,:)=log_rel_risk(indxd(i),:); 
%     lab{n,1}=qlabel{indxd(i),1}; 
%     n=n+1; 
% end 

