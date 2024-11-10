function v = btm_fixGeomAsianCall(S0,X,r,T,sigma,q,N)
    %(A-X) positive
    dt = T/N;
    u = exp(sigma*sqrt(dt));
    d = 1/u;
    p = (exp((r-q)*dt)-d)/ (u-d);

    jshift = 1;
    kshift = 1;

    A = S0;

    % update average
    for n = 1:N
        S = S0 * u.^(2*(0:n)-n);
        k = 0:(2^n-1);
        j = tau(n,k);
        A(k+kshift) = exp(1/(n+1)*((n*log(A(floor(k./2)+kshift))) + log(S(j+jshift))));
    end

    % terminal time
    V = max(A-X,0);

    % backward-time
    for n = N-1:-1:0
        k = 0:(2^n-1);
        V(k+kshift) = exp(-r*dt)*(p*V(2*k+1+kshift) + (1-p)*V(2*k+kshift));
    end
    v = V(1);
end