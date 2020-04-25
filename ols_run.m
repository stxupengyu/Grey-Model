clc,clear
data=xlsread('data_new');
train=data(2:14,:);
test=data(15,:);
Predict=[];
for i=1:24
    predict=olsfun(train(:,i));
    Predict=[Predict predict];
end
x=0:1:23;
plot(x,Predict,x,test);
grid on
xlabel('时间'),ylabel('用电量')%命名
legend('预测值','真实值');
rmse=(sum((Predict-test).^2)/24)^0.5;
mae=sum(abs(Predict-test))/24;
mape=sum(abs(Predict-test)./test)/24*100;







