function class = classify(c, x)
  done = false;
  i = 1;
  while(~done && i < size(c,1))
    g=c(i,:);
    cls = applyDisc(g, x);
    if cls == 1 && g(4) == 0
      class = cls;
      done = true;
    elseif cls == 2 && g(5) == 0
      class = cls;
      done = true;
    end
    i = i + 1;
  end
end  
      