% Q1ii
S0 = 1;
X = 1;
T = 0.5;
r = 0.02;
q = 0.03;
sigma = 0.5;
dt = 0.01;
h = 0.05;
N = round(T/dt);
I = round(3*X/h);

FD_eds_call(S0,X,r,T,sigma,q,N,I)
% Output: At S0=1 exact value=0.13612 FD value=-5.601119565408952e+20
% Coeff a, Of 59 elements, 0 violated the positivity condition.
% Coeff b, Of 59 elements, 39 violated the positivity condition.
% Coeff c, Of 59 elements, 0 violated the positivity condition.
% Comment: Estimation clearly loses all the significant figures and possess
% significant negative value whilst BS gives positive value. It is clearly
% not acceptable. Checking for violation of monotonicity condition, we get
% the following ^^^
% Clearly, the coefficient b has positivity condition violated thus making
% the scheme non-convergent. As we can seem the estimated value we got is
% too far away from the true value. This is because the N we use is too
% small and the explicit scheme becomes non-convergent.

% Q1iv N>450
% Output: At S0=1 exact value=0.13612 FD value=0.13583

Nmin = 451;

FD_eds_call(S0,X,r,T,sigma,q,Nmin,I);

% Q1v
% n = 342
% At S0=1 exact value=0.13612 FD value=0.13356
% n = 341
% At S0=1 exact value=0.13612 FD value=0.14687

for n = 345:-1:341
    disp(['At n = ', num2str(n)]);
    FD_eds_call(S0,X,r,T,sigma,q,n,I);
end