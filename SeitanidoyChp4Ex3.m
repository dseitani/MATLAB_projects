M=1000;
Vm=77.78; Vs=0.71;
Im=1.21; Is=0.071;
fm=0.283; fs=0.017;
Pm=Vm*Im*cos(fm);
Ps=sqrt((Im^2*cos(fm)^2)*Vs^2+(Vm^2*cos(fm)^2)*Is^2+(Vm^2*Im^2*sin(fm)^2)*fs^2);
fprintf('The theoretical value of the uncertainty of P is: %.3f\n',Ps)
Vx=normrnd(Vm,Vs,[1,M]);
Ix=normrnd(Im,Is,[1,M]);
fx=normrnd(fm,fs,[1,M]);
Px=Vx.*Ix.*cos(fx);
fprintf('The uncertainty in the measurment of P for independent variables is: %.3f\n',std(Px))
figure('Name','Independent variables')
hist(Px)
rho=0.5; sigma=[Vs^2 rho*Vs*fs; rho*Vs*fs fs^2]; mu=[Vm,fm];
r=mvnrnd(mu,sigma,M);
Px=r(:,1).*Ix'.*cos(r(:,2));
figure('Name','Codependent variables')
hist(Px)
%The theoretical value of uncertainty for codependent
fprintf('The uncertainty in the measurment of P for codependent variables is: %.3f\n',std(Px))