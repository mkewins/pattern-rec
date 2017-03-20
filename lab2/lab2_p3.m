%%
% Part 3
% http://ocho.uwaterloo.ca/Teaching/372/lab2_3.mat
clear all;
close all;
load('lab2_3.mat');

%%
% 1. Create 3 sequential classifiers.

c1 = sequential(a,b,200);
c2 = sequential(a,b,200);
c3 = sequential(a,b,200);

% For each classifier, plot the resulting classification boundary along
% with the data points.

x = 0:1:550;

% Plot C1
figure;
ylim([0 450])
xlim([0 550])
title('c1')
ylabel('y')
xlabel('x')
hold on;
ap = plot(a(:,1), a(:,2), 'r+');
bp = plot(b(:,1), b(:,2), 'b.');
plot_sequential_classifier(c1, x, 'g-');
legend('a', 'b', 'c1 sequential classifiers');

% Plot C2
figure;
ylim([0 450])
xlim([0 550])
ylabel('y')
xlabel('x')
title('c2')
hold on;
ap = plot(a(:,1), a(:,2), 'r+');
bp = plot(b(:,1), b(:,2), 'b.');
plot_sequential_classifier(c2, x, 'g-');
legend('a', 'b', 'c2 sequential classifiers');

% Plot C3
figure;
ylim([0 450])
xlim([0 550])
title('c3')
ylabel('y')
xlabel('x')
hold on;
ap = plot(a(:,1), a(:,2), 'r+');
bp = plot(b(:,1), b(:,2), 'b.');
plot_sequential_classifier(c3, x, 'g-');
legend('a', 'b', 'c3 sequential classifiers');

%%
% Classify sequentially

% Setup grid for classification
[x, y] = meshgrid(0:1:500, 0:1:500);
image_size = size(x);
xy = [x(:) y(:)];

% classify each point
classes = zeros(length(xy), 2);
for i=1:length(xy)
    %classes(i,:) = classify(c1,xy(i,:));
    %classes(i,:) = classify(c2,xy(i,:));
    classes(i,:) = classify(c3,xy(i,:));
end
dec_map = reshape(classes(:,1), image_size);
figure;
hold on;
contour(x, y, dec_map, 'g');
ap = plot(a(:,1), a(:,2), 'r.');
bp = plot(b(:,1), b(:,2), 'b.');
legend('decision boundary','a','b');
xlabel('x')
ylabel('y')
%title('c2')

%%
% 3. Iterate through different J values, find error rates

% Build 20 sequential classifiers for j1 through j5

% J=1
j1 = zeros(1,5,20);
j1_error = [];

% Build 20 sequential classifiers for J=1
for i=1:20
    j1(:,:,i) = sequential(a,b,1);
end

j1_error = getError(j1, 1, 400);

% J=2
j2 = zeros(2,5,20);
j2_error = [];

for i=1:20
    j2(:,:,i) = sequential(a,b,2);
end

j2_error = getError(j2, 2, 400);

% J=3
j3 = zeros(3,5,20);
j3_error = [];

for i=1:20
    j3(:,:,i) = sequential(a,b,3);
end

j3_error = getError(j3, 3, 400);

% J=4
j4 = zeros(4,5,20);
j4_error = [];

for i=1:20
    j4(:,:,i) = sequential(a,b,4);
end

j4_error = getError(j4, 4, 400);

% J=5
j5 = zeros(5,5,20);
j5_error = [];

for i=1:20
    j5(:,:,i) = sequential(a,b,5);
end

j5_error = getError(j5, 5, 400);

% J=6
j6 = zeros(6,5,20);
j6_error = [];

for i=1:20
    j6(:,:,i) = sequential(a,b,6);
end
j6_error = getError(j6, 6, 400);

% J=7
j7 = zeros(7,5,20);
j7_error = [];

for i=1:20
    j7(:,:,i) = sequential(a,b,7);
end
j7_error = getError(j7, 7, 400);

% J=8
j8 = zeros(8,5,20);
j8_error = [];

for i=1:20
    j8(:,:,i) = sequential(a,b,8);
end
j8_error = getError(j8, 8, 400);

% J=9
j9 = zeros(9,5,20);
j9_error = [];

for i=1:20
    j9(:,:,i) = sequential(a,b,9);
end
j9_error = getError(j9, 9, 400);

% J=10
j10 = zeros(10,5,20);
j10_error = [];

for i=1:20
    j10(:,:,i) = sequential(a,b,10);
end
j10_error = getError(j10, 10, 400);

%%
figure;
error = [j1_error;
         j2_error;
         j3_error;
         j4_error;
         j5_error;
         j6_error;
         j7_error;
         j8_error;
         j9_error;];
%          j10_error];

error_stats = [min(error(1,:)), max(error(1,:)), mean(error(1,:)), std(error(1,:));
               min(error(2,:)), max(error(2,:)), mean(error(2,:)), std(error(2,:));
               min(error(3,:)), max(error(3,:)), mean(error(3,:)), std(error(3,:));
               min(error(4,:)), max(error(4,:)), mean(error(4,:)), std(error(4,:));
               min(error(5,:)), max(error(5,:)), mean(error(5,:)), std(error(5,:));
               min(error(6,:)), max(error(6,:)), mean(error(6,:)), std(error(6,:));
               min(error(7,:)), max(error(7,:)), mean(error(7,:)), std(error(7,:));
               min(error(8,:)), max(error(8,:)), mean(error(8,:)), std(error(8,:));
               min(error(9,:)), max(error(9,:)), mean(error(9,:)), std(error(9,:));];
               %min(error(10,:)), max(error(10,:)), mean(error(10,:)), std(error(10,:));];
boxplot(error');
xlabel('J')
ylabel('Percent Error')

%%
figure;
hold on;
x_error = [1,2,3,4,5,6,7,8,9]
plot(x_error,error_stats(:,1)')
plot(x_error,error_stats(:,2)')
plot(x_error,error_stats(:,3)')
plot(x_error,error_stats(:,4)')
legend('min','max','mean','std')
xlabel('J')
ylabel('Percent Error')