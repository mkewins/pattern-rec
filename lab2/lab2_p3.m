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

% CURRENTLY NOT WORKING

% Setup grid for classification
xrange = [0, 500];
yrange = [0, 500];
inc = 5;
[x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2));
image_size = size(x);
xy = [x(:) y(:)];

% classify each point
classes = zeros(length(xy), 1);
for i=1:length(xy)
    classes(i) = classify(c1,xy(i,:));
end
dec_map = reshape(classes, image_size);
contour(x, y, dec_map, 'g');
%%
% 3. Iterate through different J values, find error rates

% Build 20 sequential classifiers for j1 through j5

% j1
j1 = zeros(1,5,20);
j1_error = [];

for i=1:20
    j1(:,:,i) = sequential(a,b,1);

    % I'm not sure whether grabbing this as the error number is correct...
    if(j1(1,4,i) == 0)
        j1_error = [j1_error j1(1,5,i)];
    else
        j1_error = [j1_error j1(1,4,i)];
    end
end

j1_error = j1_error/400; % turn to percent of the total number of data points


% j2
j2 = zeros(2,5,20);
j2_error = [];

for i=1:20
    j2(:,:,i) = sequential(a,b,2);

    if(j2(2,4,i) == 0)
        j2_error = [j2_error j2(2,5,i)];
    else
        j2_error = [j2_error j2(2,4,i)];
    end
end

j2_error = j2_error/400;

% j3
j3 = zeros(3,5,20);
j3_error = [];

for i=1:20
    j3(:,:,i) = sequential(a,b,3);

    if(j3(3,4,i) == 0)
        j3_error = [j3_error j3(3,5,i)];
    else
        j3_error = [j3_error j3(3,4,i)];
    end
end

j3_error = j3_error/400;

% j4
j4 = zeros(4,5,20);
j4_error = [];

for i=1:20
    j4(:,:,i) = sequential(a,b,4);

    if(j4(4,4,i) == 0)
        j4_error = [j4_error j4(4,5,i)];
    else
        j4_error = [j4_error j4(4,4,i)];
    end
end

j4_error = j4_error/400;

% j5
j5 = zeros(5,5,20);
j5_error = [];

for i=1:20
    j5(:,:,i) = sequential(a,b,5);

    if(j5(5,4,i) == 0)
        j5_error = [j5_error j5(5,5,i)];
    else
        j5_error = [j5_error j5(5,4,i)];
    end
end

j5_error = j5_error/400;

figure;
error_stats = [j1_error; j2_error; j3_error; j4_error; j5_error];
boxplot(error_stats');
