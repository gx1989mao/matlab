clc;
clf;
clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%                      input                       %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c=3e8;
ak=0.24e-6;%�������޸�
b5=load('E:\���ǻ\�������ǻ�о�\final result\0.52eV&0.14eV&OK_�����о�\rj\rj=0.06A\k-f.txt');
k5= b5(:,1);
ay5=zeros(length(k5),1);
fre5= b5(:,2);
for i5=1:1:length(k5)-1
%            df(i)=fre1(i)*ak/c;%��һ��Ƶ��
       ay5(i5,1) = abs((c/ak*((k5(i5+1)-k5(i5))/(fre5(i5+1)-fre5(i5)))));%ayΪ��������
       ay5(length(k5),1)=ay5(length(k5)-1,1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b2=load('E:\���ǻ\�������ǻ�о�\final result\0.52eV&0.14eV&OK_�����о�\rj\rj=0.08A\k-f.txt');
k2= b2(:,1);
ay2=zeros(length(k2),1);
fre2= b2(:,2);
for i2=1:1:length(k2)-1
%            df(i)=fre1(i)*ak/c;%��һ��Ƶ��
       ay2(i2,1) = abs(c/ak*((k2(i2+1)-k2(i2))/(fre2(i2+1)-fre2(i2))));%ayΪ��������
         ay2(length(k2),1)=ay2(length(k2)-1,1);
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b3=load('E:\���ǻ\�������ǻ�о�\final result\0.52eV&0.14eV&OK\k-f.txt');
k3= b3(:,1);
ay3=zeros(length(k3),1);
fre3= b3(:,2);
for i3=1:1:length(k3)-1
%            df(i)=fre1(i)*ak/c;%��һ��Ƶ��
       ay3(i3,1) = abs(c/ak*((k3(i3+1)-k3(i3))/(fre3(i3+1)-fre3(i3))));%ayΪ��������
         ay3(length(k3),1)=ay3(length(k3)-1,1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b=load('E:\���ǻ\�������ǻ�о�\final result\0.52eV&0.14eV&OK_�����о�\rj\rj=0.13A\k-f.txt');
k1= b(:,1);
ay=zeros(length(k1),1);
aa=zeros(length(k1),1);
df=zeros(length(k1),1);
fre1= b(:,2);
for i=1:1:length(k1)-1
%            df(i)=fre1(i)*ak/c;%��һ��Ƶ��
       ay(i,1) = abs(c/ak*((k1(i+1)-k1(i))/(fre1(i+1)-fre1(i))));%ayΪ��������
         ay(length(k1),1)=ay(length(k1)-1,1);
end

b4=load('E:\���ǻ\�������ǻ�о�\final result\0.52eV&0.14eV&OK_�����о�\rj\rj=0.16A\k-f.txt');
k4= b4(:,1);
ay4=zeros(length(k4),1);
fre4= b4(:,2);
for i4=1:1:length(k4)-1
%            df(i)=fre1(i)*ak/c;%��һ��Ƶ��
       ay4(i4,1) = abs(c/ak*((k4(i4+1)-k4(i4))/(fre4(i4+1)-fre4(i4))));%ayΪ��������
       ay4(length(k4),1)=ay4(length(k4)-1,1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
% plot(fre5/1e12,ay5,'r-..');
% hold on;
% plot(fre2/1e12,ay2,'g-..');
% hold on;
% plot(fre3/1e12,ay3,'k-..');
% xlabel('Wave number (2��/a)');
% ylabel('Freqs (THz)');
% hold on;
% x=[0.123,0.134,];
% y=[8.2,8.93];
% line(x,y);
% hold on;
% xlabel('Freqs (THz)');
% ylabel('Group index n_g');
% hold on;
% plot(fre1/1e12,ay,'m-..');
% hold on;
plot(fre4/1e12,ay4,'c-..');
hold on;
legend('R=0.06a','R=0.08a','R=0.10a','R=0.13a','R=0.16a');


