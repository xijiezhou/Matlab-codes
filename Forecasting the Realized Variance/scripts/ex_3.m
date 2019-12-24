% question A
[dates, prices] = load_stock('DIS.csv');
[dates_return,deltax] = log_returns(dates, prices);
[n,T] = size(deltax);
deltan = 1/n;
rv = realized_var(deltax);

tau = tau_f(deltax);
BV = bipower_var(deltax);
alpha = 5;
cutoff = alpha*deltan^0.49*sqrt(tau*BV);
rc = deltax;
rc(abs(deltax)>cutoff)=0;

QIV = 1/(3*deltan)*sum((rc).^4);

J = 1000;

ARQ1_E = arq_e(rv,QIV,J,T);
HARQ1_E = harq_e(rv,QIV,J,T);

ms_ARQ1_E = mean(ARQ1_E.^2);
ms_HARQ1_E = mean(HARQ1_E.^2);

% question B
J_1 = 250;
ARQ1_E_1 = arq_e(rv,QIV,J_1,T);
HARQ1_E_1 = harq_e(rv,QIV,J_1,T);

ms_ARQ1_E_1 = mean(ARQ1_E_1.^2);
ms_HARQ1_E_1 = mean(HARQ1_E_1.^2);

J_2 = 500;
ARQ1_E_2 = arq_e(rv,QIV,J_2,T);
HARQ1_E_2 = harq_e(rv,QIV,J_2,T);

ms_ARQ1_E_2 = mean(ARQ1_E_2.^2);
ms_HARQ1_E_2 = mean(HARQ1_E_2.^2);




