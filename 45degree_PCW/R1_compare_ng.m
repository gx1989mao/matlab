clc;
clf;
clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%                      input                       %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c=3e8;
ak=0.4e-6;%晶格常数
b5=load('E:\first paper continue\2016-4-24\pm-参数优化\R1\R1=0.20a\k-f.txt');
k5= b5(:,1);
ay5=zeros(length(k5),1);
fre5= b5(:,2);
for i5=1:1:length(k5)-1
%            df(i)=fre1(i)*ak/c;%归一化频率
       ay5(i5,1) = c/ak*((k5(i5+1)-k5(i5))/(fre5(i5+1)-fre5(i5)));%ay为慢光因子
       ay5(length(k5),1)=ay5(length(k5)-1,1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b2=load('E:\first paper continue\2016-4-24\pm-参数优化\R1\R1=0.18a\k-f.txt');
k2= b2(:,1);
ay2=zeros(length(k2),1);
fre2= b2(:,2);
for i2=1:1:length(k2)-1
%            df(i)=fre1(i)*ak/c;%归一化频率
       ay2(i2,1) = c/ak*((k2(i2+1)-k2(i2))/(fre2(i2+1)-fre2(i2)));%ay为慢光因子
         ay2(length(k2),1)=ay2(length(k2)-1,1);
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b3=load('E:\first paper continue\2016-4-24\pm-30T\k-f.txt');
k3= b3(:,1);
ay3=zeros(length(k3),1);
fre3= b3(:,2);
for i3=1:1:length(k3)-1
%            df(i)=fre1(i)*ak/c;%归一化频率
       ay3(i3,1) = c/ak*((k3(i3+1)-k3(i3))/(fre3(i3+1)-fre3(i3)));%ay为慢光因子
         ay3(length(k3),1)=ay3(length(k3)-1,1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b=load('E:\first paper continue\2016-4-24\pm-参数优化\R1\R1=0.12a\k-f.txt');
k1= b(:,1);
ay=zeros(length(k1),1);
aa=zeros(length(k1),1);
df=zeros(length(k1),1);
fre1= b(:,2);
for i=1:1:length(k1)-1
%            df(i)=fre1(i)*ak/c;%归一化频率
       ay(i,1) = c/ak*((k1(i+1)-k1(i))/(fre1(i+1)-fre1(i)));%ay为慢光因子
         ay(length(k1),1)=ay(length(k1)-1,1);
end

b4=load('E:\first paper continue\2016-4-24\pm-参数优化\R1\R1=0.09a\k-f.txt');
k4= b4(:,1);
ay4=zeros(length(k4),1);
fre4= b4(:,2);
for i4=1:1:length(k4)-1
%            df(i)=fre1(i)*ak/c;%归一化频率
       ay4(i4,1) = c/ak*((k4(i4+1)-k4(i4))/(fre4(i4+1)-fre4(i4)));%ay为慢光因子
       ay4(length(k4),1)=ay4(length(k4)-1,1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
plot(fre5/1e12,ay5,'r-..');
hold on;
plot(fre2/1e12,ay2,'g-..');
hold on;
plot(fre3/1e12,ay3,'k-..');
% xlabel('Wave number (2π/a)');
% ylabel('Freqs (THz)');
% hold on;
% x=[0.123,0.134,];
% y=[8.2,8.93];
% line(x,y);
hold on;
xlabel('Freqs (THz)');
ylabel('Group index n_g');
hold on;
plot(fre1/1e12,ay,'m-..');
hold on;
plot(fre4/1e12,ay4,'c-..');
hold on;
legend('R1=0.20a','R1=0.18a','R1=0.15a','R1=0.12a','R1=0.09a');

