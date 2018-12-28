clear;clc;
absPath = 'D:\Research\research\paper\slowlight waveguide\simulation\mosttmp_work\dataStore\voltage';

fileName = 'mosttmp_bs_bandmap_te__slice_';


c = 3e8;
a = 0.4e-6;

FR = 5;
DZ = 5;
DK = 49;
% Z = zeros(FR,DZ,50);% 1st. <firstRatioR> 0.08 to 0.2 R   2nd. <deltaZ> -0.035 to 0.035 0.0980(39)    
% for i=1:FR
%     for j=1:DZ
%         path = [absPath,'\',fileName,int2str(i-1),'_',int2str(j-1),'.dat'];
%         A = load(path);
%         Z(i,j,:) = A(:,267);
%     end
% end
% 
% 
% 
% ZNG = zeros(FR,DZ,DK);
% NG = zeros(FR,DZ);
% WD = NG;
% NDBP = NG;
% MF = NG;
% 
% for i=1:FR
%     for j=1:DZ
%         temp = zeros(1,DK);
%         for m=1:DK
%             
%             df = (Z(i,j,m+1)-Z(i,j,m))*c/a;
%             dk = 0.5/DK*(2*pi)/a;
%             temp(m) = dk/df*c/(2*pi)*2.2;
%             ZNG(i,j,:) = temp(:);
%             if(min(temp>0))
%                 NG(i,j) = min(temp);
%                 MF(i,j) = Z(i,j,temp == NG(i,j))*c/a*1e-12;
%                 th = NG(i,j)*1.06;
%                 index = find(temp<=th);
%                 wd = (Z(i,j,index(end))*c/a) - (Z(i,j,index(1))*c/a);
%                 f0 = (Z(i,j,index(end))*c/a) + (Z(i,j,index(1))*c/a)/2;
%                 WD(i,j) = wd/f0;
%                 NDBP(i,j) = WD(i,j)*NG(i,j);
%             else
%                 NG(i,j) = NaN;
%                 WD(i,j) = NaN;
%                 NDBP(i,j)= NaN;
%                 MF(i,j) = NaN;
%             end                      
%         end
%     end
% end
% 
% 



load('data_after_pros_voltage.mat');
x=1:FR;y=1:DZ;
[X,Y] = meshgrid(x,y);
figure(3);mesh(X,Y,NG');title('NG');
figure(4);mesh(X,Y,WD');hold on;title('WD');
figure(5);mesh(X,Y,NDBP'); title('NDBP');
figure(6);mesh(X,Y,MF'); title('MF');


disp = zeros(1,50);
disp(1,:) = Z(1,1,:)*c/a;
NGg = zeros(1,DK);
NGg(1,:) = ZNG(1,1,:);
figure(1);
plot(disp,'r');hold on;plot(disp,'ro');hold on;title('disp');
figure(2);
plot(disp(1,2:end),NGg,'r');hold on;plot(disp(1,2:end),NGg,'ro');hold on;title('ng');

disp = zeros(1,50);
disp(1,:) = Z(2,2,:)*c/a;
NGg = zeros(1,DK);
NGg(1,:) = ZNG(2,2,:);
figure(1);
plot(disp,'k');hold on;plot(disp,'ko');hold on;title('disp');
figure(2);
plot(disp(1,2:end),NGg,'k');hold on;plot(disp(1,2:end),NGg,'ko');hold on;title('ng');


disp = zeros(1,50);
disp(1,:) = Z(3,3,:)*c/a;
NGg = zeros(1,DK);
NGg(1,:) = ZNG(3,3,:);
figure(1);
plot(disp,'b');hold on;plot(disp,'bo');hold on;title('disp');
figure(2);
plot(disp(1,2:end),NGg,'b');hold on;plot(disp(1,2:end),NGg,'bo');hold on;title('ng');

disp = zeros(1,50);
disp(1,:) = Z(4,4,:)*c/a;
NGg = zeros(1,DK);
NGg(1,:) = ZNG(4,4,:);
figure(1);
plot(disp,'g');hold on;plot(disp,'go');hold on;title('disp');
figure(2);
plot(disp(1,2:end),NGg,'g');hold on;plot(disp(1,2:end),NGg,'go');hold on;title('ng');

disp = zeros(1,50);
disp(1,:) = Z(5,5,:)*c/a;
NGg = zeros(1,DK);
NGg(1,:) = ZNG(5,5,:);
figure(1);
plot(disp,'g');hold on;plot(disp,'go');hold on;title('disp');
figure(2);
plot(disp(1,2:end),NGg,'g');hold on;plot(disp(1,2:end),NGg,'go');hold on;title('ng');



