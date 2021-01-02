mu=4;
sigma=0.1;
%το x θα μπορούσε απλα να ειναι το 3.9 στην περιπτωση μας.
x=[3.9,4.0,4.1];%x=[mu-sigma,mu+sigma]
p=normcdf(x,mu,sigma);
d=['The probability of an iron beam being destroyed is: ',num2str(p(1)*100),' %'];
disp(d)
y=norminv(0.01,mu,sigma);
d=['The iron beam length needs to be at least ',num2str(y),' so that less than 1% of the iron beams produced are destroyed.'];
disp(d)

%bonus ερώτημα
p1=p(3)-p(1);
d=['The probability of an iron beam being between [mu-sigma,mu+sigma] is: ',num2str(p1*100),' %'];
disp(d)