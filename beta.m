function [ Br ] = beta( miu,fre )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%����
Kb    = 1.38e-23;%������������
e     = 1.6e-19;%���ӵ���
h     = 6.62607e-34;
hba   = h/(2*pi);
tao   = 0.5e12;%��ԥʱ��
T     = 300;%�¶�

miu= abs(miu*e);%�����ܼ�
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
% Bi = imag(BB);

end

