function c = btm_doCall(S0,X,r,T,sigma,q,H,N)
    dt = T/N;
    u = exp(sigma*sqrt(dt));
    d = 1/u;
    discount = exp(-r*dt);
    p = (exp((r-q)*dt)-d)/(u-d);

    % initialization
    jshift = 1;
    j = 0:N;
    V = S0*u.^(2*j-N);
    V(V < H) = 0;
    V(V>=H) = max(V(V>=H)-X,0);

    % backward recursive through time
    for n = N-1:-1:0
        j = 0:n;
        price = S0*u.^(2*j-n);
        V(j+jshift) = discount*(p*V(j+jshift+1)+(1-p)*V(j+jshift));
        V(price < H) = 0;
    end
    c = V(0+jshift);
end