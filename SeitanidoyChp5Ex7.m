n=32;
R=[0.76; 0.86; 0.97 ;1.11; 1.45; 1.67; 1.92; 2.23; 2.59; 3.02; 3.54; 4.16;...
    4.91; 5.83; 6.94; 8.31; 10.00; 12.09; 14.68; 17.96; 22.05; 27.28; ...
    33.89; 42.45; 53.39; 67.74; 86.39; 111.30; 144.00; 188.40; 247.50; 329.20];
T_C=[110; 105; 100; 95; 85; 80; 75; 70; 65; 60; 55; 50; 45; 40; 35; 30; 25; 20; 15; 10; 5; ...
    0; -5; -10; -15; -20; -25; -30; -35; -40; -45; -50];
T=273.15+T_C;
figure(1)
clf
hold on
scatter(log(R),1./T)
title('Scatter plot for R,T')

%first order polynomial
b1=polyfit(log(R),1./T,1);
y1=b1(2)+b1(1)*R;
plot(log(R),y1)
d1=['y=',num2str(b1(2)),'+',num2str(b1(1)),'x'];
ei=T-y1;
se=sqrt(1/(n-2)*(sum(ei.^2)));
e=ei/se;
figure(2)
clf
scatter(y1,e,'filled')
title('Diagnostic plot, 1st order')

%second order polynomial
b2=polyfit(log(R),1./T,2);
y2=b2(3)+b2(2)*R+b2(1)*R.^2;
figure(1)
plot(log(R),y2)
d2=['y=',num2str(b2(3)),'+',num2str(b2(2)),'x','+',num2str(b2(1)),'x^2'];
ei=T-y2;
se=sqrt(1/(n-3)*(sum(ei.^2)));
e=ei/se;
figure(3)
clf
scatter(y2,e,'filled')
title('Diagnostic plot, 2nd order')

%third order polynomial
b3=polyfit(log(R),1./T,3);
y3=b3(4)+b3(3)*R+b3(2)*R.^2+b3(1)*R.^3;
figure(1)
plot(log(R),y3)
d3=['y=',num2str(b3(4)),'+',num2str(b3(3)),'x','+',num2str(b3(2)),'x^2','+',num2str(b3(1)),'x^3'];
ei=T-y3;
se=sqrt(1/(n-4)*(sum(ei.^2)));
e=ei/se;
figure(4)
clf
scatter(y3,e,'filled')
title('Diagnostic plot, 3rd order')

%fourth order polynomial
b4=polyfit(log(R),1./T,4);
y4=b4(5)+b4(4)*R+b4(3)*R.^2+b4(2)*R.^3+b4(1)*R.^4;
figure(1)
plot(log(R),y4)
d4=['y=',num2str(b4(5)),'+',num2str(b4(4)),'x','+',num2str(b4(3)),'x^2','+',num2str(b4(2)),'x^3',...
    '+',num2str(b4(1)),'x^4'];
legend('data',d1,d2,d3,d4)
ei=T-y4;
se=sqrt(1/(n-5)*(sum(ei.^2)));
e=ei/se;
figure(5)
clf
scatter(y4,e,'filled')
title('Diagnostic plot, 4rd order')
