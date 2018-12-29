clear;
clc;
% clf;
x = 0.01:0.01:0.45;%dot R
y = 4:1:15;%dot N

X = zeros(length(x),length(y));


for i = 1:1:length(x)
    for j = 1:1:length(y)
        [a,b]=PBGBand_cul(y(j)^2,3^2,x(i),1,1,1);% N^2 -> eps
        X(i,j) = a-b;
    end
end
figure();
mesh(X);


% figure(2);
% 
% subplot(1,2,1);
% mesh(Zr);
% title('Real part of conductivity');
% hold on;