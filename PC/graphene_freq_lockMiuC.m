

function [Br] = graphene_freq_lockMiuC(freql,freqstep,freqh,MiuC)


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
x =  MiuC;%费米能级
% temp = 9:0.2:15;
% y = 10.^temp;%
% y = 9e11:1e11:10e11;%频率

freq = 7e12;

y = freql:freqstep:freqh;


Zr = zeros(1,length(y));%电导率实部
Zi = zeros(1,length(y));%电导率虚部
Nr = zeros(1,length(y));
Ni = zeros(1,length(y));
Br = zeros(1,length(y));%spp波数实部
Bi = zeros(1,length(y));%spp波数虚部
% FoM = zeros(length(x),length(y));%spp波数实部
% Len = zeros(length(x),length(y));%spp波数虚部
% 
% BBr = zeros(length(x),length(y));%spp波数实部
% BBi = zeros(length(x),length(y));%spp波数虚部
% BFoM = zeros(length(x),length(y));%spp波数实部
% BLen = zeros(length(x),length(y));%spp波数虚部


% for m = 1:1:length(x)
 for n = 1:1:length(y)   
     
    miu= abs(x*e);%费米能级
    fre = y(n);
    sigma_intra = ( -1i*(e^2*Kb*T)/(pi*hba^2*(2*pi*fre-1i*2*tao))  ) * ( (miu/(Kb*T)) +  2*log(2.718^(-miu/(Kb*T))+1)   );
    sigma_inter = (-1i*e^2)/(4*pi*hba)*log((2*abs(miu)-(2*pi*fre-1i*2*tao)*hba)/(2*abs(miu)+(2*pi*fre-1i*2*tao)*hba));
%     sigma_all =  (sigma_intra+sigma_inter)/1e-3;
    sigma_all =  (sigma_intra+sigma_inter);
    Asigma_all = -1i*e^2*miu/(pi*hba^2*(2*pi*fre-1i/tao));
    Bsigma_all = real(sigma_all)-1i*imag(sigma_all);
    
    k0=2*pi*fre/3e8;
    
    BB = sqrt(1-(2/(377*Bsigma_all))^2);%波数 air-garphene-air
%     in = 1;
%     B = sqrt(in*(1-2*1i/(2*pi*fre*1*sigma_all*d*u0)));%波数 graphene-air-graphene
%     only = (1077-4.86e-9*fre+7.95e-21*fre^2-4.42e-33*fre^3)*6.0688e-005;
%     B1 = sqrt(in*(1-2*1i/(2*pi*fre*1*only*d*u0)));
    
    Zr(1,n) = real(sigma_all)/1e-9;
    Zi(1,n) = imag(sigma_all)/1e-9;
    

    
    Br(1,n) = real(BB);
    Bi(1,n) = imag(BB);
%     Br1(m,n) = real(B1);
%     FoM(m,n) = (real(BB)/imag(BB));
%     Len(m,n) = abs(1/2/imag(B)/k0);
%     

 end
% end





end


