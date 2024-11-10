function down = tau(n,k)
    j = sum(dec2bin(k)-'0', 2);
    down = n-j;
end