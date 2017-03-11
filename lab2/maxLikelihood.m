function class = maxLikelihood(point, ptypes, covar)
    class = 0;
    store = -inf;
    [m,~] = size(ptypes);
    point = point';
    ap = zeros(m,1);
    for i = 1:m
        S1 = covar(i*2-1:i*2,:);
        S1_I = inv(S1);
        mean1 = ptypes(i,:)';
        ap(i) = -(point-mean1)' * S1_I * (point - mean1) + - log(det(S1));
    end
    range = 1:m;
    class = range(ap == max(ap));
    class = class(1);
    end