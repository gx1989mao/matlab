clc;
% clf;
clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                  %
%                      input                       %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%����
Kb    = 1.38e-23;%������������
e     = 1.6e-19;%���ӵ���
h     = 6.62607e-34;
hba   = h/(2*pi);
% gama   = (0.43e-3)*e/hba;%ɢ������

%%%%%%%%%%%%%%%%%%%%%%%%%
% gamma =  0.43e-3;%  0.54meV
% tao = gamma*e/hba;
%%%%%%%%%%%%%%%%%%%%%%%%%

tao   = 0.5e12;%��ԥʱ��
T     = 300;%�¶�
u0 = 4*pi*1e-7;
% sigma0 = 6.085e-5;
sigma0 = 1;
d = 100e-9;
eps0 = 8.85e-12;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           ���㹫ʽ                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x =  0.1:0.005:1;%�����ܼ�
% x =  0.001:0.001:1;%�����ܼ�
% temp = 9:0.2:15;
% y = 10.^temp;%
% y = 9e11:1e11:10e11;%Ƶ��

freq = 8e12;

y = 27e12:0.1e12:32e12;


Zr = zeros(length(x),length(y));%�絼��ʵ��
Zi = zeros(length(x),length(y));%�絼���鲿
Nr = zeros(length(x),length(y));
Ni = zeros(length(x),length(y));
Br = zeros(length(x),length(y));%spp����ʵ��
Bi = zeros(length(x),length(y));%spp�����鲿
FoM = zeros(length(x),length(y));%spp����ʵ��
Len = zeros(length(x),length(y));%spp�����鲿

BBr = zeros(length(x),length(y));%spp����ʵ��
BBi = zeros(length(x),length(y));%spp�����鲿
BFoM = zeros(length(x),length(y));%spp����ʵ��
BLen = zeros(length(x),length(y));%spp�����鲿


for m = 1:1:length(x)
 for n = 1:1:length(y)   
     
    miu= abs(x(m)*e);%�����ܼ�
    fre = y(n);
    sigma_intra = ( -1i*(e^2*Kb*T)/(pi*hba^2*(2*pi*fre-1i*2*tao))  ) * ( (miu/(Kb*T)) +  2*log(2.718^(-miu/(Kb*T))+1)   );
    sigma_inter = (-1i*e^2)/(4*pi*hba)*log((2*abs(miu)-(2*pi*fre-1i*2*tao)*hba)/(2*abs(miu)+(2*pi*fre-1i*2*tao)*hba));
    sigma_all =  (sigma_intra+sigma_inter);
    Asigma_all = -1i*e^2*miu/(pi*hba^2*(2*pi*fre-1i/tao));
    Bsigma_all = real(sigma_all)-1i*imag(sigma_all);
    
    k0=2*pi*fre/3e8;
    
    if(imag(sigma_all)<0)
        BB = sqrt(1-(2/(377*Bsigma_all))^2);
    else
        BB = sqrt(1-((377*Bsigma_all)/2)^2);
    end
    
%     Zr(m,n) = real(sigma_all)/1e-9;
%     Zi(m,n) = imag(sigma_all)/1e-9;

    Br(m,n) = real(BB);
    Bi(m,n) = imag(BB);

%     FoM(m,n) = (real(BB)/imag(BB));
%     Len(m,n) = abs(1/2/imag(B)/k0);

    
 end
end
%
figure();
mesh(Br);
figure();
mesh(Bi);
% 