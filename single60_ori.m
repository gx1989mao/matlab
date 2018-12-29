clc;clear;

absPath = 'D:\myproj\бшнд\slowlight waveguide\rsoft\RESULT\';
% fileName = 'mosttmp_bs_bandmap_te__slice_';

path = [absPath,'mosttmp_bs_bandmap_te__slice_0_0.dat'];

A = load(path);
figure;
for i=2:426
    plot(A(:,i),'b');hold on;
    if(A(1,i)>0.035 && A(1,i)<0.04)
        temp = i;
    end
  
end

plot(A(:,temp),'r*');hold on;
plot(A(1,temp),'bo');hold on;





