%%
% Part 1
% http://ocho.uwaterloo.ca/Teaching/372/lab2_1.mat

clear all;
close all;

% Step 1: Load dataset
load('lab2_1.mat');

%%
% Dataset A

% 1.1: Parametric Estimation ? Gaussian
mu = sum(a) / length(a);
sigma = sum( (a-mu) .^ 2 ) / length(a);

x = [0:.1:10];
figure;

% Plot estimated
norm_est = normpdf(x,mu,sigma);
plot(x,norm_est);
hold on;

% Plot true
norm_true = normpdf(x,5,1);
plot(x,norm_true);

legend('Estimated Dist.', 'True Dist.');

%%
% 1.2: Parametric Estimation ? Exponential
lambda = 1/mu;

figure;

% Plot estimated
dist_est = lambda * exp(-lambda * x);
plot(x,dist_est);
hold on;

% Plot true
plot(x,norm_true);

legend('Estimated Dist.', 'True Dist.');

%%
% 1.3: Parametric Estimation - Uniform

max_a = max(a);
min_a = min(a);
h = 1 / (max(a) - min(a));

u = ones(1,length(x));
over = x > max_a;
under = x < min_a;
u = h*(u - over - under);

figure;
% Plot estimated
plot(x,u);
hold on;

% Plot true
plot(x,norm_true);

legend('Estimated Dist.', 'True Dist.');

%%
% Dataset B

% 1.1: Parametric Estimation ? Gaussian
mu_b = sum(b) / length(b);
sigma_b = sum( (b-mu_b) .^ 2 ) / length(b);

x_b = [-2:0.05:10];
figure;
% Plot estimated
norm_est_b = normpdf(x_b, mu_b, sigma_b);
plot(x_b,norm_est_b);
hold on;

% Plot true
dist_true_b = double(x_b >= 0) .* exp(-x_b);
plot(x_b,dist_true_b);
legend('Estimated Dist.', 'True Dist.');

%%
% 1.2: Parametric Estimation - Exponential
lambda_b = 1/mu_b;

figure;
% Plot estimated
b_exp_est = lambda_b * exp(-lambda_b * x_b);
plot(x_b,b_exp_est);
hold on;
% Plot true
plot(x_b,dist_true_b);
legend('Estimated Dist.', 'True Dist.');

%%
% 1.3: Parametric Estimation - Uniform

max_b = max(b);
min_b = min(b);
h_b = 1 / (max(b) - min(b));

u_b = ones(1,length(x_b));
over_b = x_b > max_b;
under_b = x_b < min_b;
u_b = h_b*(u_b - over_b - under_b);

figure;
% Plot estimated
plot(x_b,u_b);
hold on;

% Plot true
plot(x_b, dist_true_b);

legend('Estimated Dist.', 'True Dist.');

%%
% Non-Parametric Estimation - Parzen Windows
% Dataset A
x_a = [0:.1:10];
sigma = 0.1;
k = 1; % first try
dist_par_a = parzen(x_a, a, k, sigma);
figure;
plot(x_a, dist_par_a);
hold on;
k = 10;
dist_par_a = parzen(x_a, a, k, sigma);
plot(x_a, dist_par_a);
hold on;
k = 100;
dist_par_a = parzen(x_a, a, k, sigma);
plot(x_a, dist_par_a);
hold on;
plot(x,norm_true);

%%
% Dataset B
sigma = 0.1;
k = 15; % first try
dist_par_b = parzen(x_b, b, k, sigma);
plot(x_b, dist_par_b);
hold on;
plot(x_b, dist_true_b);