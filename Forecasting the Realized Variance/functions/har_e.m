function  HAR1_E = har_e (RV, w, T)


xend = T-2-w+1;
harbeta = zeros(4, xend-21);
rvw = zeros(1, w);
rvm = zeros(1, w);
RV1 = zeros(1, xend-21);
HAR1_E = zeros(1, xend -21);

    for i = 1 : xend-22
        rv = RV(21+i : 21+i+w-1);
        for j = 1:w
        rvw(j) = mean(RV(21+i-5+j : 21+i+j-1));
        rvm(j) = mean(RV(i+j-1 : 21+i+j-1));
        end
        x = zeros(w, 3);
        x(:,1) = rv.';
        x(:,2) = rvw.';
        x(:,3) = rvm.';
        y = RV(21+i+1:21+i+w).';
       
        harbeta (:,i) = ols_beta(1,x,y);
        beta0 = harbeta(1, i);
        beta1 = harbeta(2, i);
        betaw = harbeta(3, i);
        betam = harbeta(4, i);

        rvwt = mean(RV(21+i-5+1: 21+i));
        rvmt = mean(RV(i: 21+i));
        RV1(i) = beta0 +beta1*RV(i+21+w) + betaw * rvwt + betam * rvmt;
        HAR1_E(i) = RV(i+w+1)-RV1(i);
    end
end