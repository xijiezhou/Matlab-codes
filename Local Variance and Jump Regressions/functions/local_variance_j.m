function [c_hat_minus,c_hat_plus,dates_j,rd_j] = local_variance_j(dates_return,rc,rd,n,T,kn)
num = sum(rd~=0,'all');
c_hat_minus = zeros(1,num);
c_hat_plus = zeros(1,num);
dates_j = zeros(1,num);
rd_j = zeros(1,num);
j = 0;
for i = 1: n*T
    rd_v = rd(:);
    
   if rd_v(i)~=0
       
       j=j+1;
       column = ceil(i/77);
       roll = i-(column-1)*77;
       dates_j(j) = dates_return(roll,column);
       rd_j(j) = rd(roll,column);
       rc_day = rc(:,column);
     
       num1 = roll-1;
       
       num2 = n - roll;
       
       j1 = min(kn,num1); 
       j2 = min(kn,num2);
       
       returns_minus = rc_day(roll-j1:roll-1);
       if j1 ~= 0
           c_hat_minus(j) = sum(returns_minus .^2)/(j1*(1/n));
       else
           c_hat_minus(j) = 0;
       end

       returns_plus = rc_day(roll+1:roll+j2);
       if j2 ~= 0
           c_hat_plus(j) = sum(returns_plus .^ 2)/(j2*(1/n));
       else
           c_hat_plus(j) = 0;
       end     
   end  
end