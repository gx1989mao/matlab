function [Zp,Yp,Xp,LC1,LC2]=PBGGA(M,N,Pm)
%--------------------------------------------------------------------------
%  PBGGA.m
%  Photonic Band Gap Genetic Algorithm
%  二维光子晶体禁带的遗传优化算法
%  GreenSim团队——专业级算法设计&代写程序
%  欢迎访问GreenSim团队主页→http://blog.sina.com.cn/greensim
%--------------------------------------------------------------------------
%  函数功能
%  在平面波展开法的基础上，使用遗传算法寻找具有最大光子禁带的二维光子晶体结构
%--------------------------------------------------------------------------
%  主要参考文献
%  龚春娟,胡雄伟.快速遗传算法优化计算二维光子晶体[J].
%  半导体学报.2006,27(6):1098-1102
%--------------------------------------------------------------------------
%  输入参数列表
%  M     遗传进化迭代次数
%  N     种群规模(取偶数)
%  Pm    变异概率
%--------------------------------------------------------------------------
%  Zp    最大禁带
%  Yp    最大禁带的区间上下限
%  Xp    光子晶体结构决策变量（10×10的01矩阵）
%  LC1   收敛曲线1，各代最优个体适应值的记录
%  LC2   收敛曲线2，各代群体平均适应值的记录
%--------------------------------------------------------------------------
%第一步：变量初始化
epsa=11.56;%介质介电常数
epsb=1;%空气介电常数
Xp=zeros(10,10);%最优结构
Yp=zeros(1,2);%禁带上下限
Zp=0;%禁带宽度
LC1=zeros(1,M);%收敛曲线1
LC2=LC1;%收敛曲线2
%第二步：随机产生初始钟群
farm=cell(1,N);%采用细胞结构存储种群
for i=1:N
    A=unidrnd(2,5,10)-ones(5,10);%由于基本单元结构是中心对称的，所以只需要对矩阵的上半部分进行初始化
    B=Flipud(fliplr(A));%剩余部分先做上下倒置，再做左右旋转
    C=[A;B];%把两步分合并
    farm{i}=reshape(C,100,1);%个体被存储在细胞结构farm中
end
counter=0;%设置迭代计数器
while counter<M%停止条件为达到最大迭代次数    
    %第三步：交叉
    newfarm=cell(1,N);%交叉产生的新种群存在这里面
    Ser=randperm(N);%用这个函数保证随机配对
    for i=1:2:(N-1)
        AA=reshape(farm{Ser(i)},10,10);% 待交叉的两个父代个体
        BB=reshape(farm{Ser(i+1)},10,10);
        A=AA(1:5,:);%为保证对称性，需先提取其中一半的基因
        B=BB(1:5,:);
        Manner=unidrnd(2);%随机选择交叉方式        
        if Manner==1%横交叉
            cp=unidrnd(4);%随机选择交叉点
            a=[A(1:cp,:);B((cp+1):5,:)];%双亲双子单点交叉
            b=[B(1:cp,:);A((cp+1):5,:)];
        else%列交叉
            cp=unidrnd(9);%随机选择交叉点
            a=[A(:,1:cp),B(:,(cp+1):10)];%双亲双子单点交叉
            b=[B(:,1:cp),A(:,(cp+1):10)];
        end
        a=[a;Flipud(fliplr(a))];%反演对称
        b=[b;Flipud(fliplr(b))];
        newfarm{i}=reshape(a,100,1);%交叉后的子代存入newfarm
        newfarm{i+1}=reshape(b,100,1);
    end
    %新旧种群合并
    FARM=[farm,newfarm];    
    %第四步：选择复制
    FITNESS=zeros(1,2*N);
    fitness=zeros(1,N);
    for i=1:(2*N)
        X=FARM{i};
        Band=pixelTM(X,10,epsa,epsb,0);%调用平面波展开法的程序，中间结果不画图
        B1=Band(:,1);
        B2=Band(:,2);
        for j=1:length(B1)
            if B1(j)>1||B2(j)>1
                B1(j)=0;
                B2(j)=0;
            end
        end
        BB=abs(B1-B2);
        pos=find(BB==max(BB));
        Z=BB(pos(1));%最宽的禁带作为适应值
        FITNESS(i)=Z;
    end
    Ser=randperm(2*N);%选择复制采取两两随机配对竞争的方式，具有保留最优个体的能力
    for i=1:N
        f1=FITNESS(Ser(2*i-1));
        f2=FITNESS(Ser(2*i));
        if f1>=f2
            farm{i}=FARM{Ser(2*i-1)};
            fitness(i)=FITNESS(Ser(2*i-1));
        else
            farm{i}=FARM{Ser(2*i)};
            fitness(i)=FITNESS(Ser(2*i));
        end
    end
    %记录最佳个体和收敛曲线
    maxfitness=max(fitness);
    meanfitness=mean(fitness);
    LC1(counter+1)=maxfitness;%收敛曲线1，各代最优个体适应值的记录
    LC2(counter+1)=meanfitness;%收敛曲线2，各代群体平均适应值的记录
    pos=find(fitness==maxfitness);
    xp=farm{pos(1)};
    Zp=maxfitness;
    Xp=reshape(xp,10,10);        
    %第五步：变异
    for i=1:N
        if Pm>rand;%变异概率为Pm
            X=farm{i};
            XX=reshape(X,10,10);%为保证对称性，需先将个体基因变形
            XA=XX(1:5,:);
            posX=unidrnd(5,1,1);%随机选取变异位
            posY=unidrnd(10,1,1);
            XA(posX(1),posY(1))=mod(XA(posX(1),posY(1))+1,2);
            %XA(posX(2),posY(2))=mod(XA(posX(2),posY(2))+1,2);
            XB=Flipud(fliplr(XA));
            XX=[XA;XB];
            farm{i}=reshape(XX,100,1);%还原个体形态
        end
    end
    farm{pos(1)}=reshape(Xp,100,1);    
    counter=counter+1;
end            
%输出结果并绘图
figure(1);
xp=reshape(Xp,100,1);
Band=pixelTM(xp,10,epsa,epsb,1);%画最优个体的禁带图
B1=Band(:,1);
B2=Band(:,2);
BB=abs(B1-B2);
pos=find(BB==max(BB));
Zp=BB(pos(1));
Yp=[B1(pos(1)),B2(pos(1))];
figure(2);
plot(LC1);%画收敛曲线1
figure(3);
plot(LC2);%画收敛曲线2
