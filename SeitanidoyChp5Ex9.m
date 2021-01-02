n=12;
data=importdata('hospital.txt');
y=data(:,1);
X=[ones(n,1) data(:,2:end)];
[b,~,r,~,stats]=regress(y,X);
se=var(r);
R2=stats(1);
adjR2=1+(n-1)/(n-length(b)+1)*(R2-1);
fprintf('The coefficients are:\n')
disp(b)
fprintf('The varience of the errors is: %.3f\n',se)
fprintf('R^2 = %.3f\nadjR^2 = %.3f\n',R2, adjR2)
mdl=stepwiselm(X,y);
disp(mdl)
mdl1=stepwiselm(X,y,'linear');
disp(mdl1)
