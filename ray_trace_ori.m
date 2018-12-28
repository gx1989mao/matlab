clc;
clear;

R = 500;

delta = R/1e4;

path = zeros(100000,3);


path(1,1) = -R+100*delta;
path(1,2) = 0;
path(1,3) = 30.01; %% angle between ray and x-axis
in = 1;%% input 1 left 2 right 3 up 4 down
num = 1;
box_x = -R+100*delta;
box_y = 0;
flag = 0;
tic;
while(1)
%%% input relative position and angle
    x = path(num,1);
    y = path(num,2);
    theta = path(num,3);
    num = num+1;
%%% travel through this box & find next box
    T = tan(theta/180*pi);
    
    if(in == 1)  %% left
        if(T*delta + y > delta + box_y)
            in = 4;
            path(num,1) = (delta - (y - box_y)) / T + x;
            path(num,2) = box_y + delta;
            t1 = 90-theta;
            r1 = sqrt(box_x^2+box_y^2);
            if(r1>R)
                n1 = 1;
            else
                n1 = 2/(1+(r1/R)^2);
            end
            box_y = box_y + delta;
            r2 = sqrt(box_x^2+box_y^2);
            if(r2>R)
                n2 = 1;
            else
                n2 = 2/(1+(r2/R)^2);
            end
            t2 = asin(n1*sin(t1/180*pi)/n2)/pi*180;
            path(num,3) = 90-t2;       
            
        elseif(T*delta + y < box_y)
            in = 3;
            path(num,1) = -(y - box_y) / T + x;
            path(num,2) = box_y;
            t1 = 90+theta;
            r1 = sqrt(box_x^2+box_y^2);
            if(r1>R)
                n1 = 1;
            else
                n1 = 2/(1+(r1/R)^2);
            end
            box_y = box_y - delta; 
            r2 = sqrt(box_x^2+box_y^2);
            if(r2>R)
                n2 = 1;
            else
                n2 = 2/(1+(r2/R)^2);
            end
            t2 = asin(n1*sin(t1/180*pi)/n2)/pi*180;
            path(num,3) = t2-90;    
            
        else
            in = 1;
            path(num,1) = x + delta;
            path(num,2) = T*delta + y;
            t1 = abs(theta);
            r1 = sqrt(box_x^2+box_y^2);
            if(r1>R)
                n1 = 1;
            else
                n1 = 2/(1+(r1/R)^2);
            end
            box_x = box_x + delta;   
            r2 = sqrt(box_x^2+box_y^2);
            if(r2>R)
                n2 = 1;
            else
                n2 = 2/(1+(r2/R)^2);
            end

            if(abs(theta)<0.5 && flag == 0)
                path(num,3) = -theta; 
                flag = 1;
            else
                t2 = asin(n1*sin(t1/180*pi)/n2)/pi*180;
                path(num,3) = t2*(theta/abs(theta)); 
            end
            
            
        end
    elseif(in == 3) %% up
        if(-delta/T + x > delta + box_x)
            in = 1;
            path(num,1) = box_x + delta;
            path(num,2) = (delta - (x - box_x))*T + y;
            t1 = -theta;
            r1 = sqrt(box_x^2+box_y^2);
            if(r1>R)
                n1 = 1;
            else
                n1 = 2/(1+(r1/R)^2);
            end
            box_x = box_x + delta;
            r2 = sqrt(box_x^2+box_y^2);
            if(r2>R)
                n2 = 1;
            else
                n2 = 2/(1+(r2/R)^2);
            end
            t2 = asin(n1*sin(t1/180*pi)/n2)/pi*180;
            path(num,3) = -t2;
%             disp('31');
        else
            in = 3;
            path(num,1) = -delta/T + x;
            path(num,2) = y - delta;
            t1 = theta+90;
            r1 = sqrt(box_x^2+box_y^2);
            if(r1>R)
                n1 = 1;
            else
                n1 = 2/(1+(r1/R)^2);
            end
            box_y = box_y - delta;   
            r2 = sqrt(box_x^2+box_y^2);
            if(r2>R)
                n2 = 1;
            else
                n2 = 2/(1+(r2/R)^2);
            end
            t2 = asin(n1*sin(t1/180*pi)/n2)/pi*180;
            path(num,3) = t2-90;
%             disp('33');
        end
    elseif(in == 4) %% down
        if(delta/T + x > box_x + delta)
            in = 1;
            path(num,1) = box_x + delta;
            path(num,2) = (delta-(x - box_x))*T + y;
            t1 = theta;
            r1 = sqrt(box_x^2+box_y^2);
            if(r1>R)
                n1 = 1;
            else
                n1 = 2/(1+(r1/R)^2);
            end
            box_x = box_x + delta;   
            r2 = sqrt(box_x^2+box_y^2);
            if(r2>R)
                n2 = 1;
            else
                n2 = 2/(1+(r2/R)^2);
            end
            t2 = asin(n1*sin(t1/180*pi)/n2)/pi*180;
            path(num,3) = t2;
        else
            in = 4;
            path(num,1) = delta/T + x;
            path(num,2) = y + delta;
            t1 = theta;
            r1 = sqrt(box_x^2+box_y^2);
            if(r1>R)
                n1 = 1;
            else
                n1 = 2/(1+(r1/R)^2);
            end
            box_y = box_y + delta;    
            r2 = sqrt(box_x^2+box_y^2);
            if(r2>R)
                n2 = 1;
            else
                n2 = 2/(1+(r2/R)^2);
            end
            if(theta<1e-1)
                path(num,3) = -theta; 
            else
                t2 = asin(n1*sin(t1/180*pi)/n2)/pi*180;
                path(num,3) = 90-t2;
            end
        end           
    end

%%% if out of lens area, break while
if(num>30008)
    break;
end
end
toc;
figure();
rectangle('Position',[-R,-R,2*R,2*R],'Curvature',[1,1]);hold on;
for num=1:100:30008
    plot(path(num,1),path(num,2),'.');hold on;
end
figure();
plot(path(1:10:30008,3),'-');hold on;












