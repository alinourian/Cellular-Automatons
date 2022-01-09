function ConwaysGameOfLife(matrix,lastStep,delay)

    neighbor_filter = [1 1 1;1 0 1;1 1 1];
    step = 0;

    while(step <= lastStep)
        neighbor = conv2(matrix,neighbor_filter,'same');

        dead_cells = (neighbor < 2 | neighbor > 3);
        alived_cells = neighbor == 3;

        matrix(dead_cells) = 0;
        matrix(alived_cells) = 1;

        imagesc(matrix);
        colormap(parula);
        title(sprintf('step : %d / %d',step,lastStep),'Interpreter','latex');

        step = step + 1;
        pause(delay);
    end
end