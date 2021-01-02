n=8;
dist=[2,3,8,16,32,48,64,80]; % distance in km
perc=[98.2,91.7,81.3,64.0,36.4,32.6,17.1,11.3]; %percentage of usage potential
figure(1)
clf
scatter(dist,perc,'filled','r')
hold on
xlabel('distance (km)')
ylabel('percentage of usage potential')
title('Scatter diagram')
X=mean(dist);
Y=mean(perc);
sx=var(dist); sy=var(perc); sxy=cov(dist,perc);
b1=sxy(1,2)/sx;
b0=Y-b1*X;
fprintf('Least squares: y=%.2fx+%.2f\n',b1,b0)
y=b1*dist+b0;
plot(dist,y)
hold off
se=sqrt((n-1)/(n-2)*(sy-b1^2*sxy(1,2)));
ei=perc-y;
e=ei/se;
figure(2)
clf
scatter(y,e,'filled')
xlabel('yi')
ylabel('ei*')
title('Diagnostic plot')
fprintf('For the shape of the diagnostic plot we detect that the correlation is not linear.\n')
fprintf('Prediction interval for x=25000km: [%.3f,%.3f]\n',...
    (b1*25000+b0)-tinv(0.975,n-2)*se*sqrt(1+1/n+(25000-X).^2/sx),...
    (b1*25000+b0)+tinv(0.975,n-2)*se*sqrt(1+1/n+(25000-X).^2/sx))