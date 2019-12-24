[dates, prices] = load_stock('PG.csv');

% question A
[dates_return,deltax] = log_returns(dates, prices);
[n,T] = size(deltax);
deltan = 1/n;
tau = tau_f(deltax);

f = figure(6);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_return(:,1),tau)
datetick('x','HHMM');
title('the time-of-day factor of PG');
box off; grid on;
xlabel('time');
ylabel('tau');
print(f,'-dpng','-r200','figures/1A2');
close(f);

% question C
BV = bipower_var(deltax);
alpha = 4;
cutoff = alpha*deltan^0.49*sqrt(tau*BV);
rc = deltax;
rc(abs(deltax)>cutoff)=0;
rd = deltax;
rd(abs(deltax)<=cutoff)=0;

f = figure(7);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_return(:),100*rc(:))
datetick('x','yyyy');
title('diffusive returns of PG');
box off; grid on;
xlabel('time/year');
ylabel('rc%');
print(f,'-dpng','-r200','figures/1C21');
close(f);

f = figure(8);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_return(:),100*rd(:))
datetick('x','yyyy');
title('jump returns of PG');
box off; grid on;
xlabel('time/year');
ylabel('rd%');
print(f,'-dpng','-r200','figures/1C22');
close(f);

% question D
jumps = sum(rd~=0);
y = zeros(12,1);
[yyyy,mm,dd]= ymd_f('PG.csv');
for i = 1:11
    y(i+1) = sum(ismember(yyyy,2006+i));
end
jumps_y = zeros(11,1);
for i = 1:11
    jumps_y(i) = sum(jumps(1,(sum(y(1:i))+1):sum(y(1:i+1))));
end
% xlswrite('DIS.csv',rd);

 % question G
[density_1,xi_1] = ksdensity(100.*rc(:),'Kernel','epanechnikov','bandwidth',0.01);

f = figure(9);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(xi_1,density_1)
title('the density of the diffusive returns of PG');
box off; grid on;
xlabel('xi');
ylabel('density');
print(f,'-dpng','-r200','figures/1G21');
close(f);

[density_2,xi_2] = ksdensity(100.*rd(:),'Kernel','epanechnikov','bandwidth',0.01);

f = figure(10);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(xi_2,density_2)
title('the density of the jump returns of PG');
box off; grid on;
xlabel('xi');
ylabel('density');
print(f,'-dpng','-r200','figures/1G22');
close(f);