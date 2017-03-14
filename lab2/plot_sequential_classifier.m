function plot_sequential_classifier(classifier, x, lineparams)
    for i=1:size(classifier,1) % loop through the sequential classifiers
        y = (-classifier(i,1)*x - classifier(i,3)) / classifier(i, 2);
        plot(x,y, lineparams);
    end
end