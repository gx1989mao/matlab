clear;
clc;
path = 'C:\comsol_models\result\down.csv';
M = csvread(path);
S11 = [];
S21 = [];
S31 = [];
S41 = [];
% 26 0.2 32
% 2.2 0.2 9.2

for i = 1:4
    point = 1+(i-1)*4;
    S11 = [S11,M(point+0,2)];
    S21 = [S21,M(point+1,2)];
    S31 = [S31,M(point+2,2)]; 
    S41 = [S41,M(point+3,2)]; 
end

S = [S21;S31;S41];
S = S+40;
% S = fliplr(S);
figure;
% plot(S11,'r');hold on;
% plot(S21,'b');hold on;
% plot(S31,'y');hold on;
% plot(S41,'k');hold on;

% bar3(S');
bar(S);
csvwrite('D:\myproj\бшнд\WDM\SS.csv',S');




