function HAR1Q_E = harq_e(rv,QIV,J,T)
sqivrv = sqrt(QIV) .* rv;
harq1beta = zeros(5, T-J-1-21);
rv1 = zeros(1, T-J-1-21);
HAR1Q_E = zeros(1, T-J-1-21);
rvw = zeros(1,J);
rvm = zeros(1,J);
    for i = 1: T-J-1-22
        x1 = rv(21+i: 21+i+J-1).';
        x2 = sqivrv(21+i: 21+i+J-1) .';
        for j = 1:J
            rvw(j) = mean(rv(21+i-5+j : 21+i+j-1));
            rvm(j) = mean(rv(i+j-1 : 21+i+j-1 ));
        end
        x = zeros(J, 4);
        x(:, 1) = x1;
        x(:, 2) = x2;
        x(:, 3) = rvw.';
        x(:, 4) = rvm .';
        y = rv(21+i+1: 21+i+J) .';
        harq1beta(:, i) = ols_beta(1,x,y);
        beta0 = harq1beta(1,i);
        beta1 = harq1beta(2,i);
        beta1q = harq1beta(3,i);
        betaw = harq1beta(4,i);
        betam = harq1beta(5,1);
        rvwt = mean(rv(21+i-5+1 : 21+i));
        rvmt = mean(rv(i: 21+i));
        rv1(i) = beta0 + beta1 * rv(21+i+J) + beta1q * sqivrv (21+i+J) + betaw * rvwt + betam * rvmt;
        meanrv = mean(rv(21+1+i: 21+i+J));
        if rv1(i) < min(rv) || rv1(i) > max(rv)
            rv(i) = meanrv;
        end
       HAR1Q_E(i) = rv(i+J+1)- rv1(i); 
    end
end