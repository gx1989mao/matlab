
% load('E:\Research\graphene antenna\graphene modulator\·ÂÕædata\mosttmp_bs_bandmap_te800.dat',1);
% a = [];
% for i = 2:1:206
%     a=[a,sym(['VarName',num2str(i)])];
%     plot(eval(a(i-1)));
%     hold on;
% end
% 
% 
% plot(VarName201);
clear;clc;clf;

str = 'D:\Research\research\graphene antenna\graphene modulator\·ÂÕædata\';

a1 = load([str,'mosttmp_bs_bandmap_te800.dat']);
a2 = load([str,'mosttmp_bs_bandmap_te801.dat']);
a3 = load([str,'mosttmp_bs_bandmap_te802.dat']);
a4 = load([str,'mosttmp_bs_bandmap_te803.dat']);
a5 = load([str,'mosttmp_bs_bandmap_te804.dat']);

a6 = load([str,'mosttmp_bs_bandmap_te805.dat']);
a7 = load([str,'mosttmp_bs_bandmap_te806.dat']);
a8 = load([str,'mosttmp_bs_bandmap_te807.dat']);
a9 = load([str,'mosttmp_bs_bandmap_te808.dat']);
a10 = load([str,'mosttmp_bs_bandmap_te809.dat']);

a11 = load([str,'mosttmp_bs_bandmap_te900.dat']);
a12 = load([str,'mosttmp_bs_bandmap_te901.dat']);
a13 = load([str,'mosttmp_bs_bandmap_te902.dat']);
a14 = load([str,'mosttmp_bs_bandmap_te903.dat']);
a15 = load([str,'mosttmp_bs_bandmap_te904.dat']);

a16 = load([str,'mosttmp_bs_bandmap_te905.dat']);
a17 = load([str,'mosttmp_bs_bandmap_te906.dat']);
a18 = load([str,'mosttmp_bs_bandmap_te907.dat']);
a19 = load([str,'mosttmp_bs_bandmap_te908.dat']);
a20 = load([str,'mosttmp_bs_bandmap_te909.dat']);

a21 = load([str,'mosttmp_bs_bandmap_te100.dat']);

b = [];
for i = 1:1:21
    b=[b,sym(['a',num2str(i)])];
end

low = zeros(1,21);
bhigh = zeros(1,21);
blow = zeros(1,21);
for i=1:1:21
    k=[];
    k=eval(b(i));
%     plot(k(:,201));
%     hold on;
    low(1,i) = k(2,202);
end

Nr = Neff_miu_C2(8,0.1,10);
Nlow = Nr(100,:);
Nhigh = Nr(20,:);


for i=1:1:21
    [fhigh,flow] = PBGBand_cul(Nhigh(1,i)^2,Nlow(1,i)^2,0.15,1,1,1);
    bhigh(1,i) = fhigh;
    blow(1,i) = flow;
end

po = 4.5;
xx = 8e12:0.1e12:10e12;
x= xx.*4.5e-14./3;
cc = xx.*po./300./1e12;
figure();
plot(x,low,'b');
hold on;
plot(x,bhigh,'r');
hold on;
plot(x,blow,'g');
hold on;
plot(x,cc,'*');
hold on;
% axis([0,0.2,0,0.2])














