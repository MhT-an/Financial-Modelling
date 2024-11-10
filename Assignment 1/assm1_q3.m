S0 = 95;
X = 90;
r = 0.04;
q = 0;
T = 0.5;
sigma = 0.3;
N = 5:5:20;
option_px = zeros(1,4);
time_taken = zeros(1,4);

for i = 1:length(N)
    startTime = cputime;
    option_px(i) = btm_fixGeomAsianCall(S0,X,r,T,sigma,q,N(i));
    elapsed_cputime = cputime - startTime;
    time_taken(i) = elapsed_cputime;
end

figure(1);
a1 = plot(N,option_px,'r*-');
title('Fixed Geom Asian Call value vs no. of period');
xlabel('number of periods');
ylabel('option values');
%saveas(gcf, 'C:\Users\tanmi\OneDrive\Desktop\QF4102 assignment figures\Assignment 1\A1Q3iia.png');

%option value increases 'concavely' as number of time periods increase. It
%increases faster at the start then slows down. 
% As the time period increases, the averaging effect becomes more pronounced. 
% The geometric average of a larger number of observations 
% (i.e., the asset prices over a longer period) will tend to be more stable
% and will converge to the expected geometric mean. This reduces the variability in the option's value.

figure(2);
a2 = plot(N,time_taken,'r*-');
title('Fixed Geom Asian Call runtime vs no. of period');
xlabel('number of periods');
ylabel('run time');
%saveas(gcf, 'C:\Users\tanmi\OneDrive\Desktop\QF4102 assignment figures\Assignment 1\A1Q3iib.png');

%runtime of 2 state var btm fixed geom asian call function grows
%exponentially due to 2^n number of splits for average as time period
%grows. Hence FSG method can save huge amount of computation time when we
%want to compute asian options with many time periods.
