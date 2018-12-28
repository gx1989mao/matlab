clear;
clc;
% clf;
% x = 0.01:0.01:0.45;%dot R
% y = 5:3:25;%dot N


yl = graphene_freq_lockMiuC(8.2e12,0.1e12,10e12,1);
yh = graphene_freq_lockMiuC(8.2e12,0.1e12,10e12,0.11);


X = zeros(1,length(yl));
X1 = zeros(1,length(yl));

% for i = 1:1:length(x)
    for j = 1:1:length(yl)
        [a,b]=PBGBand_cul(yh(j)^2,yl(j)^2,0.15,1,1,1);% N^2 -> eps
        X(1,j) = a;
        X1(1,j) = b;
    end
% end
figure();
% mesh(X);
plot(X);hold on;
plot(X1);

% figure(2);
% 
% subplot(1,2,1);
% mesh(Zr);
% title('Real part of conductivity');
% hold on;