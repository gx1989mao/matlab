clc;
clf;
clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%                      input                       %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c=3e8;
ak=0.36e-6;%晶格常数
b5=load('E:\耦合腔\六角晶格CCW\simulations\dynamic\0.14&0.52\k-f.txt');
k5= b5(:,1);
ay5=zeros(length(k5),1);
fre5= b5(:,2);
for i5=1:1:length(k5)-1
%            df(i)=fre1(i)*ak/c;%归一化频率
       ay5(i5,1) =abs(c/ak*((k5(i5+1)-k5(i5))/(fre5(i5+1)-fre5(i5))));%ay为慢光因子
       ay5(length(k5),1)=ay5(length(k5)-1,1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b2=load('E:\耦合腔\六角晶格CCW\simulations\dynamic\0.16&0.594/k-f.txt');
k2= b2(:,1);
ay2=zeros(length(k2),1);
fre2= b2(:,2);
for i2=1:1:length(k2)-1
%            df(i)=fre1(i)*ak/c;%归一化频率
       ay2(i2,1) = abs(c/ak*((k2(i2+1)-k2(i2))/(fre2(i2+1)-fre2(i2))));%ay为慢光因子
         ay2(length(k2),1)=ay2(length(k2)-1,1);
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b=load('E:\耦合腔\六角晶格CCW\simulations\dynamic\0.18&0.666\k-f.txt');
k1= b(:,1);
ay=zeros(length(k1),1);
aa=zeros(length(k1),1);
df=zeros(length(k1),1);
fre1= b(:,2);
for i=1:1:length(k1)-1
%            df(i)=fre1(i)*ak/c;%归一化频率
       ay(i,1) = abs(c/ak*((k1(i+1)-k1(i))/(fre1(i+1)-fre1(i))));%ay为慢光因子
         ay(length(k1),1)=ay(length(k1)-1,1);
end

b4=load('E:\耦合腔\六角晶格CCW\simulations\0.20&0.74&0.36_参数研究\waveguide width\deltaz=-0.02a\k-f.txt');
k4= b4(:,1);
ay4=zeros(length(k4),1);
fre4= b4(:,2);
for i4=1:1:length(k4)-1
%            df(i)=fre1(i)*ak/c;%归一化频率
       ay4(i4,1) = abs(c/ak*((k4(i4+1)-k4(i4))/(fre4(i4+1)-fre4(i4))));%ay为慢光因子
       ay4(length(k4),1)=ay4(length(k4)-1,1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
plot(fre5/1e12,ay5,'r-..');
hold on;
plot(fre2/1e12,ay2,'g-..');
hold on;
x=[0.123,0.134,];
y=[8.2,8.93];
xlabel('Freqs (THz)');
ylabel('Group index n_g');
hold on;
plot(fre1/1e12,ay,'m-..');
hold on;
plot(fre4/1e12,ay4,'c-..');
hold on;
legend('Vg=5.0V','Vg=6.4V','Vg=8.3V','Vg=10.0V');


