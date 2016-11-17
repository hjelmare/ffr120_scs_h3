clc
clf
clear all

gridSize = 10;
fullGridSize = gridSize + 2;    % Extra for periodic boundaries
treeProb = 0.6;

grid = zeros(fullGridSize);

for i = 1:fullGridSize^2
    if rand() < treeProb
        grid(i) = 1;
    end
end

grid(1,:) = grid(end-1,:);
grid(end,:) = grid(2,:);
grid(:,1) = grid(:,end-1);
grid(:,end) = grid(:,2);

nbhMask = [ 0 1 0 ; 1 0 1 ; 0 1 0];
boundaryMask = zeros(fullGridSize);
boundaryMask(1,:) = 1;
boundaryMask(end,:) = 1;
boundaryMask(:,1) = 1;
boundaryMask(:,end) = 1;

xStart = ceil(rand()*gridSize) + 1;
yStart = ceil(rand()*gridSize) + 1;
grid(xStart, yStart) = 2;

[xFire, yFire] = find(grid == 2);
tic
burning = true;
while burning
    image(25*grid)
    pause(0.5)

    for i = 1:length(xFire)
        neighborhood = grid(xFire(i)-1:xFire(i)+1, yFire(i)-1:yFire(i)+1);
        
        neighborhood((neighborhood == 1) & nbhMask) = 2;
        neighborhood(2,2) = 3;
        
        grid(xFire-1:xFire+1, yFire-1:yFire+1) = neighborhood;
        image(25*grid)
    end

    grid(1,:) = grid(end-1,:);
    image(25*grid)
    grid(end,:) = grid(2,:);
    image(25*grid)
    grid(:,1) = grid(:,end-1);
    image(25*grid)
    grid(:,end) = grid(:,2);
    image(25*grid)
    
    grid(grid==2 & boundaryMask) = 0;
    image(25*grid)
    [xFire, yFire] = find(grid == 2);

    if isempty(xFire)
        burning = false;
    end
end
toc
image(25*grid)


disp('Done!')
