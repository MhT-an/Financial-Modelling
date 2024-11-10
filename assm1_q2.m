% (iii)

S0 = 0.85;
runmin = 0.75;
sigma = 0.35;
r = 0.03;
q = 0;
T = 0.5;

N = 200:200:10000;
val = zeros(1,length(N));

for i = 1:length(N)
    val(i) = btm_1vFlLookbackCall(S0,r,T,sigma,q,N(i),runmin);
end


% comment on graph obtained
% non-newly issued option value converges to 0.178. Option value increases
% with decreasing rate and converges quickly to a stable value around 0.18.
% As step size becomes larger, the increase in value becomes very small and
% thus insignificant.
% (iv) runmin = S0 for newly issued option

default_val = zeros(1,length(N));

for i = 1:length(N)
    default_val(i) = btm_1vFlLookbackCall(S0,r,T,sigma,q,N(i));
end

a1 = plot(N, val, 'm*-'); M1 = 'not newly issued';
hold on;
a2 = plot(N, default_val, 'r*-'); M2 = 'newly issued';
title('Single state LB call value');
xlabel('no. of periods');
ylabel('option values');
legend([a1;a2],M1,M2);
hold off;
%saveas(gcf, 'C:\Users\tanmi\OneDrive\Desktop\QF4102 assignment figures\Assignment 1\A1Q2iiiandiv.png');

% compare and comment
% newly issued converges to 0.16
% expresses similar trend in its value with the increasing number of steps.
% Value converges around 0.16. Option value is lower than that of non-newly
% issued when at time 0, the current running min is lower than underlier
% price. This arises from a higher probability of getting a higher payoff
% as the payoff function is (ST - runningmin)+ so the smaller the
% runningmin, the higher the profit, and hence higher option value