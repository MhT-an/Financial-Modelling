%Q1ii&iii
T = 1;
X = 1.2;
sigma = 0.3;
q = 0.01;
r = 0.05;
H = 0.9;
S0 = 0.8:0.01:1.8;

figure (1);
C01 = BS_doCall(S0,X,r,T,sigma,q,H);
a1 = plot(S0,C01,'r.-'); M1 = 'Down-and-Out with barrier equals 0.9';
hold on;
C02 = BS_call(S0,X,r,T,sigma,q);
a2 = plot(S0,C02, 'm.-');  M2 = 'European vanilla option black scholes value';
title('European Down-and-Out option Compared with Plain Vanilla');
xlabel('initial underlier price');
ylabel('option values');
legend([a1,a2],M1,M2);
hold off;
% saveas(gcf, 'C:\Users\tanmi\OneDrive\Desktop\QF4102 assignment figures\Assignment 1\A1Q1iiandiii.png');

% Q1ii Options with S0 < H will give a negative value. This is because the
% option cannot be exercised after it's price falls below H. As S0
% increases, holding all other parameters the same, the value of down out
% call option increases too. This is because value of a call option is
% given by max(S-X,0). As underlying price increases, investor confidence
% will also increase and hence, the value of option increases.
% 
% Q1iii In general, BS price is higher than DO price with same underlier price and
% maturity time, especially when S0 is low. This is because with the
% barrier, some branches of price path will be down and out. Hence value of
% a down and out call option will be lower.

%Q1iv
T = 1;
X = 1.2;
sigma = 0.3;
q = 0.01;
r = 0.05;
H = 0.4:0.01:1.2;
S0 = 1.3;

figure(2);
C03 = BS_doCall(S0,X,r,T,sigma,q,H);
a3 = plot(H,C03,'r.-');
hold on;
C04 = BS_call(S0,X,r,T,sigma,q);
a4 = plot(H,C04, 'm.-');
title('European Down-and-Out option Compared with Plain Vanilla');
xlabel('barrier price');
ylabel('option values');
hold off;
% saveas(gcf, 'C:\Users\tanmi\OneDrive\Desktop\QF4102 assignment figures\Assignment 1\A1Q1iv.png');

%Q1v
T = 1;
X = 1.2;
sigma = 0.3;
q = 0.01;
r = 0.05;
H = 0.9;
S0 = 1.3;
N = 3070:1:3180;

btm_do_c = zeros(length(N),1);

for i = 1:(length(N))
    btm_do_c(i) = btm_doCall(S0,X,r,T,sigma,q,H,N(i));
end

bs_do_c = BS_doCall(S0,X,r,T,sigma,q,H);

error = btm_do_c - bs_do_c;

figure(3);
a5 = plot(N, error, 'm*-');   % mark each data point with an asterisk in red
ylabel('method error');
xlabel('Number of steps');
title('BTM error of Down-and-Out call option');
legend(a5,'error');
% saveas(gcf, 'C:\Users\tanmi\OneDrive\Desktop\QF4102 assignment figures\Assignment 1\A1Q1v.png');


%Q1vi
%N = 3077, N = 3167 yields lowest error
low_err_N = [3077,3167];
Q1vi = sqrt(low_err_N).*(-log(H/S0))./sigma;
disp(Q1vi);