function prob = parzen(x, data, k, sigma)
    prob = zeros(length(x));
    h = k / (length(data)) ^ 0.5;
    for i=1:length(x)
        prob(i) = (1 / length(data)) * sum(1/h * normpdf( ((x(i) - data)/h), 0, sigma) );
    end
end