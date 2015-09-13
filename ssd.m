function value = ssd( X, Y )
    value = sum(sum((X-Y).^2));
end

