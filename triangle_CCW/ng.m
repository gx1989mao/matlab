clc;
clf;
clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%                      input                       %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b=load('E:\耦合腔\六角晶格CCW\simulations\0.20&0.74&0.36_c初步仿真\k-f.txt');
c=3e8;
ak=0.36e-6;%晶格常数
k1= b(:,1);
ay=zeros(length(k1),1);
aa=zeros(length(k1),1);
df=zeros(length(k1),1);
fre1= b(:,2);
for i=2:1:length(k1)
%            df(i)=fre1(i)*ak/c;%归一化频率
       ay(i,1) = abs(c/ak*((k1(i-1)-k1(i))/(fre1(i-1)-fre1(i))));%ay为慢光因子
         ay(1,1)=ay(2,1);
%     vg'=()/();%一阶色散
    
end
figure(1);
% set(gca,'FontSize',14);
plot(k1,fre1/1e12,'r-.o');
xlabel('Wave number (2π/a)');
ylabel('Freqs (THz)');
hold on;
% line([0.123 0.134],[8 8.93]); 
hold on;
% % % axis([8.08e12 8.92e12 10 70]);
% % hole on;
figure(2);
plot(fre1/1e12,ay,'r-.o');
xlabel('Freqs (THz)');
ylabel('Group index n_g');
hole on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
