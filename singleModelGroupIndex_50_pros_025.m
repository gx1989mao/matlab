clear;clc;

FR = 33;
DZ = 60;
DK = 49;
Z = zeros(FR,DZ,50);% 1st. <firstRatioR> 0.08 to 0.2 R   2nd. <deltaZ> -0.035 to 0.1715

fileName = 'mosttmp_bs_bandmap_te__slice_';


absPath = 'D:\Research\research\paper\slowlight waveguide\simulation\mosttmp_work\dataStore\now\R_z';
for i=1:20
    for j=0:2
        for k = 1:21
            path = [absPath,int2str(i),'\',fileName,int2str(j),'_',int2str(k-1),'.dat'];
            A = load(path);
            dZ_Index = (i-1)*3+j+1;
            Z(k,dZ_Index,:) = A(:,267);
        end
    end
end
absPathf = 'D:\Research\research\paper\slowlight waveguide\simulation\mosttmp_work\dataStore\now2_FR\R_f';
for i=1:4
    for j=1:60
        for k=1:3
            pathf = [absPathf,int2str(i),'\',fileName,int2str(j-1),'_',int2str(k-1),'.dat'];
            Af = load(pathf);
            f_Index = (i-1)*3+k;
            Z(21+f_Index,j,:) = Af(:,267);
        end
    end
end





c = 3e8;
a = 0.4e-6;


ZNG = zeros(FR,DZ,DK);
NG = zeros(FR,DZ);
WD = NG;
NDBP = NG;
FRE = NG;
for i=1:FR
    for j=1:DZ
        temp = zeros(1,DK);
        for m=1:DK
            
            df = (Z(i,j,m+1)-Z(i,j,m))*c/a;
            dk = 0.5/DK*(2*pi)/a;
            temp(m) = dk/df*c/(2*pi)*2.2;
            ZNG(i,j,:) = temp(:);
            if(min(temp>0))
                NG(i,j) = min(temp);
                th = NG(i,j)*1.06;
                index = find(temp<=th);
                wd = (Z(i,j,index(end))*c/a) - (Z(i,j,index(1))*c/a);
                f0 = (Z(i,j,index(end))*c/a) + (Z(i,j,index(1))*c/a)/2;
                WD(i,j) = wd/f0;
                NDBP(i,j) = WD(i,j)*NG(i,j);
                FRE(i,j) = Z(i,j,1);
            else
                NG(i,j) = NaN;
                WD(i,j) = NaN;
                NDBP(i,j)= NaN;
                FRE(i,j)= NaN;
            end                      
        end
    end
end
% NG = NG*2.2;
% NDBP = NDBP*2.2;
x=1:FR;y=1:DZ;
[X,Y] = meshgrid(x,y);
figure;mesh(X,Y,NG');title('NG');

TTT = WD';
figure;mesh(X,Y,TTT);hold on;title('WD');
% for i=1:FR
%     for j=1:DZ
%         
%         if(TTT(j,i)<0.02 )
%             plot3(y(i),x(j),TTT(j,i),'ro');hold on;
%         end
%     end
% end

figure;mesh(X,Y,NDBP'); title('NDBP');
figure;mesh(X,Y,FRE'); title('NDBP');


% 第一行0.08R的全部色散曲线
% figure;
% KK = zeros(60,50);
% for i=1:60
%     KKK = zeros(1,50);KKK(1,:)= Z(24,i,:);plot(KKK);hold on;
%     KK(i,:) = Z(24,i,:);
% end
% figure;
% mesh(KK);



