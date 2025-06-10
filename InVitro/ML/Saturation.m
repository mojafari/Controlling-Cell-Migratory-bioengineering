function uu=Saturation(u)
u_min = -0.95e-3;
u_max = 0.95e-3;

uu = max(u_min,min(u_max,u));

end