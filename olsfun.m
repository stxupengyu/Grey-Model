function f =fun(N)
x0=N';
A=ones(13,4);
X=[1 2 3 4 5 6 7 8  9 10 11 12 13];
Y=N;
for k=0:3
net1=0.0;
for i=1:13
net1=net1+X(i)^k*A(i,k+1);
end
net2=0.0;
for i=1:13
net2=net2+X(i)^(k+1)*A(i,k+1);
end
net3=0.0;
for i=1:13
net3=net3+X(i)^(k+2)*A(i,k+1);
end
net4=0.0;
for i=1:13
net4=net4+X(i)^(k+3)*A(i,k+1);
end
net5=0.0;
for i=1:13
net5=net5+X(i)^k*Y(i)*A(i,k+1);
end
a(k+1)=net1;
b(k+1)=net2;
c(k+1)=net3;
d(k+1)=net4;
e(k+1)=net5;
end
B=cat(2,a',b',c',d');
Y=[e'];
C=inv(B);
D=C*Y;
O=[13^0 13^1 13^2 13^3]*D;


f=O;

end