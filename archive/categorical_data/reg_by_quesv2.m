files1=dir(fullfile('C:','Users','Kelly','Documents','MATLAB', 'rajan', 'CDC_FINAL', 'Matlab','regression_by_question','parsed_files','*.txt'));
P=length(files1);
cd .. 
cd regression_by_question
cd parsed_files
C={'k','b','g','r','m','y'}; 

for p=1:P
	q1=importdata(files1(p).name, '\t');
    c1=length(q1);
    r1=numel(q1)/c1; 
	filename1='';
	a1=char(files1(p).name);
	b1=strfind(a1,'-');
    for q=1:(b1(1)-1)
		c=a1(q);
		filename1=[filename1 c];
    end
    files2=dir(fullfile('C:','Users','Kelly','Documents','MATLAB', 'rajan', 'CDC_FINAL', 'Matlab','regression_by_question','parsed_files','*.txt'));
    N=length(files2);
	for n=1:N
		q2=importdata(files2(n).name, '\t');
		filename2='';
		a2=char(files2(n).name);
		b2=strfind(a2,'-');
        for m=1:(b2(1)-1)
			c=a2(m);
			filename2=[filename2 c];
        end
		if (strcmp(filename1,filename2)==0) % won't compare a question to itself
            c2=length(q2);
            r2=numel(q2)/c2; 
			if (r1==r2)
				r=r1;
                c=c1; 
                max_1=max(max(q1(:,2:r))); 
                max_2=max(max(q2(:,2:r))); 
                xlab=1:1:max_1; 
                ylab=1:1:max_2; 
                quest_plot=zeros(xlab,ylab,r); 
                avg_plot=double.empty; 
                for j=1:r
                    x=q1(j,2:c); 
                    nan_x=find(isnan(x)==1); 
                    x_num=length(x)-numel(nan_x); 
                    y=q2(j,2:c); 
                    nan_y=find(isnan(y)==1); 
                    y_num=length(y)-numel(nan_y); 
                    for k=1:max_1
                        indx=find(x(1,:)==k); 
                        y_plot=[]; 
                        z_plot=[];
                        x_plot=double.empty; 
                        for l=1:max_2
                            indx1=find(y(1,:)==l); 
                            n=intersect(indx,indx1); 
                            quest_plot(k,l,j)=numel(n)/x_num; 
                            x_plot(l)=numel(n)/x_num; 
                            y_plot=cat(1,y_plot,k);
                            z_plot=cat(1,z_plot,l); 
                        end 
                        size=x_plot*10000; 
                        scatter(y_plot,z_plot,size, C{j}); 
                        hold on
                    end 
                 end
                 hold off
                 xlim([0 max_1]); 
                 ylim([0 max_2]); 
                 %print (gcf,'-dmeta', [ filename1 '_' filename2 '_regcompare.emf']);  %can make pdf, jnp, or jpg 
                avg_plot=mean(quest_plot,3); 
                avg_plot2=avg_plot(2:max_1, :); 
                avg_plot2=fliplr(avg_plot2); 
                bar3(avg_plot2*100); 
                xlab2=2:max_1; 
                ylab2=max_2:-1:1; 
                set(gca, 'xticklabel', ylab2); 
                set (gca, 'yticklabel',xlab2); 
                xlabel(filename2); 
                ylabel(filename1); 
                zlabel('Percentage'); 
                print (gcf,'-dpng', [ filename1 '_' filename2 '_reg_bar_compare.png']);  %can make pdf, jnp, or jpg 
%                 for k=1:max_1
%                     for l=1:max_2
%                         size=avg_plot(k,l)*10000; 
%                         
%                         %scatter(k,l,size, 'fill'); 
%                     end 
%                 end 
            close all
			end	
		end
	end
end