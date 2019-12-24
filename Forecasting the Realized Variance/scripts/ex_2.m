% question A
N = 100;
sigma_x2 = 25.2;
sigma_u2 = 0.5;
beta = 1;
seed = 100;
rng(seed);
x_hat = normrnd(0, sqrt(sigma_x2), 1, N);
u_hat = normrnd(0, sqrt(sigma_u2), 1, N);
y_hat = x_hat.*beta + u_hat;
% y_hat = y_h(N,sigma_x2,sigma_u2,beta);

% question B
beta_hat = ols_beta (0,x_hat.',y_hat.');

% question C
rep = 1000;
beta_hat_sim = zeros(1,rep);
for i = 1:rep
    seed = i;
    rng(seed)
    x_hat = normrnd(0, sqrt(sigma_x2), 1, N);
    u_hat = normrnd(0, sqrt(sigma_u2), 1, N);
    y_hat = x_hat .* beta + u_hat;

    beta_hat_sim(:,i) = ols_beta (0,x_hat.',y_hat.');
end

% question D
f = figure;
set(f,'units','normalized','outerposition',[0 0 1 1]);
[fb1,xi1] = ksdensity(beta_hat_sim,'kernel','epanechnikov','Bandwidth',0.005);
plot(xi1, fb1);
title('the density of the beta estimates');
box off; grid on;
xlabel('beta');
ylabel('density');
print(f,'-dpng','-r200','figures/2D');
close(f);

% question E
sigma_eta2 = 0.3*sigma_x2;
eta = normrnd(0, sqrt(sigma_eta2), 1, N);
x_hat_star = x_hat + eta;

beta_hat_star = ols_beta(0,x_hat_star.' , y_hat.' );
beta_hat_star_sim = zeros(1,rep);

for i = 1:rep
    seed = i;
    rng(seed)
    x_hat = normrnd(0, sqrt(sigma_x2), 1, N);
    u_hat = normrnd(0, sqrt(sigma_u2), 1, N);
    eta = normrnd(0, sqrt(sigma_eta2), 1, N);
    x_hat_star = x_hat + eta;
    
    y_hat = x_hat .* beta + u_hat;

    beta_hat_star_sim(:,i) = ols_beta (0,x_hat_star.',y_hat.');
end

f = figure;
set(f,'units','normalized','outerposition',[0 0 1 1]);
[fb2,xi2] = ksdensity(beta_hat_star_sim,'kernel','epanechnikov','Bandwidth',0.05);
plot(xi2, fb2);
title('the density of the beta estimates with noise');
box off; grid on;
xlabel('beta');
ylabel('density');
print(f,'-dpng','-r200','figures/2E');
close(f);

% question F
sigma_eta2 = 0.5*sigma_x2;
eta = normrnd(0, sqrt(sigma_eta2), 1, N);
x_hat_star = x_hat + eta;

beta_hat_star = ols_beta(0,x_hat_star.' , y_hat.' );
beta_hat_star_sim = zeros(1,rep);

for i = 1:rep
    seed = i;
    rng(seed)
    x_hat = normrnd(0, sqrt(sigma_x2), 1, N);
    u_hat = normrnd(0, sqrt(sigma_u2), 1, N);
    eta = normrnd(0, sqrt(sigma_eta2), 1, N);
    x_hat_star = x_hat + eta;
    
    y_hat = x_hat .* beta + u_hat;

    beta_hat_star_sim(:,i) = ols_beta (0,x_hat_star.',y_hat.');
end

f = figure;
set(f,'units','normalized','outerposition',[0 0 1 1]);
[fb2,xi2] = ksdensity(beta_hat_star_sim,'kernel','epanechnikov','Bandwidth',0.05);
plot(xi2, fb2);
title('the density of the beta estimates with noise');
box off; grid on;
xlabel('beta');
ylabel('density');
print(f,'-dpng','-r200','figures/2F');
close(f);

