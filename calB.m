function [ Br ] = calB( r,R, B0, Vg0, Vg,fre )
Kb    = 1.38e-23;%玻尔兹曼常数
e     = 1.6e-19;%电子电量
h     = 6.62607e-34;
hba   = h/(2*pi);
tao   = 0.5e12;%弛豫时间
T     = 300;%温度
% eps   = 8.85e-12;
% vf    = 1e6;

B_r = B0*(2/(1+(r/R)^2));
miu_r = calMiu(B_r,fre);

miu_v = miu_r*sqrt(Vg/Vg0);
miu= abs(miu_v*e);%费米能级
sigma_intra = ( -1i*(e^2*Kb*T)/(pi*hba^2*(2*pi*fre-1i*2*tao))  ) * ( (miu/(Kb*T)) +  2*log(2.718^(-miu/(Kb*T))+1)   );
sigma_inter = (-1i*e^2)/(4*pi*hba)*log((2*abs(miu)-(2*pi*fre-1i*2*tao)*hba)/(2*abs(miu)+(2*pi*fre-1i*2*tao)*hba));
sigma_all =  (sigma_intra+sigma_inter);
Bsigma_all = real(sigma_all)-1i*imag(sigma_all); 
if(imag(sigma_all)<0)
    BB = sqrt(1-(2/(377*Bsigma_all))^2);
else
    BB = sqrt(1-((377*Bsigma_all)/2)^2);
end

Br = real(BB);

end

