function [ miu ] = miuC( vg,er )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

e     = 1.6e-19;%电子电量
h     = 6.62607e-34;
hba   = h/(2*pi);
miu = hba*vf*sqrt(pi*er*e0*vg/d/e);

end

