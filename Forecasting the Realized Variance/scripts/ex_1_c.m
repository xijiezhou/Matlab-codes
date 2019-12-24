% question A
% create function

% question B
[dates, prices] = load_stock('PG.csv');
[dates_return,deltax] = log_returns(dates, prices);
[n,T] = size(deltax);
rv = realized_var(deltax);
J = 1000;

AR1_E = ar_e(rv,J,T);
HAR1_E = har_e(rv,J,T);
NC_E = nc_e(rv,J,T);

ms_AR1_E = mean(AR1_E.^2);
ms_HAR1_E = mean(HAR1_E.^2);
ms_NC_E = mean(NC_E.^2);

% question C
J_1 = 250;
AR1_E_1 = ar_e(rv,J_1,T);
HAR1_E_1 = har_e(rv,J_1,T);
NC_E_1 = nc_e(rv,J_1,T);

ms_AR1_E_1 = mean(AR1_E_1.^2);
ms_HAR1_E_1 = mean(HAR1_E_1.^2);
ms_NC_E_1 = mean(NC_E_1.^2);

J_2 = 500;
AR1_E_2 = ar_e(rv,J_2,T);
HAR1_E_2 = har_e(rv,J_2,T);
NC_E_2 = nc_e(rv,J_2,T);

ms_AR1_E_2 = mean(AR1_E_2.^2);
ms_HAR1_E_2 = mean(HAR1_E_2.^2);
ms_NC_E_2 = mean(NC_E_2.^2);
% question D
