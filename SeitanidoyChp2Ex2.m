y=zeros(1,1000);
for i=1:1000
  x=rand;
  y(i)=-log(1-x);
end
figure('Name','Άσκηση 2')
hist(y)
ylabel('Συχνότητα εμφάνισης')
hold on
x=-2:0.5:10;
y1=exp(-x);
yyaxis right
plot(y1,'r')
xlim([0 10])
xlabel('Τυχαίοι αριθμοί από εκθετική κατανομή')
ylabel('fx=e^-x')