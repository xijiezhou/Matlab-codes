function RV = realized_var(deltax)

[n,T] = size(deltax);
RV_first = zeros(n,T);

for t = 1:T
    for i = 1:n
    RV_first(i,t) = abs(deltax(i,t)).*abs(deltax(i,t));
    end
end

RV = sum(RV_first);%Sum the entire matrix by column
end
    