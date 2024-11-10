% Q2(iii)

S0 = 100;
X = 100;
r = 0.03;
T = 1;
N = 4;
L = 2;
sigma = 0.22;
q = 0;

fsg_fixArithAsianCallNew(S0,X,r,T,sigma,q,N,L)


% Q2(v)

t = 2/12;
T = 1/2;
S0 = 95;
X = 90;
r = 0.04;
sigma = 0.3;
runavg = 93;
q = 0;
N = 60:60:240;
rho = [1,0.5,0.25];
L  = 1./rho;

% find option value & runtime
fsg_ac = zeros(length(N)*length(L),1);
fsg_ac_time = zeros(length(N)*length(L),1);

for i = 1:(length(N))
    fsg_ac_N = zeros(length(L),1);
    fsg_ac_Ntime = zeros(length(L),1);
    Nhist = t/(T/N(i));
    for j = 1:(length(L))
        startTime = cputime;
        fsg_ac_N(j) = fsg_fixArithAsianCall(S0,X,r,T,sigma,q,N(i),L(j),runavg,Nhist);
        elapsed_cputime = cputime - startTime;
        fsg_ac_Ntime(j) = elapsed_cputime;
    end
    fsg_ac(i*3-2:i*3) = fsg_ac_N;
    fsg_ac_time(i*3-2:i*3) = fsg_ac_Ntime;
end

% Q2(vi)

rho1 = fsg_ac_time([1, 4, 7, 10]);
rhohalf = fsg_ac_time([2, 5, 8, 11]);
rhoquarter = fsg_ac_time([3, 6, 9, 12]);

% Plot the data
figure;
hold on;
plot(N, rho1, '-o', 'DisplayName', 'rho = 1');
plot(N, rhohalf, '-o', 'DisplayName', 'rho = 1/2');
plot(N, rhoquarter, '-o', 'DisplayName', 'rho = 1/4');
hold off; % Release the hold on the plot

xlabel('Number of Periods'); % x-axis label
ylabel('Runtime'); % y-axis label
title('Runtime comparison across different time periods'); % Title
legend show;
grid on;


