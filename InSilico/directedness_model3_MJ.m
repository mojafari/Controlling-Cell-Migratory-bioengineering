function out = directedness_model3_MJ(EF,dir,ss,n,tt)
%if you want to change the direction of the cell to Anode or Cathode you
%can change "dir"

% In general, you can generate random number in the interval (a,b) with the formula r = a + (b-a)*rand.

if EF == 0
    pp = 1;
else
    pp = 1/abs(EF);
end

out = (1./(1 + exp(-(n-tt))))*(dir/ss)*((2*rand - 1) + ((EF/ss + sign(EF)*ss*abs(EF)^(pp))/(abs(EF)^(pp)+1)));

if out>1
    out=1;
elseif out<-1
    out=-1;
else
    out=out;
end

end