files1=dir(fullfile('C:','Users','Kelly','Documents','MATLAB', 'rajan', 'programs','categorical_data','parsed_files','*.txt'));
P=length(files1);
cd .. 
cd categorical_data
cd parsed_files

%%%DULL COLORS%%%
dull_blue=[24/255 116/255 205/255];
dull_green=[46/255 139/255 87/255];
orange=[255/255 127/255 0/255];
mauve=[205/255 96/255 144/255];
purple=[153/255 50/255 205/255];
brick=[165/255 42/255 42/255];
dark_green=[0/255 100/255 0/255]; 
blue1=[198/255 226/255 255/255]; 
beige=[255/255 222/255 173/255]; 
dark_blue=[0/255 0/255 128/255]; 
blue7=[0/255 0/255 128/255]; 
C={'purple','orange','dull_green','brick','dull_blue','mauve','dark_blue', 'beige', 'dark_green'}; 
% C={'purple','dull_green','dark_blue','orange','blue1','blue7','beige'};

% % %BLUE COLORS%%%
% blue1=[198/255 226/255 255/255]; 
% blue2=[135/255 206/255 250/255];
% blue3=[51/255 153/255 250/255];
% blue4=[0/255 0/255 255/255]; 
% blue5=[16/255 78/255 139/255]; 
% blue6=[0/255 0/255 205/255]; 
% blue7=[0/255 0/255 128/255]; 
% blue8='k'; 
% C={'blue1','blue2','blue3','blue4','blue5','blue6','blue7','blue8'}; 

% %GREY COLORS%%%
% grey1=[224/255 224/255 224/255]; 
% grey2=[192/255 192/255 192/255];
% grey3=[160/255 160/255 160/255];
% grey4=[128/255 128/255 128/255]; 
% grey5=[96/255 96/255 96/255]; 
% grey6=[64/255 64/255 64/255]; 
% grey7=[32/255 32/255 32/255]; 
% grey8=[0/255 0/255 0/255]; 
% C={'grey1','grey2','grey3','grey4','grey5','grey6','grey7','grey8'}; 
%C=fliplr(C); 

for p=2 %:P
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
    files2=dir(fullfile('C:','Users','Kelly','Documents','MATLAB', 'rajan', 'programs','categorical_data','parsed_files','*.txt'));
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
        if (strcmp(filename2, 'Q29')==1); 
		%if (strcmp(filename1,filename2)==0) % won't compare a question to itself
            c2=length(q2);
            r2=numel(q2)/c2; 
			if (r1==r2)
				r=r1;
                c=c1; 
                max_1=max(max(q1(:,2:c))); 
                max_2=max(max(q2(:,2:c))); 
                xlab=1:1:max_1; 
                ylab=1:1:max_2; 
                quest_plot=zeros(length(xlab),length(ylab),r); 
                 for j=1:r
                    x=q1(j,2:c); 
                    nan_x=find(isnan(x)==1); 
                    x_num=length(x)-numel(nan_x); 
                    y=q2(j,2:c); 
                    nan_y=find(isnan(y)==1); 
                    y_num=length(y)-numel(nan_y); 
                    for k=1:max_1
                        indx=find(x(1,:)==k); 
                        for l=1:max_2
                            indx1=find(y(1,:)==l); 
                            n=intersect(indx,indx1); 
                            quest_plot(k,l,j)=numel(n)/x_num*100; 
                        end 
                    end 
                 end
                bar_y=zeros(r,length(xlab)); 
                g=1; %count the graphs
               for k=1:length(ylab)
                   for j=1:r
                        bar_y(j,:)=quest_plot(:,k,j);
                   end
                   sum_each=sum(bar_y,2); 
                   for j=1:6
                       bar_y(j,:)=bar_y(j,:)/sum_each(j); 
                   end 
                    F=subplot(length(ylab),1,k);
                    bar(bar_y,'stack','LineStyle','none'); %, 'EdgeColor','w','LineWidth',1);
                    P=findobj(gca,'type','patch');
                    %ystr=num2str(k); 
                    %ylabel(ystr); 
                    for m=1:length(P) 
                        varname=eval(C{m}); 
                        set(P(m),'facecolor',varname);
                    end
                    %hold on
                    x=1:6;  
                    ylimit=max(sum_each); 
                    ylimit=ylimit+0.2*ylimit; 
                    adjusted_y=sum_each/ylimit;
                    %plot(x,adjusted_y,'-ko','MarkerFaceColor','w', 'LineWidth',1); 
                    %hold off; 
                    %set(gca, 'YTick',1/2); 
                    %ylabels=num2str(ylimit/2);
                    set(gca,'YTickLabel',[]); 
                    set(gca, 'YTick',[]); 
                    
                    
                    %find the max to set the y-limits
                    max_mat=sum(bar_y,2); 
                    max_mat=max(max_mat);
                    max_mat=max_mat+0.20*max_mat; 
                    ylim([0 1]); %([0 max_mat]); 
                    xlim([0 length(xlab)+2]); 
                    if g>1
                        f2=F; 
                        linkaxes([f1 f2],'x'); %make y axis the same
                        pos1=get(f1,'Position'); %find the current position [x,y,width,height]
                        pos2=get(f2,'Position'); %find the current position [x,y,width,height]
                        pos2(2)=pos1(2) - pos2(4)-0.01; %move the second so it touches the first 
                        set (f2,'Position',pos2); 
                        set(f2, 'XTickLabel',[]); 
                        set(f2, 'XTick',[]); 
                        f1=f2; 
                    else 
                        f1=F; 
                        g=g+1; 
                        set(f1, 'XTickLabel',[]); 
                        set(f1, 'XTick',[]); 
                    end 
               end
               set (f2, 'Xtick',1:r); 
               set(f2,'XTickLabel',{'2001', '2003', '2005','2007','2009','2011'}); 
               saveas (gcf, [ filename1 '_' filename2 '_bar_ratio.fig']);  %can make pdf, jnp, or jpg 
               %close all
			end	
		end
	end
end