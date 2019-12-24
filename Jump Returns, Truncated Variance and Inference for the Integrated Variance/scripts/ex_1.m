[dates, prices] = load_stock('DIS.csv');

% question A
[dates_return,deltax] = log_returns(dates, prices);
[n,T] = size(deltax);
deltan = 1/n;
% b_f = sum(abs(deltax(2:end,:).*deltax(1:n-1,:)),2)/T;
% b1 = b_f(1:1);
% b = [b1;b_f];
% tau = n*b/sum(b);
tau = tau_f(deltax);

f = figure(1);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_return(:,1),tau)
datetick('x','HHMM');
title('the time-of-day factor of DIS');
box off; grid on;
xlabel('time');
ylabel('tau');
print(f,'-dpng','-r200','figures/1A1');
close(f);

% question C
BV = bipower_var(deltax);
alpha = 4;
cutoff = alpha*deltan^0.49*sqrt(tau*BV);
rc = deltax;
rc(abs(deltax)>cutoff)=0;
rd = deltax;
rd(abs(deltax)<=cutoff)=0;

f = figure(2);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_return(:),100*rc(:))
datetick('x','yyyy');
title('diffusive returns of DIS');
box off; grid on;
xlabel('time/year');
ylabel('rc%');
print(f,'-dpng','-r200','figures/1C11');
close(f);

f = figure(3);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(dates_return(:),100*rd(:))
datetick('x','yyyy');
title('jump returns of DIS');
box off; grid on;
xlabel('time/year');
ylabel('rd%');
print(f,'-dpng','-r200','figures/1C12');
close(f);

% question D
jumps = sum(rd~=0);
y = zeros(12,1);
[yyyy,mm,dd]= ymd_f('DIS.csv');
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

f = figure(4);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(xi_1,density_1)
title('the density of the diffusive returns of DIS');
box off; grid on;
xlabel('xi');
ylabel('density');
print(f,'-dpng','-r200','figures/1G11');
close(f);

[density_2,xi_2] = ksdensity(100.*rd(:),'Kernel','epanechnikov','bandwidth',0.01);

f = figure(5);
set(f,'units','normalized','outerposition',[0 0 1 1]);
plot(xi_2,density_2)
title('the density of the jump returns of DIS');
box off; grid on;
xlabel('xi');
ylabel('density');
print(f,'-dpng','-r200','figures/1G12');
close(f);








