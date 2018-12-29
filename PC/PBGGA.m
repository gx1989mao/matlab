function [Zp,Yp,Xp,LC1,LC2]=PBGGA(M,N,Pm)
%--------------------------------------------------------------------------
%  PBGGA.m
%  Photonic Band Gap Genetic Algorithm
%  ��ά���Ӿ���������Ŵ��Ż��㷨
%  GreenSim�Ŷӡ���רҵ���㷨���&��д����
%  ��ӭ����GreenSim�Ŷ���ҳ��http://blog.sina.com.cn/greensim
%--------------------------------------------------------------------------
%  ��������
%  ��ƽ�沨չ�����Ļ����ϣ�ʹ���Ŵ��㷨Ѱ�Ҿ��������ӽ����Ķ�ά���Ӿ���ṹ
%--------------------------------------------------------------------------
%  ��Ҫ�ο�����
%  ������,����ΰ.�����Ŵ��㷨�Ż������ά���Ӿ���[J].
%  �뵼��ѧ��.2006,27(6):1098-1102
%--------------------------------------------------------------------------
%  ��������б�
%  M     �Ŵ�������������
%  N     ��Ⱥ��ģ(ȡż��)
%  Pm    �������
%--------------------------------------------------------------------------
%  Zp    ������
%  Yp    ������������������
%  Xp    ���Ӿ���ṹ���߱�����10��10��01����
%  LC1   ��������1���������Ÿ�����Ӧֵ�ļ�¼
%  LC2   ��������2������Ⱥ��ƽ����Ӧֵ�ļ�¼
%--------------------------------------------------------------------------
%��һ����������ʼ��
epsa=11.56;%���ʽ�糣��
epsb=1;%������糣��
Xp=zeros(10,10);%���Žṹ
Yp=zeros(1,2);%����������
Zp=0;%�������
LC1=zeros(1,M);%��������1
LC2=LC1;%��������2
%�ڶ��������������ʼ��Ⱥ
farm=cell(1,N);%����ϸ���ṹ�洢��Ⱥ
for i=1:N
    A=unidrnd(2,5,10)-ones(5,10);%���ڻ�����Ԫ�ṹ�����ĶԳƵģ�����ֻ��Ҫ�Ծ�����ϰ벿�ֽ��г�ʼ��
    B=Flipud(fliplr(A));%ʣ�ಿ���������µ��ã�����������ת
    C=[A;B];%�������ֺϲ�
    farm{i}=reshape(C,100,1);%���屻�洢��ϸ���ṹfarm��
end
counter=0;%���õ���������
while counter<M%ֹͣ����Ϊ�ﵽ����������    
    %������������
    newfarm=cell(1,N);%�������������Ⱥ����������
    Ser=randperm(N);%�����������֤������
    for i=1:2:(N-1)
        AA=reshape(farm{Ser(i)},10,10);% �������������������
        BB=reshape(farm{Ser(i+1)},10,10);
        A=AA(1:5,:);%Ϊ��֤�Գ��ԣ�������ȡ����һ��Ļ���
        B=BB(1:5,:);
        Manner=unidrnd(2);%���ѡ�񽻲淽ʽ        
        if Manner==1%�ύ��
            cp=unidrnd(4);%���ѡ�񽻲��
            a=[A(1:cp,:);B((cp+1):5,:)];%˫��˫�ӵ��㽻��
            b=[B(1:cp,:);A((cp+1):5,:)];
        else%�н���
            cp=unidrnd(9);%���ѡ�񽻲��
            a=[A(:,1:cp),B(:,(cp+1):10)];%˫��˫�ӵ��㽻��
            b=[B(:,1:cp),A(:,(cp+1):10)];
        end
        a=[a;Flipud(fliplr(a))];%���ݶԳ�
        b=[b;Flipud(fliplr(b))];
        newfarm{i}=reshape(a,100,1);%�������Ӵ�����newfarm
        newfarm{i+1}=reshape(b,100,1);
    end
    %�¾���Ⱥ�ϲ�
    FARM=[farm,newfarm];    
    %���Ĳ���ѡ����
    FITNESS=zeros(1,2*N);
    fitness=zeros(1,N);
    for i=1:(2*N)
        X=FARM{i};
        Band=pixelTM(X,10,epsa,epsb,0);%����ƽ�沨չ�����ĳ����м�������ͼ
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
        Z=BB(pos(1));%���Ľ�����Ϊ��Ӧֵ
        FITNESS(i)=Z;
    end
    Ser=randperm(2*N);%ѡ���Ʋ�ȡ���������Ծ����ķ�ʽ�����б������Ÿ��������
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
    %��¼��Ѹ������������
    maxfitness=max(fitness);
    meanfitness=mean(fitness);
    LC1(counter+1)=maxfitness;%��������1���������Ÿ�����Ӧֵ�ļ�¼
    LC2(counter+1)=meanfitness;%��������2������Ⱥ��ƽ����Ӧֵ�ļ�¼
    pos=find(fitness==maxfitness);
    xp=farm{pos(1)};
    Zp=maxfitness;
    Xp=reshape(xp,10,10);        
    %���岽������
    for i=1:N
        if Pm>rand;%�������ΪPm
            X=farm{i};
            XX=reshape(X,10,10);%Ϊ��֤�Գ��ԣ����Ƚ�����������
            XA=XX(1:5,:);
            posX=unidrnd(5,1,1);%���ѡȡ����λ
            posY=unidrnd(10,1,1);
            XA(posX(1),posY(1))=mod(XA(posX(1),posY(1))+1,2);
            %XA(posX(2),posY(2))=mod(XA(posX(2),posY(2))+1,2);
            XB=Flipud(fliplr(XA));
            XX=[XA;XB];
            farm{i}=reshape(XX,100,1);%��ԭ������̬
        end
    end
    farm{pos(1)}=reshape(Xp,100,1);    
    counter=counter+1;
end            
%����������ͼ
figure(1);
xp=reshape(Xp,100,1);
Band=pixelTM(xp,10,epsa,epsb,1);%�����Ÿ���Ľ���ͼ
B1=Band(:,1);
B2=Band(:,2);
BB=abs(B1-B2);
pos=find(BB==max(BB));
Zp=BB(pos(1));
Yp=[B1(pos(1)),B2(pos(1))];
figure(2);
plot(LC1);%����������1
figure(3);
plot(LC2);%����������2
