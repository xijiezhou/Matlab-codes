function J = simcp(Y,U,N,n,T)
J = zeros(n*T+1,1);
for i = 0:n*T
    for k = 1:N
     if U(k) <= i/(n*T)
            J(i+1) = J(i+1)+Y(k);
     else
            J(i+1) = J(i+1);
     end
    end
end