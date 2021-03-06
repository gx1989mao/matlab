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

B0 =  beta(0.12,fre);
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









angle = 0:0.25:50;
Vg = 10:5:40;%12,18,50
OUT = zeros(length(angle),length(Vg),3);% 1 x 2 y 3 theta
F = zeros(length(angle),length(Vg));

RayTrace = 0;

if RayTrace == 1
    for V = 1:length(Vg)
        figure(V);subplot(2,1,1);
        rectangle('Position',[-R,-R,2*R,2*R],'Curvature',[1,1]);hold on;
    end
end

%% voltage change
for V = 1:length(Vg)
    tic;
    %% angle change 
    for A=1:length(angle)
        path = zeros(1e6,5);
        path(1,1) = -R+3*delta;
        path(1,2) = 0;
        path(1,3) = angle(A); %% angle between ray and x-axis
        num = 1;
        flag = 0;
       %% ray tracing
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

            OUT(A,V,1) = x;
            OUT(A,V,2) = y;
            OUT(A,V,3) = theta;
            if(r1>R)
                break;
            else
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
            end  
            if(r2>R)
                break;
            else
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
            end    

            t1 = theta - phi +180;
            if(t1 < 90)
                t2 = asin(n1*sin(t1/180*pi)/n2)/pi*180;  
                path(num,3) = t2 - 180 + phi;
            else
                t2 = asin(n1*sin((180-t1)/180*pi)/n2)/pi*180;
                path(num,3) = phi - t2;
            end

            if(path(num,2)<delta && num>1000 || num>3e5)
                OUT(A,V,1) = x;
                OUT(A,V,2) = y;
                OUT(A,V,3) = theta;
                break;
            end
        end
       %% cal
        if RayTrace == 1
            figure(V);subplot(2,1,1);
            X = path(1:10:num,1);
            Y = path(1:10:num,2);
            plot(X,Y,'-');hold on;
            axis([-R,R,0,R]);
        end
    end
    toc;
    if RayTrace == 1
        figure(V);subplot(2,1,2);
        plot(rr,MIU*sqrt(Vg(V)/Vg0));hold on;
        ylabel('MIU_under_voltage');
    end
end

%% plot
figure(V*3);
for i=1:length(Vg)
    plot(angle,OUT(:,i,3));hold on;
    line([0 angle(end)],[0 0],'linestyle','- -');hold on;
end

Temp = zeros(length(angle),length(Vg));
figure();
for i=1:length(Vg)
    Temp(:,i) = medfilt1(OUT(:,i,3),20);
    plot(angle,Temp(:,i));hold on;
    line([0 angle(end)],[0 0],'linestyle','- -');hold on;
end


for i=1:A
    for j = 1:V
    x = OUT(i,j,1);
    y = OUT(i,j,2);
    theta = OUT(i,j,3);
    F(i,j) = x-y/tan(theta/180*pi);
    end
end
F(1,:) = F(2,:);
F(F(:,:)<0) = NaN;
figure();
FF = F;
for i=1:V
    FF(:,i)  = medfilt1(F(:,i),20)/R;
%     subplot(2,1,1);
    plot(angle,medfilt1(F(:,i),20)/R);hold on;
%     subplot(2,1,2);
%     plot(angle,F(:,i)/R);hold on;
end
FF(1,:) = FF(2,:);
figure;
[XX,YY] = meshgrid(Vg,angle);
mesh(XX,YY,FF);hold on;
for i=1:V
    XXX = ones(1,A)*Vg(i);
    YYY = angle;
    ZZZ = angle;
    ZZZ(:) = FF(:,i);
    plot3(XXX,YYY,ZZZ,'r','LineWidth',1.5);hold on;
end
