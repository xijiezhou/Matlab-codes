function ARQ1_E = arq_e(rv,qiv,J,T)
sqivrv = sqrt(qiv) .* rv;
rv1 = zeros(1, T-J-1);
ARQ1_E = zeros(1, T-J-1);
arq1beta = zeros(3, T-J-1);
    for i = 1: T-J-1
        x = zeros(J, 2);
        x1 = rv(i:i+J-1).';
        x2 = sqivrv(i:i+J-1) .';
        x(:, 1) = x1;
        x(:, 2) = x2;
        y = rv(i+1: i+J) .';
        arq1beta(:, i) = ols_beta(1,x,y);
        beta0 = arq1beta(1,i);
        beta1 = arq1beta(2,i);
        beta1q = arq1beta(3,i);
        rv1(i) = beta0 + beta1 * rv(i+J) + beta1q * sqivrv (i+J);
        meanrv = mean(rv(i+1:i+J));
        if rv1(i) < min(rv) || rv1(i) > max(rv)
            rv(i) = meanrv;
        end
        ARQ1_E(i) = rv(i+J+1)- rv1(i); 
    end
end