addpath(genpath('isequaltol.m'))
addpath(genpath('npermutek'))

WeakHadamardMatrices_3 = getWeakHadamards(3);
save('WeakHadamardMatrices_3to5.mat', 'WeakHadamardMatrices_3')

WeakHadamardMatrices_4 = getWeakHadamards(4);
save('WeakHadamardMatrices_3to5.mat', 'WeakHadamardMatrices_4', '-append')

WeakHadamardMatrices_5 = getWeakHadamards(5);
save('WeakHadamardMatrices_3to5.mat', 'WeakHadamardMatrices_5', '-append')