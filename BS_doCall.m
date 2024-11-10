function c = BS_doCall(S0,X,r,T,sigma,q,H)

    lambda = (r-q+sigma^2/2)/(sigma^2);
    y = log((H.*H/X)./S0)./(sigma*sqrt(T)) + lambda*sigma*sqrt(T);
    BS_c = BS_call(S0, X, r, T, sigma, q);

    c = BS_c - (S0.*exp(-q*T)).*(H./S0).^(2*lambda).*normcdf(y)...
    + (X*exp(-r*T)).*(H./S0).^(2*lambda-2).*normcdf(y-sigma*sqrt(T));
end