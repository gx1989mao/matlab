clc;
clear;
%求解波长和归一化频率a/lamda;
c=3e8;
a=0.40*sqrt(2);%晶格常数
y=20e12:0.01e12:50e12;
lamda=zeros(length(y));
kf=zeros(length(y));
for n=1:1:length(y)
    fre=y(n);
    lamda(n)=c/fre*1e6;%波长为um
    kf(n)=a/lamda(n);%归一化频率
end
aa=lamda(1:1:length(y))';
 save A=0.40_20-50T.txt -ascii aa;
 b=kf(1:1:length(y))';
 save wnorm-A=0.4-20_50T.txt -ascii b;
figure(1);
plot(lamda);
hold on;
figure(2);
plot(kf);
