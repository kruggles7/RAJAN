function [ chi2,p ] = chi2class(X,Y)
%chi2class performs a Chi-Square test of independence between two binary
%vectors.  Inputs two vectors (X,Y) and outputs a chi-square statistic
%(chi2) and p-value (p). 

%find observed values for contingency table 
n=length(X);
ones_X=sum(X); %number of ones 
zeros_X=n-ones_X; %number of zeros
m=length(Y);
ones_Y=sum(Y); %number of ones 
zeros_Y=m-ones_Y; %number of zeros
c1=zeros_X+zeros_Y; %column sum 1
c2=ones_X+ones_Y; %column sum 2

%find the expectation values for each case
E11=(n*c1)/(n+m); %in vector X, 0
E12=(n*c2)/(n+m); %in vector X, 1
E21= (m*c1)/(n+m); %in vector Y, 0
E22= (m*c2)/(n+m); %in vector Y, 1

%find the chi square statistic (chi2)
chi2=((zeros_X-E11)^2)/(E11) +  ((ones_X-E12)^2)/(E12) + ((zeros_Y-E21)^2)/(E21)+((ones_Y-E22)^2)/(E22);

%calculate the p-value using chi2 and degrees of freedom (df)
df=(2-1)*(2-1); 
p=chi2cdf(chi2,df); 

end

