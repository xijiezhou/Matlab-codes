[dates, prices] = load_stock2('BAC-2015.csv');
Jmax = 120;
dates_day = dates(:,1);
prices_day = prices(:,1);
J = 1:1:Jmax;

RV = zeros(Jmax,1);
for i = 1:Jmax
    subprices_day = prices_day(1:i:end);
    deltax = diff(subprices_day);
    RV(i) = sqrt(sum(deltax.*deltax)*252)*100;
end

f = figure(11);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(J/12,RV)
title('volatility signature');
box off; grid on;
xlabel('minutes');
ylabel('RV');
ytickformat('%g %%');
print(f,'-dpng','-r200','figures/3C');
close(f);

T =252;
RVt = zeros(Jmax,T);
RV_J = zeros(120,1);

for i = 1:Jmax
   subpricest = prices(1:i:end,:);
   deltax = diff(subpricest);
   RVt = sqrt(sum(deltax.*deltax)*252)*100;
   RV_J(i) = (1/T)*sum(RVt,2);
end


f = figure(12);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(J/12,RV_J)
title('less noisy volatility signature');
box off; grid on;
xlabel('minutes');
ylabel('RV_J');
ytickformat('%g %%');
print(f,'-dpng','-r200','figures/3D');
close(f);




