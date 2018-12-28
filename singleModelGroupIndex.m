clear;clc;
absPath = 'D:\myproj\бшнд\slowlight waveguide\rsoft\RESULT';

fileName = 'mosttmp_bs_bandmap_te__slice_';


c = 3e8;
a = 0.36e-6;

FR = 30;
DZ = 60;
DK = 48;
% Z = zeros(FR,DZ,49);% 1st. <firstRatioR> 0 to 0.25    2nd. <deltaZ> -0.04 to 0.04  
% figure;
% for i=0:4
%     for j=0:4
%         path = [absPath,'\',fileName,int2str(i),'_',int2str(j),'.dat'];
%         A = load(path);
%         Z(i+1,j+1,:) = A(2:end,423);
%         plot(A(2:end,423));hold on;
%     end
% end

load('Z.mat');

ZNG = zeros(FR,DZ,DK);

NG = zeros(FR,DZ);
MF = NG;
NDBP = NG;
WD = NG;
figure;
for i=1:FR
    for j=1:DZ
        temp = zeros(1,DK);
        for m=1:DK         
            df = (Z(i,j,m+1)-Z(i,j,m))*c/a;
            dk = 0.25/DK*(2*pi)/a;
            temp(m) = dk/df*c/(2*pi)*2.2;
            temp(1) = temp(2);
            
        end
        ZNG(i,j,:) = temp(:);
        if(i==1&&j==1)
            temp(1:6) = -6000;
        end
        plot(temp);hold on;
        
        NG(i,j) = max(temp);
        MF(i,j) = Z(i,j,temp == NG(i,j))*c/a*1e-12;
        th = NG(i,j)*1.06;
        index = find(temp>=th);
        wd = (Z(i,j,index(end))*c/a) - (Z(i,j,index(1))*c/a);
        f0 = (Z(i,j,index(end))*c/a) + (Z(i,j,index(1))*c/a)/2;
        WD(i,j) = wd/f0;
        NDBP(i,j) = WD(i,j)*NG(i,j);
        
    end
end


NG = -1*NG;
WD = -1*WD;


x=1:FR;y=1:DZ;
[X,Y] = meshgrid(x,y);
figure;mesh(X,Y,NG');title('NG');
figure;mesh(X,Y,WD');hold on;title('WD');
figure;mesh(X,Y,NDBP'); title('NDBP');
figure;mesh(X,Y,MF'); title('MF');


