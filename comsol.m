clear;clc;

F = 9e12:0.1e12:35e12;

for i=1:length(F)
Bdr(i) = real(gN(0.2,F(i) ));
Bdi(i)  = imag(gN(0.2,F(i) ));
Bbr(i)  = real(gN(1,F(i) ));
Bbi(i)  = imag(gN(1,F(i) ));
end