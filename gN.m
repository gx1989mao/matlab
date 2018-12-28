function [ N ] = gN( M,F )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

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


    miu= abs(M*e);%费米能级
    fre = F;
    sigma_intra = ( -1i*(e^2*Kb*T)/(pi*hba^2*(2*pi*fre-1i*2*tao))  ) * ( (miu/(Kb*T)) +  2*log(2.718^(-miu/(Kb*T))+1)   );
    sigma_inter = (-1i*e^2)/(4*pi*hba)*log((2*abs(miu)-(2*pi*fre-1i*2*tao)*hba)/(2*abs(miu)+(2*pi*fre-1i*2*tao)*hba));
%     sigma_all =  (sigma_intra+sigma_inter)/1e-3;
    sigma_all =  (sigma_intra+sigma_inter);
    Bsigma_all = real(sigma_all)-1i*imag(sigma_all);
    if(imag(sigma_all)<0)
        BB = sqrt(1-(2/(377*Bsigma_all))^2);
    else
        BB = sqrt(1-((377*Bsigma_all)/2)^2);
    end
    N = BB;
    
end

