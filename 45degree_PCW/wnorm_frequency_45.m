clc;
clear;
%��Ⲩ���͹�һ��Ƶ��a/lamda;
c=3e8;
a=0.40*sqrt(2);%������
y=20e12:0.01e12:50e12;
lamda=zeros(length(y));
kf=zeros(length(y));
for n=1:1:length(y)
    fre=y(n);
    lamda(n)=c/fre*1e6;%����Ϊum
    kf(n)=a/lamda(n);%��һ��Ƶ��
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
