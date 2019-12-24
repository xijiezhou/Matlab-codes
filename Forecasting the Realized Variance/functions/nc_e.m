function NC_E = nc_e(rv,J,T)
NC_E = zeros(1,T-J-1);
for i = 2:T-J
    NC_E(i-1) = rv(i+J) - rv(i-1);
end
end