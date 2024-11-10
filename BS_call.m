function c = BS_call(S,X,r,T,sigma,q)

  d1 = (log(S/X) + (r-q+sigma^2/2)*T)/sigma/sqrt(T);
  d2 = d1 - sigma * sqrt(T);
  c = S.*exp(-q*T).*normcdf(d1) - X*exp(-r*T)*normcdf(d2);

end