clc;
clear;

R = 500;

delta = R/1e3;

path = zeros(100000,5);

figure(1);
rectangle('Position',[-R,-R,2*R,2*R],'Curvature',[1,1]);hold on;

angle=1:5:80;
OUT = zeros(length(angle),1);
tic;
for A = 1:length(angle)
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
        n1 = 1;
        OUT(A) = theta;
        break;
    else
        n1 = 2/(1+(r1/R)^2);
%         n1 = sqrt(2-(r1/R)^2);
    end  
    if(r2>R)
        n2 = 1;
        OUT(A) = theta;
        break;
    else
        n2 = 2/(1+(r2/R)^2);
%         n2 = sqrt(2-(r2/R)^2);
    end    

    t1 = theta - phi +180;
    if(t1 < 90)
        t2 = asin(n1*sin(t1/180*pi)/n2)/pi*180;  
        path(num,3) = t2 - 180 + phi;
    else
        t2 = asin(n1*sin((180-t1)/180*pi)/n2)/pi*180;
        path(num,3) = phi - t2;
    end
    if(path(num,2)<0 || num>30000)
        break;
    end
end



figure(1);
for i=1:50:num
    plot(path(i,1),path(i,2),'.');hold on;
end
axis([-R,R,0,R]);
% figure(2);
% plot(real(path(1:100:num,3)),'-');hold on;
% plot(real(path(1:100:num,4)),'.');hold on;

end
toc;

figure();
plot(OUT(:,1));hold on;












