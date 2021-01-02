n=100;
Data=importdata('lightair.dat');
air=Data(:,1);
light=Data(:,2);

%question a
figure(1)
clf
scatter(air,light)
hold on
xlabel('air density')
ylabel('light speed')
title('scatter diagram')
X=mean(air); Y=mean(light);
SX=sum(air.^2); SY=sum(light.^2);
SXY=sum(air.*light);
r=(SXY-n*X.*Y)./(sqrt((SX-n.*X.^2).*(SY-n*Y.^2)));
fprintf('The correlation coefficient is %.2f\n',r)

%question b
sx=var(air); sy=var(light); sxy=cov(air,light);
b1=sxy(1,2)/sx;
b0=Y-b1*X;
fprintf('Least squares: y=%.2fx+%.2f\n',b1,b0)
y=b1*air+b0;
se=sqrt((n-1)/(n-2)*(sy-b1^2*sxy(1,2)));
cib1=[b1-tinv(0.975,n-2)*se/sqrt(sx),b1+tinv(0.975,n-2)*se/sqrt(sx)];
cib0=[b0-tinv(0.975,n-2)*se*sqrt(1/n+X^2/sx),b0+tinv(0.975,n-2)*se*sqrt(1/n+X^2/sx)];
fprintf('The CI for b1 is: [%.3f,%.3f]\n',cib1(1),cib1(2))
fprintf('The CI for b0 is: [%.3f,%.3f]\n',cib0(1),cib0(2))

%question c
plot(air,y)
cimy=[y-tinv(0.975,n-2)*se*sqrt(1/n+(air-X).^2/sx),y+tinv(0.975,n-2)*se*sqrt(1/n+(air-X).^2/sx)];
ciy=[y-tinv(0.975,n-2)*se*sqrt(1+1/n+(air-X).^2/sx),y+tinv(0.975,n-2)*se*sqrt(1+1/n+(air-X).^2/sx)];
plot(air,cimy,'Color','g')
plot(air,ciy,'Color','m')
hold off
fprintf('For air density=1.29 kg/m^3 we predict that the light speed is: %.2f km/sec\n',(b1*1.29+b0))
fprintf('The prediction interval for the mean of light speed is: [%.3f,%.3f]\n',...
    (b1*1.29+b0)-tinv(0.975,n-2)*se*sqrt(1/n+(1.29-X).^2/sx),...
    (b1*1.29+b0)+tinv(0.975,n-2)*se*sqrt(1/n+(1.29-X).^2/sx))
fprintf('The prediction interval for a measurement of light speed is: [%.3f,%.3f]\n',...
    (b1*1.29+b0)-tinv(0.975,n-2)*se*sqrt(1+1/n+(1.29-X).^2/sx),...
    (b1*1.29+b0)+tinv(0.975,n-2)*se*sqrt(1+1/n+(1.29-X).^2/sx))

%question d
bhta1=-(299792.458*0.00029)/1.29;
bhta0=299792.458;
fprintf('The real equation for the correlation between air density and light speed is: c=%.3fd+%.3f.\n',bhta1,bhta0)
if cib1(1)<bhta1 && bhta1<cib1(2)
    fprintf('Bhta1 coefficient is in the ci for b1.\n')
else
    fprintf('Bhta1 coefficient is not in the ci for b1.\n')
end
if cib0(1)<bhta0 && bhta0<cib0(2)
    fprintf('Bhta0 coefficient is in the ci for b0.\n')
else
    fprintf('Bhta0 coefficient is not in the ci for b0.\n')
end
cm=(bhta1.*air+bhta0);
if (b1*1.29+b0)-tinv(0.975,n-2)*se*sqrt(1/n+(1.29-X).^2/sx)<cm
    if cm<(b1*1.29+b0)+tinv(0.975,n-2)*se*sqrt(1/n+(1.29-X).^2/sx)
        fprintf('The real mean values of the light speed are in the prediction interval.\n')
    else
        fprintf('The real mean values of the light speed are not in the prediction interval.\n')
    end
end