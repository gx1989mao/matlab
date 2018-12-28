clear;
clc;
path = 'C:\comsol_models\result\vg.csv';
M = csvread(path);

S21 = [];
S31 = [];
S41 = [];
% 26 0.2 32
% 2.2 0.2 9.2

for i = 1:1:31
    point = 1+(i-1)*108;
    S21 = [S21,M(point:point+35,2)];
    point = point+36;
    S31 = [S31,M(point:point+35,2)]; 
    point = point+36;
    S41 = [S41,M(point:point+35,2)]; 
end

S21(S21<-20) = -20;
S31(S31<-20) = -20;
S41(S41<-20) = -20;

figure();
contourf(S21);%alpha(0.5);hold on; surface(S21);
figure();
contourf(S31);
figure();
contourf(S41);

