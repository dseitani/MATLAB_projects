%import data
dat = importdata('forestfires.dat');
txt=["X","Y","month","day","FFMC","DMC","DC","ISI","temp","RH","wind","rain"];
n=length(txt);
len = length(dat);

Y = dat(:,13);
fprintf('Areas dependance on the other indexes.\n\n')
for i=1:n
    %linear regression
    X1 = [ones(len,1) dat(:,i)];
    %2 order regression
    X2 = [ones(len,1) dat(:,i) dat(:,i).^2];
    
    [~,~,~,~,stats1] = regress(Y,X1);
    R21 = stats1(1);
    adjR21 = 1+(n-1)/(n-2)*(R21-1);
    fprintf('For %s (linear regression): adjR2 = %.4f\n',txt(i),adjR21)
    
    [~,~,~,~,stats2] = regress(Y,X2);
    R22 = stats2(1);
    adjR22 = 1+(n-1)/(n-2)*(R22-1);
    fprintf('(2 order regression): adjR2 = %.4f\n\n',adjR22)
end

% Conclusion: We see that the adjR2 is a little bigger for linear
% regression but all the adjR2 are almost equal to 0.1 which is small so we can
% safely say there is no real dependaance between the area and the other
% indexes.