clear;
clc;
clf;
X = [];
num = 1;
for i = 0.01:0.03:0.45
    [a,b]=PBGBand_cul(100,49,i,1,1,1);
    X(num) = a-b;
    num = num+1;
end
plot(X);


% figure(2);
% 
% subplot(1,2,1);
% mesh(Zr);
% title('Real part of conductivity');
% hold on;