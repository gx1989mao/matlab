clc;
clf;
clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%                      input                       %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b=load('E:\first paper continue\45��30T\pm-30T/k-f.txt');
c=3e8;
ak=0.40e-6;%������
k1= b(:,1);%��һ��k
ay=zeros(length(k1),1);
aa=zeros(length(k1),1);
df=zeros(length(k1),1);
fre1= b(:,2);
for i=1:1:length(k1)-1;
%            df(i)=fre1(i)*ak/c;%��һ��Ƶ��
       ay(i,1) = abs(c/ak*((k1(i+1)-k1(i))/(fre1(i+1)-fre1(i))));%ayΪ��������
         ay(length(k1),1)=ay(length(k1)-1,1);
%     vg'=()/();%һ��ɫɢ
    
end
figure(1);
% set(gca,'FontSize',14);
plot(k1,fre1/1e12,'r-.o');
xlabel('Wave number (2��/a)');
ylabel('Freqs (THz)');
hold on;
% line([0.04 0.045],[30 33.75]); 
% hold on;
%  axis([0 0.45 34 28]);
% hole on;
figure(2);
plot(fre1/1e12,ay,'r-.o');
xlabel('Freqs (THz)');
ylabel('Group index n_g');
hold on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
