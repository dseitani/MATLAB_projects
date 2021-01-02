%import data
dat = importdata('forestfires.dat');
txt=["X","Y","month","day","FFMC","DMC","DC","ISI","temp","wind","rain","area"];
len = length(dat);

%split data into two groups
TS = dat(1:round(len*0.7),:);
VS = dat(round(len*0.7)+1:end,:);
n = length(TS);
m = length(VS);

% full regression model

% b coefficients calculation on training set (TS)
YTS = TS(:,10);
XTS = [ones(n,1) TS(:,1:9) TS(:,11:13)];
b = regress(YTS,XTS);
b0 = b(1);

%residuals and R2 calculation on validation set (VS)
YVS = VS(:,10);
XVS =[ones(m,1) VS(:,1:9) VS(:,11:13)];
yif = XVS*b;
eif = YVS-yif;
R2f = 1-(sum((eif).^2))/(sum((YVS-mean(YVS)).^2));
k = length(b);
adjR2f = 1+(m-1)/(m-(k+1))*(R2f-1);


%stepwise model

% b coefficients calculation on training set (TS)
XVS = [VS(:,1:9) VS(:,11:13)];
[b,~,~,inmodel,stats] = stepwisefit(XTS,YTS);
%residuals and R2 calculation on validation set (VS)
yis = [ones(m,1) XVS] *(b.*inmodel');
eis = YVS-yis;
k = sum(inmodel); 
R2s = 1-(sum((eis).^2))/(sum((YVS-mean(YVS)).^2));
adjR2s = 1+(m-1)/(m-(k+1))*(R2s-1);

fprintf('Full regression model: R2 = %.4f, adjR2 = %.4f\n',R2f,adjR2f)
fprintf('Stepwise regression model: R2 = %.4f, adjR2 = %.4f\n',R2s,adjR2s)
