%% section 1
clear; clc; close all;

figure;
rules = [18 22 30 50 54 60 69 70 73 77 94 99 105,...
    109 110 126 150 158 190 248];
% rules = 22;
for i=1:length(rules)
    subplot(5,4,i);
    ruleset = bitget(rules(i),1:8);
    pattern = automaton(ruleset,[20,41]);
    imagesc(~pattern); colormap gray;
    title(['rule ',num2str(rules(i))],'Interpreter','latex');
    axis off;
    pause(0.00001);
end
%% section 2
clear; clc; close all;

figure;
pause(1);
rule = 126;
automaton_gif(rule,1000,[150,250],0.005);


%% functions
function automaton_gif(rule,last,dimension,delay)
    ruleset = bitget(rule,1:8);
    M = zeros(dimension(1),dimension(2));
    M(end,floor(dimension(2)/2)+1) = 1;
    % M2 = zeros(size(M,1)+2,size(M,2)+2);

    step = 1;
    while(step < last)
        next_gen = generate(M(end,:),ruleset);
        M(1:end-1,:) = M(2:end,:);
        M(end,:) = next_gen;
        imagesc(M); colormap parula;
        title(['rule ',num2str(rule)],'Interpreter','latex');
        axis off;
        pause(delay);
        step = step + 1;
    end
end

function pattern = automaton(ruleset,dimension)
    M = zeros(dimension(1),dimension(2));
    M(1,floor(dimension(2)/2)+1) = 1;
    % M2 = zeros(size(M,1)+2,size(M,2)+2);

    step = 1;
    while(step < size(M,1))
          next_gen = generate(M(step,:),ruleset);
          M(step+1,:) = next_gen;
%         imagesc(M);
%         pause(0.001);
        step = step + 1;
    end
    pattern = M;
end

function next_gen = generate(row,ruleset)
    zrow = [row(1) row row(end)];
    next_gen = row;
    for i=2:length(row)+1
        item = do_rule(zrow(i-1:i+1),ruleset);
        next_gen(i-1) = item;
    end
end

function item = do_rule(v,ruleset)
    if sum(v == [0 0 0]) == 3
        item = ruleset(1);
    elseif sum(v == [0 0 1]) == 3
        item = ruleset(2);
    elseif sum(v == [0 1 0]) == 3
        item = ruleset(3);
    elseif sum(v == [0 1 1]) == 3
        item = ruleset(4);
    elseif sum(v == [1 0 0]) == 3
        item = ruleset(5);
    elseif sum(v == [1 0 1]) == 3
        item = ruleset(6);
    elseif sum(v == [1 1 0]) == 3
        item = ruleset(7);
    elseif sum(v == [1 1 1]) == 3
        item = ruleset(8);
    else
        item = 0;
    end
end
