function v = fsg_fixArithAsianCall(S0,X,r,T,sigma,q,N,L,runavg,Nhist)

 dt = T/N;
 dx = sigma * sqrt(dt);
 dy = 1/L * dx;
 u = exp(dx);
 d = exp(-dx);
 p = (exp((r-q)*dt) - d) / (u-d);
 
 runavg = (runavg * Nhist + S0) / (Nhist + 1);

 Average = zeros(2*N*L+1, 1); 
 jshift = 1;
 kshift = N*L + 1;
 
 for k = (-N*L):1:(N*L)
    Average(k + kshift) = runavg * exp(k*dy);
 end
 
 %% Initialization
 V = zeros(N+1, 2*N*L+1); % j, k one dimensional matrix
 for j = 0:1:N
     for k = (-N*L):1:(N*L)
        V(j+jshift, k+kshift) = max((Average(k+kshift) - X), 0);
     end
 end
 
 %% Algorithm: backward iteration
 for n = (N-1):-1:0
    Vtemp = zeros(n+1, 2*n*L+1); % the current option value storage
    for j = n:-1:0 % for different price states-----
        
        S = S0 * exp((2 * j - n) * dx); %current price state
        
        for k = (-n*L):1:(n*L) % for different average (1 line below)------
            
            A = Average(k + kshift); % current running average 
            
            % up branch====== j+1 is used
            A_u = (S * u + (n + Nhist + 1) * A) / (n + Nhist + 2); % up branch average
            ku = log(A_u / runavg) / dy;
            ku_fl = floor(ku) + kshift; % indexing for average vector
            ku_cl = ku_fl + 1; 

            ku_fl_v = floor(ku) + (n+1)*L + 1; % indexing for matrix V
            ku_cl_v = ku_fl_v + 1;

            Vu_fl = V(j+1+jshift, ku_fl_v);
            Vu_cl = V(j+1+jshift, ku_cl_v);
            Vu = LinearInterpolate(ku + kshift, ku_fl, ku_cl, Vu_fl, Vu_cl);
            
            % down branch====== j is used
            A_d = (S * d + (n + Nhist + 1) * A) / (n + Nhist + 2);
            kd = log(A_d / runavg) / dy;
            kd_fl = floor(kd) + kshift; % indexing for average vector
            kd_cl = kd_fl + 1; 

            kd_fl_v = floor(kd) + (n+1)*L + 1; % indexing for matrix V
            kd_cl_v = kd_fl_v + 1;

            Vd_fl = V(j+jshift, kd_fl_v);
            Vd_cl = V(j+jshift, kd_cl_v);
            Vd = LinearInterpolate(kd + kshift, kd_fl, kd_cl, Vd_fl, Vd_cl);

            % update V vector for current j (price states) and k (current average)
            Vtemp( j+jshift, k+(n*L)+1 ) = exp(-r * dt) * (p * Vu + (1 - p) * Vd);
            
        end
    end
    V = Vtemp;
 end
 
 v = V(1,1);
 
end