function BV = bipower_var(deltax)
[n,T] = size(deltax);
BV_first = zeros(n,T);

for t = 1:T
    for i = 2:n
    BV_first(i,t) = abs(deltax(i,t)).*abs(deltax(i-1,t));
    end
end

BV = (pi/2)*sum(BV_first);%Sum the entire matrix by column
end
    