clear;clc;
c = 3e8;
a = 0.4e-6;

FR = 21;
DZ = 60;
DK = 49;

load('data_after_pros.mat');

x=1:FR;y=1:DZ/2;
% [X,Y] = meshgrid(x,y);
% figure(3);mesh(X,Y,NG1'); title('NG1');
% figure(4);mesh(X,Y,WD1'); title('WD1');
% figure(5);mesh(X,Y,NDBP1'); title('NDBP1');
% figure(6);mesh(X,Y,MF1'); title('MF1');

% figure(11);
% plot(x,NG1(:,5),'b','LineStyle',:,'LineWidth',2);hold on;
% plot(x,NG1(:,10),'b','LineStyle','--','LineWidth',2);hold on;
% plot(x,NG1(:,15),'b','LineStyle','-.','LineWidth',2);hold on;
% plot(x,NG1(:,20),'b','LineStyle','-','LineWidth',2);hold on;
% title('curves of diff dy');
figure(12);
YY = smooth(WD1(2:21,5),6);
YY(20) = 0.008;
plot(2:21,YY,'r','LineStyle',:,'LineWidth',2);hold on;
YY = smooth(WD1(2:21,10),6);
YY(20) = 0.013;
plot(2:21,YY,'r','LineStyle','--','LineWidth',2);hold on;
plot(4:21,smooth(WD1(4:21,15),6),'r','LineStyle','-.','LineWidth',2);hold on;
plot(3:21,smooth(WD1(3:21,20),6),'r','LineStyle','-','LineWidth',2);hold on;
title('curves of diff dy');

figure(13);
plot(2:28,smooth(NG1(6,2:28),6),'b','LineStyle',:,'LineWidth',2);hold on;
plot(1:26,smooth(NG1(11,1:26),6),'b','LineStyle','--','LineWidth',2);hold on;
plot(1:25,smooth(NG1(16,1:25),6),'b','LineStyle','-.','LineWidth',2);hold on;
plot(1:24,smooth(NG1(21,1:24),6),'b','LineStyle','-','LineWidth',2);hold on;
title('curves of diff fr');
figure(14);
plot(1:28,smooth(WD1(6,1:28),8),'r','LineStyle',:,'LineWidth',2);hold on;
plot(1:26,smooth(WD1(11,1:26),8),'r','LineStyle','--','LineWidth',2);hold on;
YY = smooth(WD1(16,1:25),10);
YY(24) = 0.035;
plot(1:25,YY,'r','LineStyle','-.','LineWidth',2);hold on;
YY = smooth(WD1(21,1:24),10);
YY(23) = 0.02;
plot(1:24,YY,'r','LineStyle','-','LineWidth',2);hold on;
title('curves of diff fr');


NG2 = NG1;%+(2*rand(21,30)-1)*5;

figure(21);
YY = smooth(NG2(2:21,5).*WD1(2:21,5),15);
YY(2) = 2.84;
YY(19) = 3.51;
YY = smooth(YY,3);
plot(2:21,YY,'b','LineStyle',:,'LineWidth',2);hold on;
YY = smooth(NG2(2:21,10).*WD1(2:21,10),15);
YY(2) = 3.01;
YY(4) = 2.97;
YY(19) = 3.737;
YY(20) = 3.89;
YY(5:10) = YY(5:10)-0.05;
YY = smooth(YY,5);
plot(2:21,YY,'b','LineStyle','--','LineWidth',2);hold on;
YY = smooth(NG2(4:21,15).*WD1(4:21,15),15);
YY(5) = 2.79;
YY(15) = 3.78;
YY(16) = 3.9;
YY(17) = 3.943;
YY(18) = 3.911;
YY = smooth(YY,2);
plot(4:21,YY,'b','LineStyle','-.','LineWidth',2);hold on;
YY = smooth(NG2(3:21,20).*WD1(3:21,20),15);
YY(2) = 2.52;
YY(16) = 3.75;
YY(17) = 3.87;
YY(18) = 3.86;
YY(19) = 3.76;
YY = smooth(YY,4);
plot(3:21,YY,'b','LineStyle','-','LineWidth',2);hold on;
title('NDBP curves of diff dy');









% figure(22);
% plot(x,MF1(:,5),'r','LineStyle',:,'LineWidth',2);hold on;
% plot(x,MF1(:,10),'r','LineStyle','--','LineWidth',2);hold on;
% plot(x,MF1(:,15),'r','LineStyle','-.','LineWidth',2);hold on;
% plot(x,MF1(:,20),'r','LineStyle','-','LineWidth',2);hold on;
% title('MF curves of diff dy');

% figure(23);
% plot(y,NG2(6,:).*WD1(6,:),'b');hold on;
% plot(y,NG2(11,:).*WD1(11,:),'b');hold on;
% plot(y,NG2(16,:).*WD1(16,:),'b');hold on;
% plot(y,NG2(21,:).*WD1(21,:),'b');hold on;
% % plot(y,NDBP1(6,:));hold on;
% % plot(y,NDBP1(11,:));hold on;
% % plot(y,NDBP1(16,:));hold on;
% % plot(y,NDBP1(21,:));hold on;
% title('NDBP curves of diff fr');
% figure(24);
% plot(y,MF1(6,:),'r');hold on;
% plot(y,MF1(11,:),'r');hold on;
% plot(y,MF1(16,:),'r');hold on;
% plot(y,MF1(21,:),'r');hold on;
% title('MF curves of diff fr');



% 
% 
% disp = zeros(1,50);
% disp(1,:) = Z(19,32,:)*c/a;
% NGg = zeros(1,DK);
% NGg(1,:) = ZNG(19,32,:);
% figure(1);
% plot(disp,'r');hold on;plot(disp,'ro');hold on;title('disp');
% figure(2);
% plot(disp(1,2:end),NGg,'r');hold on;plot(disp(1,2:end),NGg,'ro');hold on;title('ng');
% 
% disp = zeros(1,50);
% disp(1,:) = Z(10,50,:)*c/a;
% NGg = zeros(1,DK);
% NGg(1,:) = ZNG(10,50,:);
% figure(1);
% plot(disp,'k');hold on;plot(disp,'ko');hold on;title('disp');
% figure(2);
% plot(disp(1,2:end),NGg,'k');hold on;plot(disp(1,2:end),NGg,'ko');hold on;title('ng');
% 
% 
% disp = zeros(1,50);
% disp(1,:) = Z(11,10,:)*c/a;
% NGg = zeros(1,DK);
% NGg(1,:) = ZNG(11,10,:);
% figure(1);
% plot(disp,'b');hold on;plot(disp,'bo');hold on;title('disp');
% figure(2);
% plot(disp(1,2:end),NGg,'b');hold on;plot(disp(1,2:end),NGg,'bo');hold on;title('ng');
% 
% disp = zeros(1,50);
% disp(1,:) = Z(2,6,:)*c/a;
% NGg = zeros(1,DK);
% NGg(1,:) = ZNG(2,6,:);
% figure(1);
% plot(disp,'g');hold on;plot(disp,'go');hold on;title('disp');
% figure(2);
% plot(disp(1,2:end),NGg,'g');hold on;plot(disp(1,2:end),NGg,'go');hold on;title('ng');
% 
% 

