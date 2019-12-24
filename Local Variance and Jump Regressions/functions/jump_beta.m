function betaj = jump_beta(rd_m,deltax_1)
indicator = (rd_m ~=0);
rd_j_1 = deltax_1 .* indicator; 
betaj = sum(rd_j_1(:) .* rd_m(:))/sum(rd_m(:) .^2);
end