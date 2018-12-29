clc;
clear;
% clf;

%%常数
Kb    = 1.38e-23;%玻尔兹曼常数
e     = 1.6e-19;%电子电量
h     = 6.62607e-34;
hba   = h/(2*pi);
tao   = 0.5e12;%弛豫时间
T     = 300;%温度
u0 = 4*pi*1e-7;
eps0 = 8.85e-12;
vf = 9.546e5;

Vg = 5;

w = 50e-9;
b = 200e-9;
x = 0:0.1:10;
x = x*w;

A = 1:100;
A = A*1e-9;
B = 10:200;
B = B*1e-9;


Sr = zeros(length(x),length(A));%spp波数实部
Si = zeros(length(x),length(A));%spp波数虚部
Br = zeros(length(x),length(A));%spp波数实部
Bi = zeros(length(x),length(A));%spp波数虚部


% Sr = zeros(length(x),length(B));%spp波数实部
% Si = zeros(length(x),length(B));%spp波数虚部
% Br = zeros(length(x),length(B));%spp波数实部
% Bi = zeros(length(x),length(B));%spp波数虚部


% Sr = zeros(length(x),length(B));%spp波数实部
% Si = zeros(length(x),length(B));%spp波数虚部
% Br = zeros(length(x),length(B));%spp波数实部
% Bi = zeros(length(x),length(B));%spp波数虚部

for m = 1:1:length(x)
    for n = 1:1:length(A)
        fre = 3e13;
        c = 0;
        a = A(n);
        b = B(end);
        for k=1:1:100
            ci = (-2*b/a)*(1/k/pi)^2*sin(k*pi*(1-a/b)) ;
            c = c+(k*pi/b)*(-1)^k*exp((-k*pi/b)*(abs(x(m)-w)))*ci;
        end
        if(abs(x(m))<w)
            rou = eps0*Vg/a;
        else
            rou = eps0*Vg*(1/b+c);
        end
        miu= hba*vf*sqrt(pi*rou/e);%费米能级
%         miu  = 0.05*e;
        sigma_intra = ( -1i*(e^2*Kb*T)/(pi*hba^2*(2*pi*fre-1i*2*tao))  ) * ( (miu/(Kb*T)) +  2*log(2.718^(-miu/(Kb*T))+1)   );
        sigma_inter = (-1i*e^2)/(4*pi*hba)*log((2*abs(miu)-(2*pi*fre-1i*2*tao)*hba)/(2*abs(miu)+(2*pi*fre-1i*2*tao)*hba));
        sigma_all =  (sigma_intra+sigma_inter);
        Bsigma_all = real(sigma_all)-1i*imag(sigma_all);
%         BB = sqrt(1-((377*Bsigma_all)/2)^2);
        
%             
        if(imag(sigma_all)<0)
            BB = sqrt(1-(2/(377*Bsigma_all))^2);
        else
            BB = sqrt(1-((377*Bsigma_all)/2)^2);
        end
    
        BB = sqrt(1-(2/(377*Bsigma_all))^2);
        Sr(m,n) = imag(Bsigma_all)/(1e-6);
%         Br(m,n) =real(Bsigma_all)/(1e-6);
        Si(m,n) = real(Bsigma_all)/(1e-6);
        Br(m,n)= real(BB);
        Bi(m,n)= imag(BB);
    end
end
[X, Y]=meshgrid( A/(1e-9),x/w);
figure();
% mesh(X,Y,Br);hold on;
% mesh(Sr*10-2000);hold on;
mesh(X,Y,Sr);
% 
% figure();
% mesh(Bi);
% 
% 
% figure();
% mesh(Si);
figure();
mesh(X,Y,Si);













