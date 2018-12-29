function [ miu ] = miuC( vg,er )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

e     = 1.6e-19;%电子电量
h     = 6.62607e-34;
hba   = h/(2*pi);
d = 40e-9;
eps0 = 8.85e-12;
miu = hba*vf*sqrt(pi*er*eps0*vg/d/e);

end

