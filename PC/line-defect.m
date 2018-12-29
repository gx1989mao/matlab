%%        Square lattice with a linear waveguide along x
%%         Shangping Guo
%%         Finally revised Jan 01 2001
%%         sqwavegd.m

clear all
warning off
tic;
epsa=11.56;%8.9;
epsb=1;
a=1.0;
R=0.2*a;;
i=sqrt(-1);
f=pi*R^2/a^2;
NumberofCell=5;
a1=a;
a2=a*i;
b1=2*pi/a/NumberofCell;
b2=2*pi/a/NumberofCell*i;
n=9;
NumberofPW=(2*n+1)^2;
display('Forming regular Fourier matrix...');
mind=(-NumberofPW:NumberofPW)'+NumberofPW+1;
mind=mind(:,ones(1,length(mind)))-NumberofPW-1;
GG=mind'*b1+mind*b2;

eps21=2*f*(epsa-epsb)*besselj(1,abs(GG).*R)./(abs(GG).*R);
eps21(NumberofPW+1,NumberofPW+1)=epsb+f*(epsa-epsb);
%5X5
zz=[
-2 -2;-2 -1;-2 0;-2 1;-2 2; 
-1 -2;-1 -1;-1 0;-1 1;-1 2;
 0 -2; 0 -1;      0 1; 0,2; 
 1 -2; 1 -1; 1 0; 1 1; 1 2;
 2,-2; 2,-1; 2 0; 2,1; 2,2]*[a1 a2].';
eps20=zeros(length(eps21));
for x=1:length(zz),
   eps20=eps20+exp(i*(real(GG).*real(zz(x))+imag(GG).*imag(zz(x)))).*eps21;
end

display('Modifying the defect matrix...');
R00=0.80*a;
f00=pi*R00^2/a^2;
eps00=2*f00*(epsa-epsb)*besselj(1,abs(GG).*R00)./(abs(GG).*R00);
eps00(NumberofPW+1,NumberofPW+1)=epsb+f00*(epsa-epsb);
eps20=eps20+eps00;
ff=(pi*R^2*length(zz)+pi*R00^2)/(NumberofCell^2*a^2);
eps20=eps20./NumberofCell^2;
eps20(NumberofPW+1,NumberofPW+1)=epsb+ff*(epsa-epsb);

clear GG;
count=1;
r=ones(2*n*NumberofCell+1,2);
for y=-n:n,
 for x=-n:n;
      G(count)=x*b1+y*b2;
      r(count,:)=[x,y];
      count=count+1;
   end
end

display('Building eps(G,G) matrix from the FFT matrix');
for x=1:NumberofPW,
    for y=x:NumberofPW,
        b=r(x,:)-r(y,:)+(2*n+1)^2+1;
        eps2(x,y)=eps20(b(1),b(2));
        eps2(y,x)=eps2(x,y);   
   end
%  eps2(x,x)=f*epsa+(1-f)*epsb;
end
  
k1=2*pi/a*0.5.*(0:0.1:1);;
k2=2*pi/a*(0.5+(0.1:0.1:1).*0.5*i);
k3=2*pi/a*(0.5+0.5*i).*(0.9:-0.1:0);
k0=[k1 k2 k3]./NumberofCell;
k0=0;
display('Now calculate the eigen values..');
eps2=inv(eps2);
if max(max(real(eps2))) > 10^7*max(max(imag(eps2)))
display('Your lattice is inversion symmetric');
eps2=real(eps2);
else
display('Imaginary part of FFT is not zero');       
end   

counter=1;
for ii=1:length(k0),
    k=k0(ii);
    %k=k0;
   %M=(real(k+G.')*real(k+G)+imag(k+G.')*imag(k+G)).*eps2; %TE wave
   M=abs(k+G.')*abs(k+G).*eps2; %TM wave
   [V,F]=eig(M);
   E=diag(F);
  %freq(:,counter)=sqrt(abs(E(1:10))).*a./2./pi;
    display(sprintf('calculation of k=%f+%fi is finished',real(k),imag(k)));
    counter=counter+1;
  end
[lamda,index]=sort(E);
 hg0=V(:,index(31))';
 hg1=V(:,index(32))';
 hg2=V(:,index(33))';
 hg3=V(:,index(34))';
 hg4=V(:,index(35))';
 hg5=V(:,index(36))';
 for x=(-2:0.02:2).*a
 for y=(-2:0.02:2).*a
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% below is the original code, Matlab 6.5 reports errors of them, so I
  %% changed them into the later form------------------ Li Changzhi
    %fld0(x/0.02+101,y/0.02+101)=exp(i*(real(k+G)*x+imag(k+G)*y))*(hg0.*abs(k+G))';
    %fld1(x/0.02+101,y/0.02+101)=exp(i*(real(k+G)*x+imag(k+G)*y))*(hg1.*abs(k+G))';
    %fld2(x/0.02+101,y/0.02+101)=exp(i*(real(k+G)*x+imag(k+G)*y))*(hg2.*abs(k+G))';
    %fld3(x/0.02+101,y/0.02+101)=exp(i*(real(k+G)*x+imag(k+G)*y))*(hg3.*abs(k+G))';
    %fld4(x/0.02+101,y/0.02+101)=exp(i*(real(k+G)*x+imag(k+G)*y))*(hg4.*abs(k+G))';
    %fld5(x/0.02+101,y/0.02+101)=exp(i*(real(k+G)*x+imag(k+G)*y))*(hg5.*abs(k+G))';
  %% above is the original code, Matlab 6.5 reports errors of them, so I
  %% changed them into the later form------------------ Li Changzhi
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % below is modified by lichangzhi
    fld0(round(x/0.02+101),round(y/0.02+101))=exp(i*(real(k+G)*x+imag(k+G)*y))*(hg0.*abs(k+G))';
    fld1(round(x/0.02+101),round(y/0.02+101))=exp(i*(real(k+G)*x+imag(k+G)*y))*(hg1.*abs(k+G))';
    fld2(round(x/0.02+101),round(y/0.02+101))=exp(i*(real(k+G)*x+imag(k+G)*y))*(hg2.*abs(k+G))';
    fld3(round(x/0.02+101),round(y/0.02+101))=exp(i*(real(k+G)*x+imag(k+G)*y))*(hg3.*abs(k+G))';
    fld4(round(x/0.02+101),round(y/0.02+101))=exp(i*(real(k+G)*x+imag(k+G)*y))*(hg4.*abs(k+G))';
    fld5(round(x/0.02+101),round(y/0.02+101))=exp(i*(real(k+G)*x+imag(k+G)*y))*(hg5.*abs(k+G))';
    % ubove is modified by lichangzhi
    end
  end
  fld0=fixphase(fld0);
 fld1=fixphase(fld1);
 fld2=fixphase(fld2);
 fld3=fixphase(fld3);
 fld4=fixphase(fld4);
 fld5=fixphase(fld5);
 subplot(2,2,1),surf(real(fld0+fld1)),shading interp,view(2),axis image,axis off,title('R=0.8a,degenerated level 31,32');
 subplot(2,2,2),surf(real(fld2+fld3)),shading interp,view(2),axis image,axis off,title('R=0.8a,degenerated level 33,34');
 subplot(2,2,3),surf(real(fld4)),shading interp,view(2),axis image,axis off,title('R=0.8a,level 35');
  subplot(2,2,4),surf(real(fld5)),shading interp,view(2),axis image,axis off,title('R=0.8a,level 36');
