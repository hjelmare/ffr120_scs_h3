close all
clc
clf
clear all

gridSize = 1000;
treeProb = 0.6;

grid = zeros(gridSize);

for i = 1:gridSize^2
    if rand() < treeProb
        grid(i) = 1;
    end
end

xStart = ceil(rand()*gridSize);
yStart = ceil(rand()*gridSize);
grid(xStart,yStart) = 2;

fire = find(grid == 2);
tic
burning = true;
while burning
%     image(25*grid)
%     pause(0.5)

    for i = 1:length(fire)
        xFire = mod(fire(i)-1,gridSize)+1;
        yFire = mod(floor((fire(i)-1)/gridSize),gridSize)+1;
        if grid(mod(xFire-1 + 1,gridSize)+1,yFire) == 1
            grid(mod(xFire-1 + 1,gridSize)+1,yFire) = 2;
        end
        if grid(mod(xFire-1 - 1,gridSize)+1,yFire) == 1
            grid(mod(xFire-1 - 1,gridSize)+1,yFire) = 2;
        end
        if grid(xFire,mod(yFire-1 + 1,gridSize)+1) == 1
            grid(xFire,mod(yFire-1 + 1,gridSize)+1) = 2;
        end
        if grid(xFire,mod(yFire-1 - 1, gridSize)+1) == 1
            grid(xFire,mod(yFire-1 - 1, gridSize)+1) = 2;
        end
        
        grid(xFire,yFire) = 3;
    end
        
    fire = find(grid == 2);

    if isempty(fire)
        burning = false;
    end
end
toc
image(25*grid)


disp('Done!')
