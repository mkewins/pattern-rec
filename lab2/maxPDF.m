function decision_map = maxPDF(x, y, pdf1, pdf2, pdf3)
    decision_map = zeros(length(x), length(y));
    for i=1:length(x)
        for j=1:length(y)
            vals = [0, pdf1(i,j), pdf2(i,j), pdf3(i,j)];
            classes = [1,2,3,4];
            class = classes(vals == max(vals));
            decision_map(i, j) = class(1);
        end
    end
end