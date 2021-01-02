sigma_l=5; sigma_w=5;
l=500; w=300;
sigma_s=sqrt((w^2*sigma_l^2)+(l^2*sigma_w^2));
fprintf('The uncertainty of the surface measurment for length=%dm and width=%dm is: %.2fm\n',l,w,sigma_s)
%plot ta w kai l mesa sta oria poy vrika 
w_max=sigma_s/sigma_l;
l_max=sqrt(sigma_s^2/sigma_w^2);
l_min=sqrt((sigma_s^2-w_max^2*sigma_l^2)/sigma_w^2);
fprintf('For this uncertainty the width can take values (0,%.2f) and the length is given by the equation:\n',w_max)
fprintf('l=sqrt((sigma_s^2-w^2*sigma_l^2)/sigma_w^2)\n')
fprintf('The maximum length is %.2f and the minimun length is %.2f\n',l_max,l_min)
w=100:10:500; l=300:10:500;
[X,Y]=meshgrid(l,w);
S=sqrt((Y.^2.*sigma_l^2)+(X.^2.*sigma_w^2));
clf
surf(X,Y,S)
xlabel('length')
ylabel('width')
zlabel('uncertainty')
title('Surface plot of uncertainty')