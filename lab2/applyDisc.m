function class = applyDisc(G, x)
    x = [x, 1, 0, 0];
    disc = G * x';
    if disc >= 0
        class = 2;
    else
        class = 1;
    end
end
    