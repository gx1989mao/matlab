clc;
clear;

Kb    = 1.38e-23;%玻尔兹曼常数
e     = 1.6e-19;%电子电量
h     = 6.62607e-34;
hba   = h/(2*pi);
tao   = 0.5e12;%弛豫时间
T     = 300;%温度
fre   = 30e12;
eps   = 8.85e-12;
vf    = 1e6;

%%%  B to miuC list
miu_vV=0.08:0.0001:1;BBB = zeros(1,length(miu_vV));
for miu_v=1:length(miu_vV)
BBB(1,miu_v)= beta( miu_vV(miu_v),fre );
end
figure(100);
subplot(4,1,1);plot(BBB);
ylabel('B');
%%% distance cal
R = 500e-9;
delta = R/1e3;

B0 =  beta(0.16,fre);
Vg0 = 10;
tic;
rr=0:delta:R;
dis = zeros(1,length(rr));
MIU = zeros(1,length(rr));
BR = zeros(1,length(rr));
for i = 1:length(rr)
    n = B0*2/(1+(rr(i)/R)^2);
    M = 1;
    for mm = 1:length(miu_vV)
        if(BBB(mm)<n)
            M = miu_vV(mm);
            dis(i) = (pi*eps*3.2*Vg0/e)/(M*e/hba/vf)^2;
            MIU(i) = M;
            BR(i) = n;
            break;
        end
    end   
end
figure(100);subplot(4,1,2);
plot(rr,dis./1e-9);
ylabel('dis/nm');
figure(100);subplot(4,1,3);
plot(rr,BR);
ylabel('BR');
figure(100);subplot(4,1,4);
plot(rr,MIU);
ylabel('miu c/eV');
toc;









angle = 1:2:80;
Vg = 10:10:80;
OUT = zeros(length(angle),length(Vg));

for V = 1:length(Vg)
    figure(V);subplot(2,1,1);
    rectangle('Position',[-R,-R,2*R,2*R],'Curvature',[1,1]);hold on;
end

for V = 1:length(Vg)

tic;
for A=1:length(angle)
    path = zeros(100000,5);
    path(1,1) = -R+3*delta;
    path(1,2) = 0;
    path(1,3) = angle(A); %% angle between ray and x-axis

    num = 1;
    flag = 0;
    
    while(1)
        x = path(num,1);
        y = path(num,2);
        theta = path(num,3);
        num = num+1;
        path(num,1) = delta*cos(theta/180*pi) + x;
        path(num,2) = delta*sin(theta/180*pi) + y;

        r1 = sqrt(x^2+y^2);
        r2 = sqrt(path(num,1)^2+path(num,2)^2);
        phi = acos(path(num,1)/r2)/pi*180;

        if(r1>R)
            OUT(A,V) = theta;
            break;
        else
    %         n1 = 2/(1+(r1/R)^2);
%             n1 = sqrt(2-(r1/R)^2);

            B_r = B0*(2/(1+(r1/R)^2));
            
            for mm = 1:length(miu_vV)
                if(BBB(mm)<B_r)
                    M = miu_vV(mm);
                    break;
                end
            end        
            
            miu= abs(M*sqrt(Vg(V)/Vg0)*e);%费米能级
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
            n1 = Br;
%             n1 = beta(M*sqrt(Vg(V)/Vg0) , fre);
        end  
        if(r2>R)
            OUT(A,V) = theta;
            break;
        else
    %         n2 = 2/(1+(r2/R)^2);
%             n2 = sqrt(2-(r2/R)^2);
            B_r = B0*(2/(1+(r2/R)^2));
            
            for mm = 1:length(miu_vV)
                if(BBB(mm)<B_r)
                    M = miu_vV(mm);
                    break;
                end
            end         
            miu= abs(M*sqrt(Vg(V)/Vg0)*e);%费米能级
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
            n2 = Br;
%             n2 = beta(M*sqrt(Vg(V)/Vg0) , fre);
        end    

        t1 = theta - phi +180;
        if(t1 < 90)
            t2 = asin(n1*sin(t1/180*pi)/n2)/pi*180;  
            path(num,3) = t2 - 180 + phi;
        else
            t2 = asin(n1*sin((180-t1)/180*pi)/n2)/pi*180;
            path(num,3) = phi - t2;
        end
        if(path(num,2)<delta && num>1000 || num>30000)
            break;
        end
    end
    figure(V);subplot(2,1,1);
    X = path(1:50:num,1);
    Y = path(1:50:num,2);
    plot(X,Y,'-');hold on;
%     for i=1:50:num
%         plot(path(i,1),path(i,2),'.');hold on;
%     end
    axis([-R,R,0,R]);
end
toc;

figure(V);subplot(2,1,2);
plot(rr,MIU*sqrt(Vg(V)/Vg0));hold on;
ylabel('MIU_under_voltage');
end


figure(V+1);
for i=1:length(Vg)
    for j=2:length(angle)
        if(OUT(j,i)==0)
            OUT(j,i) = (OUT(j-1,i)+OUT(j+1,i))/2;
        end
    end
    
    plot(OUT(:,i));hold on;
end








