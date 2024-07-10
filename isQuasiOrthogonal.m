function isQO = isQuasiOrthogonal(A)
    isQO = true;
    n = size(A, 2);

    for i = 1:n-2
        for j = i + 2:n
            if ~isequaltol(A(:, i)'*A(:, j), 0)
                isQO = false;
                return
            end
        end
    end
end
