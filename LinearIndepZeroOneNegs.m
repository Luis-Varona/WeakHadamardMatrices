function [Perms, numPerms] = LinearIndepZeroOneNegs(n)
    % LINEARINDEPZEROONENEGS  Generate the largest possible pairwise independent set of {-1, 0, 1} vectors in R^n.
    %   Perms = LinearIndepZeroOneNegs(n) returns a matrix of size n x numPerms, where numPerms = (3^n - 1)/2.
    %   [Perms, numPerms] = LinearIndepZeroOneNegs(n) also returns the number of vectors in the set.
    
        % Create an array 'w' with entries from {-1, 0, 1}.
        w = [-1 0 1];
        % Store in 'numPerms' the number of possible number of possible k-permutations with repetition of w
        % such that the first nonzero entry is 1 and the zero vector is not included.
        numPerms = (3^n - 1)/2;
        % Initialize 'Perms' as a matrix of size n x numPerms.
        Perms = zeros(n, numPerms);
    
        % For each k from 1 to n, generate all k-permutations with repetition of 'w' with the first nonzero
        % nonzero entry (1) in the n - k + 1-th position, and assign each vector to be a column of 'Perms'.
        colStart = 1;
        for k = 1:n
            numPerms_k = 3^(k - 1);
            rowStart = n - k + 1; colEnd = colStart + numPerms_k - 1;
            Perms(rowStart, colStart:colEnd) = ones(1, numPerms_k);
            Perms_k = transpose(npermutek(w, k-1));
            Perms(rowStart+1:end, colStart:colEnd) = Perms_k;
            colStart = colEnd + 1;
        end
    end