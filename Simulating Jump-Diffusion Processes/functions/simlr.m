function deltax = simlr(x,nE,T)
deltax = zeros(nE*T+1,1);
for j = 1:nE*T
    deltax(j) = x(j+1)-x(j);
end