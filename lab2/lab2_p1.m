%%
% Part 1
% http://ocho.uwaterloo.ca/Teaching/372/lab2_1.mat

clear all;
close all;

% Step 1: Load dataset
load('lab2_1.mat');

%%
% Dataset A
% 1.1: Parametric Estimation - Gaussian
mu = sum(a) / length(a);
sigma = sum( (a-mu) .^ 2 ) / length(a);

x = [0:.1:10];
figure;

% Plot estimated gaussian distribution
norm_est = normpdf(x,mu,sigma);
plot(x,norm_est);
hold on;

% Plot true distribution (gaussian)
norm_true = normpdf(x,5,1);
plot(x,norm_true);

legend('(A) Estd. Gaussian Dist.', '(A) True Dist.');
ylabel('p(x)')
xlabel('x')

%%
% Dataset A
% 1.2: Parametric Estimation - Exponential
lambda = 1/mu;

figure;

% Plot estimated exponential distribution
dist_est = lambda * exp(-lambda * x);
plot(x,dist_est);
hold on;

% Plot true distribution (gaussian)
plot(x,norm_true);

legend('(A) Estd. Exp. Dist.', '(A) True Dist.');
ylabel('p(x)')
xlabel('x')

%%
% Dataset A
% 1.3: Parametric Estimation - Uniform

% Distribution properties (a, b, 1/a-b)
max_a = max(a);
min_a = min(a);
h = 1 / (max(a) - min(a));

% Create the distribution
u = ones(1,length(x));
over = x > max_a;
under = x < min_a;
u = h*(u - over - under);

figure;
% Plot estimated uniform distribution
plot(x,u);
hold on;

% Plot true distribution (gaussian)
plot(x,norm_true);

legend('(A) Estd. Uniform Dist.', '(A) True Dist.');
ylabel('p(x)')
xlabel('x')

%%
% Dataset B
% 1.1: Parametric Estimation - Gaussian
mu_b = sum(b) / length(b);
sigma_b = sum( (b-mu_b) .^ 2 ) / length(b);

x_b = [-2:0.05:10];
figure;

% Plot estimated gaussian distribution
norm_est_b = normpdf(x_b, mu_b, sigma_b);
plot(x_b,norm_est_b);
hold on;

% Plot true distribution (exponential)
dist_true_b = double(x_b >= 0) .* exp(-x_b);
plot(x_b,dist_true_b);

legend('(B) Estd. Gaussian Dist.', '(B) True Dist.');
ylabel('p(x)')
xlabel('x')

%%
% Dataset B
% 1.2: Parametric Estimation - Exponential
lambda_b = 1/mu_b;

figure;
% Plot estimated exponential distribution
b_exp_est = double(x_b >= 0) .* (lambda_b * exp(-lambda_b * x_b));
plot(x_b,b_exp_est);
hold on;

% Plot true distribution (exponential)
plot(x_b,dist_true_b);
legend('(B) Estd. Exp. Dist.', '(B) True Dist.');
ylabel('p(x)')
xlabel('x')

%%
% Dataset B
% 1.3: Parametric Estimation - Uniform

% Distribution properties
max_b = max(b);
min_b = min(b);
h_b = 1 / (max(b) - min(b));

% Create the distribution
u_b = ones(1,length(x_b));
over_b = x_b > max_b;
under_b = x_b < min_b;
u_b = h_b*(u_b - over_b - under_b);

figure;
% Plot estimated uniform distribution
plot(x_b,u_b);
hold on;

% Plot true distribution (exponential)
plot(x_b, dist_true_b);

legend('(B) Estd. Uniform Dist.', '(B) True Dist.');
ylabel('p(x)')
xlabel('x')

%%
% Non-Parametric Estimation - Parzen Windows
% Dataset A
x_a = [0:.1:10];
sigma = 0.1;
%sigma = 0.4;

k = 1;
dist_par_a_1 = parzen(x_a, a, k, sigma);
figure;
hold on;
a1 = plot(x_a, dist_par_a_1);

k = 10;
dist_par_a_10 = parzen(x_a, a, k, sigma);
a2 = plot(x_a, dist_par_a_10);

k = 100;
dist_par_a_100 = parzen(x_a, a, k, sigma);
a3 = plot(x_a, dist_par_a_100);

norm_true = normpdf(x_a,5,1);
a4 = plot(x_a,norm_true);

legend([a1 a2 a3 a4], 'k=1', 'k=10', 'k=100', 'True Dist.');
ylabel('p(x)');
xlabel('x');

%%
% Non-Parametric Estimation - Parzen Windows
% Dataset B
sigma = 0.1;
%sigma = 0.4;
x_b = [-2:0.05:10];

k = 1;
dist_par_b = parzen(x_b, b, k, sigma);
figure;
hold on;
plot(x_b, dist_par_b);

k = 10;
dist_par_b = parzen(x_b, b, k, sigma);
plot(x_b, dist_par_b);

k = 100;
dist_par_b = parzen(x_b, b, k, sigma);
plot(x_b, dist_par_b);

plot(x_b, dist_true_b);

legend('k=1', 'k=10', 'k=100', 'True Dist.');
ylabel('p(x)')
xlabel('x')
