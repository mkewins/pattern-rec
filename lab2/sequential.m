function classifier = sequential(a, b, J)
    classifier = [];
    iter = 1;
    while(~(isempty(a) || isempty(b)) && size(classifier,1) < J) 
        G_good = false;
        while(~G_good)
            % select random points from a and b
            rand_a = randi([1,size(a, 1)], 1);
            rand_b = randi([1,size(b, 1)], 1);
            a_r = a(rand_a, :);
            b_r = b(rand_b, :);
            % MED classifier for points
            c1 = b_r(1) - a_r(1);
            c2 = b_r(2) - a_r(2);
            c3 = (a_r(1)^2 + a_r(2)^2 - b_r(1)^2 - b_r(2)^2)/2;
            G = [c1 c2 c3 0 0];
            % check classifier against points
            class_a = zeros(1, size(a, 1));
            for i=1:size(a, 1)
                class_a(i) = applyDisc(G, a(i, :));
            end
            a_wrong = sum(class_a == 2);
            class_b = zeros(1, size(b, 1));
            for i=1:size(b, 1)
                class_b(i) = applyDisc(G, b(i, :));
            end
            b_wrong = sum(class_b == 1);
            G(4) = a_wrong;
            G(5) = b_wrong;
            G_good = (a_wrong == 0 || b_wrong == 0);
        end

        % plot the classifier and points
%         figure;
%         xlim([0 550])
%         ylim([0 450])
%         title(iter)
%         iter = iter + 1;
%         hold on;
%         plot(a(:,1), a(:,2), 'r.');
%         plot(b(:,1), b(:,2), 'b.');
%         plot(a_r(1), a_r(2), 'r*');
%         plot(b_r(1), b_r(2), 'b*');
%         x = 0:1:550;
%         y = (-G(1)*x -G(3)) / G(2);
%         plot(x,y, 'g-');

        classifier = [classifier; G];

        % remove correctly classified points
        if b_wrong == 0
            a = a(class_a == 2, :);
        else
            b = b(class_b == 1, :);
        end
    end
end
        