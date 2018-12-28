clc;
% clf;
clear;

a = 50e-9;%半径
der = 4*a;
r1 = a+der;%核心半径
cir = 12;%除去core之外cir圈
R = cir*der+r1;%区域半径
corenum = 7;%%% the points number of core circle
fre = 20e12;
x = 1:cir;

miub = 0.8;
miud = 0.4;

N1ori = beta(miub,fre);   %7
N2ori = beta(miud,fre);   %36
N = zeros(30,1);
S1 = zeros(30,1);
for i = 1:1:cir
%     F1 = N1ori*2/(1+((r1+(i-1)*der+0.5*der)/R)^2);%当前环等效折射率maxwell   以此计算点分布
     F1 = N1ori*sqrt(2-((r1+(i-1)*der+0.5*der)/R)^2);%当前环等效折射率luneburg
    ring = (r1+i*der)^2-(r1+i*der-der)^2;%当前环面积
    N(i) = (F1-N1ori)*ring/a^2/(N2ori-N1ori);%当前环点数
    S1(i) = F1;
end

M = [6
15
23
30
36
40
41
39
34
25
10
];

figure();
plot(1:11,M(1:11,1));
hold on;
plot(x,N(x,1),'b*');
hold on;
plot(x,2*pi*(r1+der*x)/(2*a)/2,'r+');

figure();
plot(x,S1(x,1),'b');

lambdaG = 3e8/fre/N1ori/1e-9;
for i=1:11
    K(i) = M(i)*a^2/((i*der)^2-(i*der-der)^2);
end
% figure();
% plot(x,N(x,1));hold on;
% plot(x,2*pi*(r1+der*x)/(2*a)/2,'r+');hold on;
% 
% figure();
% subplot(2,1,1);
% plot(x,S1(x,1),'b');
% hold on;
% plot(x,S2(x,1),'r');
% hold on;
% subplot(2,1,2);
% plot(x,N(x,1));
% hold on;
% plot(x,N(x,1),'b*');
% hold on;
% plot(x,2*pi*(r1+der*x)/(2*a)/2,'r+');
% hold on;
% 
% x = 0.01:0.01:0.5;
% y = 12e12:1e12:13e12;
% B = zeros(length(x),length(y));
% for i=1:length(x)
%     for j=1:length(y)
%         B(i,j) = beta(x(i),y(j));
%     end
% end
% figure;
% mesh(B);




