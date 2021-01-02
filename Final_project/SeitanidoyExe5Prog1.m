%import data
dat = importdata('forestfires.dat');
% 9:temp, 10:RH , 11:wind
len = length(dat);

%random sample
indx = randperm(len,40);
data = dat(indx,:);
m = length(data);

X = [ones(m,1) data(:,9)];
YRH = data(:,10);
YW = data(:,11);

%regression RH-temp
[brh,~,rrh,~,statsrh] = regress(YRH,X);
R2rh = statsrh(1);
adjR2rh = 1+(m-1)/(m-2)*(R2rh-1);
fprintf('RH-temp: y = %.3f+(%.3f)*x\n',brh(1),brh(2))
fprintf('RH-temp: R2 = %.4f, adjR2 = %.4f\n',R2rh,adjR2rh)
yrh = X*brh;
%erh = rrh
erh = YRH -yrh;
serh = sqrt((1/(m-2))*(sum((erh).^2)));
eirh = erh/serh;
figure(1)
clf
scatter(yrh,eirh)
hold on
ax = axis;
xlabel('y')
ylabel('ei')
title('Diagnostic Plot: RH - temp')
plot([ax(1) ax(2)],[1 1]*norminv(0.975),'g')
plot([ax(1) ax(2)],[-1 -1]*norminv(0.975),'g')
hold off
fprintf('\n')

%regression wind-temp
[bw,~,rw,~,statsw] = regress(YW,X);
R2w = statsw(1);
adjR2w = 1+(m-1)/(m-2)*(R2w-1);
fprintf('Wind-temp: y = %.3f+(%.3f)*x\n',bw(1),bw(2))
fprintf('Wind-temp: R2 = %.4f, adjR2 = %.4f\n',R2w,adjR2w)
yw = X*bw;
%ew = rw
ew = YW -yw;
sew = sqrt((1/(m-2))*(sum((ew).^2)));
eiw = ew/sew;
figure(2)
clf
scatter(yw,eiw)
xlabel('y')
ylabel('ei')
title('Diagnostic Plot: wind - temp')
hold on
ax = axis;
plot([ax(1) ax(2)],[1 1]*norminv(0.975),'g')
plot([ax(1) ax(2)],[-1 -1]*norminv(0.975),'g')
hold off

% Conclusion: RH-temp regression is better because R2/adjR2
% are bigger when compared with wind-temp regression.
% The linear regression model is  sufficient for both cases, as we see in
% both diagnostic plots that the residuals that are outside of the 95% normal
% distribution limits are less than 5%.