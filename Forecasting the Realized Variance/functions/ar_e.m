function AR1_E = ar_e(rv,J,T)

rv1 = zeros(1,T-J-1);
AR1_E = zeros(1,T-J-1);
ar1beta = zeros(2, T-J-1);
    for i = 1: T-J-1
        xtrans = rv(i:i+J-1);
        x = xtrans.';
        y = rv(i+1: i+J) .';
        ar1beta(:, i) = ols_beta(1,x,y);
        beta0 = ar1beta(1,i);
        beta1 = ar1beta(2,i);
        rv1(i) = beta0 + beta1 * rv(i+J);
        AR1_E(i) = rv(i+J+1)- rv1(i); 
    end
end