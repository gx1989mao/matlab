clc;
clear;

a = load('E:\Rsoft1223\mosttmp_work\results\mosttmp_bs_bandmap_te.dat');
a(1,:) = [];
a(:,1) = [];

d = sort(a,2);

 for j =1932:-1:1
    if d(1,j)>0.03 &&  d(1,j)<0.035   
       break;
    end
  end

 for k =1:1:1932
    if d(1,k)>0.03 &&  d(1,k)<0.035   
       break;
    end
 end
 
 clf;
% figure(1); 
% plot(d);
% figure(2);
% plot(d(:,k-1:j+1));
% hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Band_high = min(d(:,j+1));
Band_low  = max(d(:,k-1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% plot([1,49],[Band_high,Band_high],'r');
% plot([1,49],[Band_low,Band_low],'r');
% axis([1 49 0 0.045]);



der = zeros(49,1);
for i=1:1:49 
    der(i,1) = (d(i,k)-Band_high);  
end
cut = 0;
val = 1000;
for i=1:1:49 
    if abs(der(i,1))<val && der(i,1)<=0
        val = abs(der(i,1));
        cut = i;
    end     
    if i-cut>4
        break;
    end
end

figure(3);
plot(d(1:1:cut,k));

real = d(1:1:cut+1,k);

figure(4);
x = real(:,1);
y = 0.01:0.01:0.26;
x = 300.*x;
plot(x,y,'o');
ay = 1:1:cut;
ax = real(1:cut,1);
for i=1:1:cut
    ay(i) = 0.01/(x(i+1)-x(i));
end
figure(5);
plot(ax,ay,'o');

