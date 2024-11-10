function v = btm_1vFlLookbackCall(S0,r,T,sigma,q,N,runmin)
    arguments
        S0; r; T; sigma; q; N;
        runmin = S0;
    end

    dt = T/N;
    u = exp(sigma*sqrt(dt));
    d = 1/u;
    p = (exp((r-q)*dt)-d)/(u-d);
    dx = sigma*sqrt(dt);
    x0 = log(min(S0,runmin)/S0);
    start_index = -floor(x0/dx);
    ishift = 1;

    lowest_index_available = max(start_index - N,0);
    i = lowest_index_available:(start_index+N+1);
    x = -i*dx;
    W = 1 - exp(x);

    for n = N-1:-1:0
        i = max(start_index-n,0):(start_index+n+1);
        W(i+ishift) = exp(-r*dt)*(p*u*W(i+1+ishift) + (1-p)*d*W(max(i-1,0)+ishift));
    end

    y1=S0*W(start_index+ishift);
    y2=S0*W(start_index+1+ishift);
    x1=-(start_index*dx);
    x2=-((start_index+1)*dx);
    v = ((x0-x2)/(x1-x2))*y1 + ((x0-x1)/(x2-x1))*y2;

end