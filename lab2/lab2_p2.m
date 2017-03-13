%%
% Part 2
% http://ocho.uwaterloo.ca/Teaching/372/lab2_2.mat

close all;
clear all;

load('lab2_2.mat');

%%
% Parametric estimation
% Setup grid for classification
xrange = [0, 500];
yrange = [0, 500];
inc = 5;
[x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2));
image_size = size(x);
xy = [x(:) y(:)];

% Get model estimates for classes
mu_a = mean(al);
sigma_a = cov(al);

mu_b = mean(bl);
sigma_b = cov(bl);

mu_c = mean(cl);
sigma_c = cov(cl);

% classify grid
classes = zeros(length(xy), 1);
for i=1:length(xy)
    classes(i) = maxLikelihood(xy(i,:), [mu_a; mu_b; mu_c], [sigma_a; sigma_b; sigma_c]);
end
dec_map = reshape(classes, image_size);
contour(x, y, dec_map, 'g');

% plot data
hold on;
plot(al(:,1), al(:,2), 'ro')
plot(bl(:,1), bl(:,2), 'b+')
plot(cl(:,1), cl(:,2), 'g.')

%%
% Non-parametric estimation

gaussWindow1D = normpdf(-60:1:60,0,20);
gaussWindow2D = gaussWindow1D' * gaussWindow1D;

[p_a, x_a, y_a] = parzen2(al, [1 0 0 500 500], gaussWindow2D);
[p_b, x_b, y_b] = parzen2(bl, [1 0 0 500 500], gaussWindow2D);
[p_c, x_c, y_c] = parzen2(cl, [1 0 0 500 500], gaussWindow2D);

decMapPzn = maxPDF(x_a, x_b, p_a, p_b, p_c);
figure;
contour(x_a, y_a, decMapPzn, 'g');
hold on;
plot(al(:,1), al(:,2), 'ro')
plot(bl(:,1), bl(:,2), 'b+')
plot(cl(:,1), cl(:,2), 'g.')
