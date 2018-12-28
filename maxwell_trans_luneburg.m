clc;
% clf;
clear;

a = 5e-9;%半径
der = 4*a;
r1 = a+der;%核心半径
cir = 29;%除去core之外cir圈
R = cir*der+r1;%区域半径
corenum = 7;%%% the points number of core circle
fre = 30e12;
x = 1:cir;

miub = 0.25;
miud = 0.1;

N1ori = beta(miub,fre);   %7
N2ori = beta(miud,fre);   %36
N = zeros(30,1);
for i = 1:1:cir
    F1 = N1ori*2/(1+((r1+(i-1)*der+0.5*der)/R)^2);%当前环等效折射率maxwell   以此计算点分布
%      F1 = N1ori*sqrt(2-((r1+(i-1)*der+0.5*der)/R)^2);%当前环等效折射率luneburg
    ring = (r1+i*der)^2-(r1+i*der-der)^2;%当前环面积
    N(i) = (F1-N1ori)*ring/a^2/(N2ori-N1ori);%当前环点数
end

num = 1;
 
for scale = 1:1:3
    N1 = beta(miub*scale,fre);   %7
    N2 = beta(miud*scale,fre);   %36
    Eff = zeros(30,1);
    for i=1:cir
        ring = (r1+i*der)^2-(r1+i*der-der)^2;%当前环面积
        Eff(i) = (N(i)*a^2*N2+(ring-N(i)*a^2)*N1)/ring;
    end
    figure(num);
    plot(x,Eff(x,1),'bo');hold on;
    
    
    S1 = zeros(30,1);
    S2 = zeros(30,1);
    for i = 1:1:cir
        F1 = N1*2/(1+((r1+(i-1)*der+0.5*der)/R)^2);%当前环等效折射率maxwell
        F2 = N1*sqrt(2-((r1+(i-1)*der+0.5*der)/R)^2);%当前环等效折射率luneburg
        S1(i) = F1;
        S2(i) = F2;
    end
    figure(num);
    plot(x,S1(x,1),'b');
    hold on;
    plot(x,S2(x,1),'r');
    hold on;
%     num = num+1;
end

% figure(num);
% plot(x,N(x,1));
% hold on;
% plot(x,N(x,1),'b*');
% hold on;
% plot(x,2*pi*(r1+der*x)/(2*a)/2,'r+');



lambdaG = 3e8/fre/N1ori/1e-9;
%  kk = 0.1:0.01:0.2;
% for i=1:length(kk)
%     plot(kk(i),beta(kk(i),30e12),'bo');hold on;
% end

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




