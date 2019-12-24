[dates, prices] = load_stock('JNJ.csv');
[dates_return,deltax] = log_returns(dates, prices);
[n,T] = size(deltax);
deltan =1/n;
rv = realized_var(deltax);
J = 1000;

AR1_E = ar_e(rv,J,T);
HAR1_E = har_e(rv,J,T);
NC_E = nc_e(rv,J,T);

ms_AR1_E = mean(AR1_E.^2);
ms_HAR1_E = mean(HAR1_E.^2);
ms_NC_E = mean(NC_E.^2);

tau = tau_f(deltax);
BV = bipower_var(deltax);
alpha = 5;
cutoff = alpha*deltan^0.49*sqrt(tau*BV);
rc = deltax;
rc(abs(deltax)>cutoff)=0;

QIV = 1/(3*deltan)*sum((rc).^4);

ARQ1_E = arq_e(rv,QIV,J,T);
HARQ1_E = harq_e(rv,QIV,J,T);

ms_ARQ1_E = mean(ARQ1_E.^2);
ms_HARQ1_E = mean(HARQ1_E.^2);