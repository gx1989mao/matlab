clear;
clc;
path = 'C:\comsol_models\result\';
fName = 26;
M = csvread([path,num2str(fName),'.csv']);

S21 = [];
S31 = [];

S21 = [S21,M(1:35,2)];
S31 = [S31,M(36:70,2)];

for i = 27:1:32
    M = csvread([path,num2str(i),'.csv']);
    for j=1:5
        point = 1+(j-1)*70;
        S21 = [S21,M(point:point+34,2)];
        point = point+35;
        S31 = [S31,M(point:point+34,2)];
    end    
end
S21(S21<-30) = -30;
S31(S31<-30) = -30;

% Z31 = 0.*ones(35,31);
% Z31(S31>-1) = -100;
% Z31(S21>-15) = 0;
% 
% Z21 = -100.*ones(35,31);
% Z21(S21>-1) = 100;
% Z21(S31>-15) = 0;
% Z21(Z31 == -100) = -100;
% figure();
% contourf(S21);
% figure();
% contourf(S31);
figure();
contourf(S31-S21);
% figure();
% pcolor(S21);
% figure();
% pcolor(S31);

% figure();
% % pcolor(Z31);
% % hold on;
% pcolor(Z21);



