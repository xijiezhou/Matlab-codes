function c = simsv(c0,rho,muc,deltaE,sigmac,nE,T)
c = [c0;zeros(nE*T,1)];
z = normrnd(0,1,nE*T,1);
for j = 1:nE*T 
    c(j+1) = c(j) + rho*(muc-c(j))*deltaE+z(j)*sigmac*sqrt(c(j)*deltaE);
end

for j = 1:nE*T
   if c(j) < muc/2
      c(j) = muc/2;
   end
end