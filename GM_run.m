clc,clear
data=xlsread('data1999');
train=data(10:21,:);
test=data(22,:);
Predict=[];
for i=1:48
    predict=gmfun(train(:,i));
    Predict=[Predict predict];
end
x=0:0.5:23.5;
plot(x,Predict,x,test);
grid on
xlabel('时间'),ylabel('用电量')%命名
legend('预测值','真实值');
rmse=(sum((Predict-test).^2)/48)^0.5
mae=sum(abs(Predict-test))/48
mape=sum(abs(Predict-test)./test)/48*100







