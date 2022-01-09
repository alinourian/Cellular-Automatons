clear; clc; close all;

width=100;
height=100;
n_max=16;
thresh = 1;
n_iteration=100;
step = 1;
map = randi(n_max+1,width,height) - 1;
help_map = map;
while(step <= n_iteration)
    help_map = map;
    for i=1:width
        for j=1:height
            neighbor = get_neighbor(map,[i,j]);
            counter = count_neighbor(map(i,j),neighbor,n_max);
            if counter >= thresh
                help_map(i,j) = mod(map(i,j)+1,n_max);
            end
        end
    end
    map = help_map;
    imagesc(map,[0 n_max]); %colorbar;
    colormap hsv;
    title(step);
    step = step + 1;
    pause(0.01);
end
%%
function neighbor = get_neighbor(map,index)
    z = zeros(size(map,1)+2,size(map,2)+2);
    z(2:end-1,2:end-1) = map;
    neighbor = z(index(1):index(1)+2,index(2):index(2)+2);
%     neighbor(1) = 0;
%     neighbor(3) = 0;
%     neighbor(7) = 0;
%     neighbor(9) = 0;
end

function counter = count_neighbor(value,neighbor,n_max)
    counter = sum(neighbor == mod(value+1,n_max),'all');
end
