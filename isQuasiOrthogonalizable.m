function [quasi, order] = isQuasiOrthogonalizable(X)
    n = size(X, 2);
    order = zeros(n, 1);
    orderInd = 1;

    % BEGIN: OrthoGraphComplement
    adjList = zeros(n, 2);
    for j = 1:(n-1)
        %if any(not(ismembertol(X(:, j), 0)))
        for k = (j+1):n
            if not(isequaltol(X(:, j)'*X(:, k), 0))
                if adjList(j, 1) == 0
                    adjList(j, 1) = k;
                elseif adjList(j, 2) == 0
                    adjList(j, 2) = k;
                else
                    quasi = false;
                    return
                end

                if adjList(k, 1) == 0
                    adjList(k, 1) = j;
                elseif adjList(k, 2) == 0
                    adjList(k, 2) = j;
                else
                    quasi = false;
                    return
                end
            end
        end
        %end
    end
    % END: OrthoGraphComplement

    % BEGIN: isPathSubgraph
    % Determines whether the adjacency list A represents a subgraph of a path.
    path = true;
    row_sums = zeros(1, n);
    for i = 1:n
        for j = 1:2
            if adjList(i, j) ~= 0
                row_sums(i) = row_sums(i) + 1;
            end
        end
        if i < n && row_sums(i) == 0
            order(orderInd) = i;
            orderInd = orderInd + 1;
        end
    end
    if row_sums(n) == 0
        order(n) = n;
    end

    % row_sums > 2 already checked in orthograph complement section above
    if sum(row_sums <= 1) < 2
        path = false;
    else
        visited = zeros(1, n);
        for i = 1:n
            if row_sums(i) == 1 && visited(i) == false
                visited = travelPath(adjList, visited, i);
            end
        end
        for i = 1:n
            if visited(i) == 0 && row_sums(i) ~= 0
                path = false;
                break
            end
        end
    end

    % Iteratively visits and marks each node of A (if not
    % all nodes are marked, then A is not a path subgraph)
    function visited = travelPath(adjList, visited, j)
        n = size(adjList, 1);
        visited(j) = true;
        order(orderInd) = j;
        orderInd = orderInd + 1;
        ct = 1;
        while ct <= n
            for ind = 1:2
                if adjList(j, ind) ~= 0 && visited(adjList(j, ind)) == false
                    visited(adjList(j, ind)) = true;
                    j = adjList(j, ind);
                    order(orderInd) = j;
                    orderInd = orderInd + 1;
                    break
                end
            end
            ct = ct + 1;
        end
    end

    quasi = path;

    % END: isPathSubgraph
end