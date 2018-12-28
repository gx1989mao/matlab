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
tao   = 0.5e12;%弛豫时间
T     = 3;%温度
u0 = 4*pi*1e-7;
% sigma0 = 6.085e-5;
sigma0 = 1;
d = 100e-9;
eps0 = 8.85e-12;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           计算公式                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x =  0.01:0.01:1;%费米能级
% x= 0.1; 
% temp = 9:0.2:15;
% y = 10.^temp;%
% y = 9e11:1e11:10e11;%频率

freq = 7e12;

y = 8e12:0.1e12:10e12;


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
    
    BB = sqrt(1-(2/(377*Bsigma_all))^2);%波数 air-garphene-air
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



% figure(1);
% 
% subplot(2,2,1);
% plot(Zr(1,:))
% title('Conductivity  s/m');
% hold on;
% % plot((1077-4.86e-9*y+7.95e-21*y.^2-4.42e-33*y.^3)*6.0688e-005/1e-9,'r');
% hold on;
% 
% subplot(2,2,2);
% plot(Zi(1,:));
% title('Eps  rel');
% hold on;
% figure(3);
% subplot(2,2,3);
% plot(Zr(:,2))
% title('con ');
% hold on;
% subplot(2,2,3);
% plot(Br1(1,:),'r')
% hold on;

% subplot(2,2,3);
% plot(-Zi(:,2),'r');
% title('con');
% hold on;
% 
% figure(5);
% plot(Zr(:,2)/(2*pi*fre)/eps0,'r');
% title('eps');
% hold on;
% plot(-Zi(:,2)/(2*pi*fre)/eps0,'b');
% title('eps');
% hold on;


figure();
subplot(2,1,1);
plot(Br(:,2),'b');
title('Neff');
hold on;
plot(Bi(:,2),'r');
hold on;


subplot(2,1,2);
plot(FoM(:,21)/2/pi,'b');
hold on;
title('lamda num');

figure();
mesh(Br);


% 
% figure(2);
% 
% subplot(1,2,1);
% mesh(Zr);
% title('Real part of conductivity');
% hold on;
% % 
% subplot(1,2,2);
% mesh(Zi);
% title('Image part of conductivity');
% hold on;

% % figure(4);
% 
% subplot(1,2,1);
% mesh(Zr/(pi*e^2/2/h));
% title('Real part of conductivity');
% hold on;
% 
% subplot(1,2,2);
% mesh(Zi/(pi*e^2/2/h));
% title('Image part of conductivity');
% hold on;

% 
% figure(2);
% subplot(2,2,1);
% mesh(Br);
% title('Real part of Nspp');
% hold on;
% subplot(2,2,2);
% mesh(Bi);
% title('Image part of Nspp');
% hold on;
% subplot(2,2,3);
% mesh(FoM);
% title('FoM');
% hold on;
% subplot(2,2,4);
% mesh(Len/1e-6);
% title('Len  um');
% hold on;



% figure(3);
% subplot(2,2,1);
% mesh(BBr);
% title('Real part of Nspp');
% hold on;
% subplot(2,2,2);
% mesh(BBi);
% title('Image part of Nspp');
% hold on;
% subplot(2,2,3);
% mesh(BFoM);
% title('FoM');
% hold on;
% subplot(2,2,4);
% mesh(BLen/1e-6);
% title('Len  um');
% hold on;






