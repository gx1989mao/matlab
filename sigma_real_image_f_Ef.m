clc;
% clf;
clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                  %
%                      input                       %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%常数
Kb    = 1.38e-23;%玻尔兹曼常数
e     = 1.6e-19;%电子电量
h     = 6.62607e-34;
hba   = h/(2*pi);
% gama   = (0.43e-3)*e/hba;%散射能量

%%%%%%%%%%%%%%%%%%%%%%%%%
% gamma =  0.54;%  0.54eV
% tao = gamma*e/hba;
%%%%%%%%%%%%%%%%%%%%%%%%%

tao   = 0.5e12;%弛豫时间
T     = 300;%温度
u0 = 4*pi*1e-7;
% sigma0 = 6.085e-5;
sigma0 = 1;
d = 100e-9;
eps0 = 8.85e-12;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           计算公式                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x =  0.1:0.01:1;%费米能级
% x =  0.001:0.001:1;%费米能级
% temp = 9:0.2:15;
% y = 10.^temp;%
% y = 9e11:1e11:10e11;%频率

freq = 30e12;

y = 30e12:0.5e12:60e12;


Zr = zeros(length(x),length(y));%电导率实部
Zi = zeros(length(x),length(y));%电导率虚部
Nr = zeros(length(x),length(y));
Ni = zeros(length(x),length(y));
Br = zeros(length(x),length(y));%spp波数实部
Bi = zeros(length(x),length(y));%spp波数虚部
FoM = zeros(length(x),length(y));%spp波数实部
Len = zeros(length(x),length(y));%spp波数虚部

BBr = zeros(length(x),length(y));%spp波数实部
BBi = zeros(length(x),length(y));%spp波数虚部
BFoM = zeros(length(x),length(y));%spp波数实部
BLen = zeros(length(x),length(y));%spp波数虚部


for m = 1:1:length(x)
 for n = 1:1:length(y)   
     
    miu= abs(x(m)*e);%费米能级
    fre = y(n);
    sigma_intra = ( -1i*(e^2*Kb*T)/(pi*hba^2*(2*pi*fre-1i*2*tao))  ) * ( (miu/(Kb*T)) +  2*log(2.718^(-miu/(Kb*T))+1)   );
    sigma_inter = (-1i*e^2)/(4*pi*hba)*log((2*abs(miu)-(2*pi*fre-1i*2*tao)*hba)/(2*abs(miu)+(2*pi*fre-1i*2*tao)*hba));
%     sigma_all =  (sigma_intra+sigma_inter)/1e-3;
    sigma_all =  (sigma_intra+sigma_inter);
    Asigma_all = -1i*e^2*miu/(pi*hba^2*(2*pi*fre-1i/tao));
    Bsigma_all = real(sigma_all)-1i*imag(sigma_all);
    
    k0=2*pi*fre/3e8;
    
    if(imag(sigma_all)<0)
        BB = sqrt(1-(2/(377*Bsigma_all))^2);
    else
        BB = sqrt(1-((377*Bsigma_all)/2)^2);
    end
    
%     BB = sqrt(1-(2/(377*Bsigma_all))^2);%波数 air-garphene-air
    in = 1;
    B = sqrt(in*(1-2*1i/(2*pi*fre*1*sigma_all*d*u0)));%波数 graphene-air-graphene
    only = (1077-4.86e-9*fre+7.95e-21*fre^2-4.42e-33*fre^3)*6.0688e-005;
    B1 = sqrt(in*(1-2*1i/(2*pi*fre*1*only*d*u0)));
    
    Zr(m,n) = real(sigma_all)/1e-9;
%     Zi(m,n) = -imag(sigma_all)/(2*pi*fre*1e-9*eps0);
    
%     Zr(m,n) = real(sigma_all)/(pi*e^2/2/h);
    Zi(m,n) = imag(sigma_all)/1e-9;
    
%     Nr(m,n) = real(sqrt(-Zi(m,n)/(2*pi*fre)/eps0+1i*Zr(m,n)/(2*pi*fre)/eps0));
%     Ni(m,n) = imag(sqrt(-Zi(m,n)/(2*pi*fre)/eps0+1i*Zr(m,n)/(2*pi*fre)/eps0));
    
    Br(m,n) = real(BB);
    Bi(m,n) = imag(BB);
    Br1(m,n) = real(B1);
    FoM(m,n) = (real(BB)/imag(BB));
    Len(m,n) = abs(1/2/imag(B)/k0);
%     
%     BBr(m,n) = real(BB);
%     BBi(m,n) = imag(BB);
%     BFoM(m,n) = abs(real(BB)/imag(BB));
%     BLen(m,n) = abs(1/imag(BB)/k0);
    
 end
end
% 
% 
% figure;
% plot(y,Br(1,:),'g');hold on;
% plot(y,Bi(1,:),'g-');hold on;
% plot(y,Br(2,:),'b');hold on;
% plot(y,Bi(2,:),'bo ');hold on;
% plot(y,Br(3,:),'r');hold on;
% plot(y,Bi(3,:),'r- ');hold on;
% xlim([6e12,15e12]);
% % 
figure;
% subplot(2,1,1);
plot(x(:),Br(:,1),'b');
title('Neff');
hold on;
plot(x(:),Bi(:,1),'r');
hold on;
% % 
% % 
% % subplot(2,1,2);
% % plot(FoM(:,1)/2/pi,'b');
% % hold on;
% % title('lamda num');
% % 
% figure();


% Br(Br>100) = 0;
% Bi(Bi>100) = 0;
% mesh(Br);
% figure();
% mesh(Bi);

for i=1:1:length(y) 
    n00 = Br(length(x),i);
    
end


% 
% u=x;
% CUR = zeros(1,181);CUR(1,:) = Br(:,end);
% % CUR1 = 1186.8099+u.*(-21850.54341)+u.^2*(162335.5117)+u.^3*(-546049.19768)+u.^4*(691303.94076);
% CUR1 = 1186.8099+u.*(-21850.54)+u.^2*(162335.5)+u.^3*(-546049.2)+u.^4*(691303.94);
% figure(1);plot(CUR1,'r');hold on; plot(CUR,'b');ylim([0,200]);
