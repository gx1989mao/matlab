function circle(x0,y0,R)
alpha=0:pi/50:2*pi;%�Ƕ�[0,2*pi] 
%R=2;%�뾶 
x=x0+R*cos(alpha); 
y=y0+R*sin(alpha); 
plot(x,y,'b-') 
hold on;