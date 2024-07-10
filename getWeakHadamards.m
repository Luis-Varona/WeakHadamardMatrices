function WeakHadamards = getWeakHadamards(n)
    [vecs, ct] = LinearIndepZeroOneNegs(n);
    idxsAll = 1:ct;
    idxsStartOptions = nchoosek(idxsAll, 2);
    numStart = (3^n - 3)*(3^n - 1)/16;
    sizeStart = 2;

    while sizeStart <= n - 2
        idxsNew = []; numNew = 0;
        for j = 1:numStart
            idxsStart = idxsStartOptions(j, :);
            last = idxsStart(end);
            for idxNext = last+1:ct
                idxsCombo = [idxsStart, idxNext];
                if isQuasiOrthogonalizable(vecs(:, idxsCombo))
                    idxsNew = [idxsNew; idxsCombo];
                    numNew = numNew + 1;
                end
            end
        end
        idxsStartOptions = idxsNew;
        numStart = numNew;
        sizeStart = sizeStart + 1;
    end

    idxsFinalOptions = []; numFinal = 0;
    for j = 1:numStart
        idxsStart = idxsStartOptions(j, :);
        last = idxsStart(end);
        for idxNext = last+1:ct
            idxsCombo = [idxsStart, idxNext];
            [quasi, order] = isQuasiOrthogonalizable(vecs(:, idxsCombo));
            if quasi
                idxsFinalOptions = [idxsFinalOptions; idxsCombo(order)];
                numFinal = numFinal + 1;
            end
        end
    end

    WeakHadamards = zeros(n, n, numFinal);
    for k = 1:numFinal
        WeakHadamards(:, :, k) = vecs(:, idxsFinalOptions(k, :));
    end
end