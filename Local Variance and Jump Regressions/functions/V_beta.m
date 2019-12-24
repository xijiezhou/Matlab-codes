function V_beta_hat = V_beta(deltax_1,betaj_1,deltax_m,rd_m,n,T)
e_hat_1 = deltax_1 - betaj_1 .* deltax_m;
kn = 11;
ce_hat_1 = local_variance(e_hat_1,T,n,kn);
ce_hat_j_1 = ce_hat_1(rd_m ~= 0);
rd_j_m = rd_m(rd_m ~= 0);
V_beta_hat = sum((rd_j_m.^2).*ce_hat_j_1)/(sum(rd_j_m.^2))^2;
end