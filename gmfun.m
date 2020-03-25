function f =fun(N)
x0=N';
b=length(x0);
for i=2:b
    A(i)=x0(i)/x0(i-1);        %级比计算
end
B=A(2:b);                        %级比        
if B>exp(-2/9)&B<exp(2/9)        %级比可行性分析（满足级比∈（exp(-2/(n+1),exp(2/(n+1)))）时方可进行，否者进行数据处理）      
x1=cumsum(x0);                   %一次累加值
for i=1:b-1
    ave(i)=1/2*(x1(i)+x1(i+1));
end
ave;                        
z=ave';                             %平均值 @取0.5
a=ones(b-1,1);
B=[-z,a];                  %数据矩阵B
Y=x0;
Y(:,1)=[];                   %数据向量（由矩阵x0删除第一列得）
c=B';                       %g=inv((B'B))B'Y  (求解a u)
s=c*B;
d=inv(s);
f=d*c;
g=f*Y';                          %g=(a,u)'
h=g(1,1);                    %h实际为a
u=g(2,1);
j=u/h;                       %预测值=（x(1)-u/h）e +u/h
k=x0(1,1);
l=k-j;
for i=1:(b-1)
    yuc(i)=l*exp(-h*i)+j;                            
end                             %预测模型表达式
yuc;
x0(1,1);
yuce=[x0(1,1) yuc];              %没有累减时的预测值
for i=1:b-1
    yce(i)=yuce(1,i+1)-yuce(1,i);
end
yce;                              %缺少第一个数据的预测数列
x0(1,1);
ycz=[x0(1,1) yce];                  %最终预测值(只是对原数据的拟合值)
ycz;
for i=1:b                           %后验差校验
    cancha(i)=x0(i)-ycz(i);
end
cancha;                              %残差（初始值-预测值）
x2=mean(x0);                         %初始值的平均值
x3=mean(cancha);                     %残差平均值
s=sum((x0-x2).^2)/b;                  %实际值方差
t=sum((cancha-x3).^2)/b;              %残差方差
s1=sqrt(s);                            %实际值均方差
s2=sqrt(t);                            %残差均方差
m=s2/s1;                              %后验差比值即预测值与实际值的离散程度（越小越好）
s0=0.6745*s1;                           %给定值0.6745s1
p1=abs(cancha-x3);                        %小误差  p=p{|ε(k)-ε平均值|<0.6745s1}
n=0;                                   %计算p1<s0的个数n
for i=1:b
    if p1(i)<s0
        n=n+1;
    else n=n;
    end
end
n;
p=n/b;                                   %小误差概率（越大越好）
if p>0.95&m<0.35
    %预测精度好(一级)')
    H=0;
elseif p<=0.7&m>=0.65
    %预测精度不合格,进行模型改进')
    H=1;
    
ca0=abs(cancha(1:b-2));
x11=cumsum(ca0);                   
b1=length(ca0);
for i=1:b1-1
    ave1(i)=1/2*(x11(i)+x11(i+1));
end
ave1 ;                      
z1=ave1';                             %平均值 @取0.5
a1=ones(b1-1,1);
B1=[-z1,a1] ;                 %数据矩阵B
Y1=ca0;
Y1(:,1)=[]  ;                 %数据向量（由矩阵x0删除第一列得）
c1=B1';                       %g=inv((B'B))B'Y  (求解a u)
s1=c1*B1;
d1=inv(s1);
f1=d1*c1;
g1=f1*Y1';                          %g=(a,u)'
h1=g1(1,1);                    %h实际为a
u1=g1(2,1);
j1=u1/h1 ;                      %预测值=（x(1)-u/h）e +u/h
k1=ca0(1,1);
l1=k1-j1;
for i=1:(b1-1)
    yuc1(i)=l1*exp(-h1*i)+j1;                            
end                             %预测模型表达式
yuc1;
ca0(1,1);
yuce1=[ca0(1,1) yuc1];              %没有累减时的预测值
for i=1:b1-1
    yce1(i)=yuce1(1,i+1)-yuce1(1,i);
end
yce1;                              %缺少第一个数据的预测数列
ca0(1,1);
ycz1=[ca0(1,1) yce1] ;                 %最终预测值(只是对原数据的拟合值)
ycz1;
o1=1;   %input('输入预测个数')
for i=b1:b1+o1-1
    yuc1(i)=l1*exp(-h1*i)+j1;                            
end
yuc1;
yucezhi11=yuc1(b1-1:b1+o1-1) ;             %没有累减时的未来预测值
for i=1:o1
    yucezhi21(i)=yucezhi11(i+1)-yucezhi11(i);
end
yucezhi21 ;                            %最终预测值

elseif p>0.8&m<0.5
    %'预测精度合格（二级）')
    H=0;
else
    %'预测精度勉强合格')
    H=0;
end
o=1;%input('输入预测个数');
for i=b:b+o-1
    yuc(i)=l*exp(-h*i)+j;                            
end
yuc;
yucezhi1=yuc(b-1:b+o-1);              %没有累减时的未来预测值
for i=1:o
    yucezhi2(i)=yucezhi1(i+1)-yucezhi1(i);
end
yucezhi2 ;                             %最终预测值
else                                   %级比不满足要求，进行数据处理
    for i=1:b
        y0(i)=log10(log10(x0(i)));
    end
    H=2;
    y0;                                %进行两次对数处理后的原始数列
end
switch H
 case 0
    yc=yucezhi2;
 case 1
    yc=yucezhi21+yucezhi2;         %最最终预测值
 case 2
    yc=mean(x0);
end

f=yc;

end