% *************************************************************************
%% ************************* question 4 ***********************************
% *************************************************************************
clear;
close all;
clc;
figure;
n = 50;
matrix = randi([1,3],n);
k=4;
lastStep = 500;
delay = 0.05;
getVote(matrix,k,lastStep,delay);
% *************************************************************************
% ******************************** q4 *************************************
% *************************************************************************
function getVote(matrix,k,lastStep,delay)
[m,n] = size(matrix);
help = matrix;
t = floor(m*n/k);
step = 0;
while(step <= lastStep)
    changes = randperm(m*n,t);
    for i=1:t
        row = mod(changes(i),m);
        if(row==0)
            row=m;
        end
        col = ceil(changes(i)./m);
        help(changes(i)) = getNeighborVote(matrix,row,col);
    end
    matrix = help;
    imagesc(matrix);
    colormap(parula);
    title(sprintf('step : %d / %d',step,lastStep));
    step = step + 1;
    pause(delay);
end
end

function vote = getNeighborVote(M,i,j)
[m,n] = size(M);
if(i==1)
    if(j==1)
        r = randi([1,3]);
        d = [M(1,2),M(2,1),M(2,2)];
        vote = d(r);
    elseif(j==n)
        r = randi([1,3]);
        d = [M(1,n-1),M(2,n),M(2,n-1)];
        vote = d(r);
    else
        r = randi([1,5]);
        d = [M(1,j-1),M(1,j+1),M(2,j),M(2,j-1),M(2,j+1)];
        vote = d(r);
    end
elseif(i==m)
    if(j==1)
        r = randi([1,3]);
        d = [M(m,2),M(m-1,1),M(m-1,2)];
        vote = d(r);
    elseif(j==n)
        r = randi([1,3]);
        d = [M(m,n-1),M(m-1,n),M(m-1,n-1)];
        vote = d(r);
    else
        r = randi([1,5]);
        d = [M(m,j-1),M(m,j+1),M(m-1,j),M(m-1,j-1),M(m-1,j+1)];
        vote = d(r);
    end
elseif(j==1)
    r = randi([1,5]);
    d = [M(i-1,1),M(i+1,1),M(i-1,2),M(i,2),M(i+1,2)];
    vote = d(r);
elseif(j==n)  
    r = randi([1,5]);
    d = [M(i-1,n),M(i+1,n),M(i-1,n-1),M(i,n-1),M(i+1,n-1)];
    vote = d(r);
else
    r = randi([1,8]);
    d = [M(i-1,j-1),M(i-1,j),M(i-1,j+1),M(i,j-1),M(i,j+1),M(i+1,j-1),M(i+1,j),M(i+1,j+1)];
    vote = d(r);
end
end