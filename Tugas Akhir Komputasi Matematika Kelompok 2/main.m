clc;
clear all;
close all;

fprintf('=== HONEY PRODUCTION PSO OPTIMIZATION ===\n');
fprintf('Using manual parameters (no Excel file required)\n\n');

average_price = 15.50;        % Average price per lb ($)
max_demand_kg = 100000;       % Maximum demand (kg)
max_storage_kg = 80000;       % Maximum storage (kg)
pounds_per_kg = 2.20462;      % Conversion factor

max_demand_lb = max_demand_kg * pounds_per_kg;
max_storage_lb = max_storage_kg * pounds_per_kg;

fprintf('Parameters:\n');
fprintf('  Average price: $%.2f per lb\n', average_price);
fprintf('  Max demand: %d kg (%.0f lbs)\n', max_demand_kg, max_demand_lb);
fprintf('  Max storage: %d kg (%.0f lbs)\n', max_storage_kg, max_storage_lb);

swarm_size = 30;              % Jumlah partikel (Pop_Size)
maxIter = 100;                % Jumlah iterasi (MaxT)
inertia = 0.8;                % Inertia weight (w)
c1 = 1.2;                     % Cognitive parameter
c2 = 1.2;                     % Social parameter

colonies_min = 1000;    colonies_max = 50000;
yield_min = 10;         yield_max = 100;

fprintf('\nPSO Parameters:\n');
fprintf('  Swarm size: %d\n', swarm_size);
fprintf('  Max iterations: %d\n', maxIter);
fprintf('  Colonies range: %d - %d\n', colonies_min, colonies_max);
fprintf('  Yield range: %d - %d lbs per colony\n', yield_min, yield_max);

nx = 100; ny = 100;
[X, Y] = meshgrid(linspace(colonies_min, colonies_max, nx), ...
                  linspace(yield_min, yield_max, ny));
Z = zeros(size(X));

for i = 1:size(X, 1)
    for j = 1:size(X, 2)
        colonies = X(i, j);
        yield_per_colony = Y(i, j);
        production = colonies * yield_per_colony;
        profit = production * average_price;
        
        penalty = 0;
        if production > max_demand_lb
            penalty = penalty + 1e6;
        end
        if production > max_storage_lb
            penalty = penalty + 1e6;
        end
        
        Z(i, j) = -profit + penalty; 
    end
end


Z = Z / max(Z(:));
position = zeros(swarm_size, 2);
velocity = zeros(swarm_size, 2);
personal_best_pos = zeros(swarm_size, 2);
personal_best_fit = inf(swarm_size, 1);  

for i = 1:swarm_size
    position(i, 1) = colonies_min + rand * (colonies_max - colonies_min);
    position(i, 2) = yield_min + rand * (yield_max - yield_min);
end

personal_best_pos = position;
global_best_pos = position(1, :);
global_best_fit = inf;  


fig1 = figure('Position', [50, 50, 1600, 1200], 'Name', 'PSO Honey Production - 3D Surface Visualization');
views = [30, 45; 60, 30; 45, 60; 20, 70];
view_titles = {'View 1 - Standard', 'View 2 - Side Angle', 'View 3 - Top Angle', 'View 4 - High Angle'};

for v = 1:4
    subplot(2, 2, v);
    

    surf(X, Y, Z, 'FaceAlpha', 0.8, 'EdgeAlpha', 0.1);
    hold on;
    
    colormap(jet);

    xlabel('Colonies', 'FontSize', 10);
    ylabel('Yield per Colony (lbs)', 'FontSize', 10);
    zlabel('Normalized Profit', 'FontSize', 10);
    title(view_titles{v}, 'FontSize', 12);

    view(views(v, 1), views(v, 2));

    grid on;
    lighting gouraud;
    shading interp;

    light('Position', [1, 1, 1]);

    xlim([colonies_min, colonies_max]);
    ylim([yield_min, yield_max]);
    zlim([min(Z(:)), max(Z(:))]);

    set(gca, 'FontSize', 9);
end

annotation('textbox', [0 0.95 1 0.05], 'String', 'PSO Honey Production Optimization - 3D Surface Analysis', ...
           'EdgeColor', 'none', 'HorizontalAlignment', 'center', ...
           'FontSize', 14, 'FontWeight', 'bold');

fprintf('\nStarting optimization...\n');
tic;

trajectory_x = [];
trajectory_y = [];
trajectory_z = [];

for iter = 1:maxIter

    for i = 1:swarm_size
        colonies = position(i, 1);
        yield_per_colony = position(i, 2);

        production = colonies * yield_per_colony;
        profit = production * average_price;

        penalty = 0;
        if production > max_demand_lb
            penalty = penalty + 1e6;
        end
        if production > max_storage_lb
            penalty = penalty + 1e6;
        end
        
        fitness = -profit + penalty; 

        if fitness < personal_best_fit(i)
            personal_best_fit(i) = fitness;
            personal_best_pos(i, :) = position(i, :);
        end

        if fitness < global_best_fit
            global_best_fit = fitness;
            global_best_pos = position(i, :);
        end
    end
    
    trajectory_x = [trajectory_x, global_best_pos(1)];
    trajectory_y = [trajectory_y, global_best_pos(2)];
    trajectory_z = [trajectory_z, global_best_fit / max(Z(:))];  % Normalize for display

    for i = 1:swarm_size
        r1 = rand(1, 2);
        r2 = rand(1, 2);

        velocity(i, :) = inertia * velocity(i, :) + ...
                         c1 * r1 .* (personal_best_pos(i, :) - position(i, :)) + ...
                         c2 * r2 .* (global_best_pos - position(i, :));
        
        position(i, :) = position(i, :) + velocity(i, :);
        
        position(i, 1) = max(min(position(i, 1), colonies_max), colonies_min);
        position(i, 2) = max(min(position(i, 2), yield_max), yield_min);
    end

    if mod(iter, 10) == 0 || iter == maxIter
        figure(fig1);

        for v = 1:4
            subplot(2, 2, v);

            children = get(gca, 'Children');
            for c = 1:length(children)
                if strcmp(get(children(c), 'Type'), 'scatter')
                    delete(children(c));
                end
                if strcmp(get(children(c), 'Type'), 'line') && ~strcmp(get(children(c), 'Tag'), 'surface')
                    delete(children(c));
                end
            end

            current_z = zeros(swarm_size, 1);
            for i = 1:swarm_size
                colonies = position(i, 1);
                yield_per_colony = position(i, 2);
                production = colonies * yield_per_colony;
                profit = production * average_price;
                penalty = 0;
                if production > max_demand_lb
                    penalty = penalty + 1e6;
                end
                if production > max_storage_lb
                    penalty = penalty + 1e6;
                end
                current_z(i) = (-profit + penalty) / max(Z(:));
            end

            scatter3(position(:, 1), position(:, 2), current_z, 40, 'r', 'filled', 'MarkerEdgeColor', 'k');

            global_best_z = global_best_fit / max(Z(:));
            scatter3(global_best_pos(1), global_best_pos(2), global_best_z, 100, 'g', 'filled', 'MarkerEdgeColor', 'k');

            if length(trajectory_x) > 1
                plot3(trajectory_x, trajectory_y, trajectory_z, 'w-', 'LineWidth', 2);
            end

            title([view_titles{v}, sprintf(' - Iter: %d', iter)], 'FontSize', 12);
        end
        
        drawnow;
    end

    if mod(iter, 10) == 0
        current_profit = -global_best_fit;
        fprintf('Iteration %d: Best profit = $%.2f\n', iter, current_profit);
    end
end

elapsed_time = toc;

fig2 = figure('Position', [100, 100, 1400, 900], 'Name', 'PSO Final Results - 3D Surface');

subplot(2, 2, [1, 2]);
surf(X, Y, Z, 'FaceAlpha', 0.7, 'EdgeAlpha', 0.1);
hold on;

final_z = zeros(swarm_size, 1);
for i = 1:swarm_size
    colonies = position(i, 1);
    yield_per_colony = position(i, 2);
    production = colonies * yield_per_colony;
    profit = production * average_price;
    penalty = 0;
    if production > max_demand_lb
        penalty = penalty + 1e6;
    end
    if production > max_storage_lb
        penalty = penalty + 1e6;
    end
    final_z(i) = (-profit + penalty) / max(Z(:));
end

scatter3(position(:, 1), position(:, 2), final_z, 50, 'b', 'filled', 'MarkerEdgeColor', 'k');
scatter3(global_best_pos(1), global_best_pos(2), global_best_fit / max(Z(:)), 150, 'r', 'filled', 'MarkerEdgeColor', 'k');
plot3(trajectory_x, trajectory_y, trajectory_z, 'w-', 'LineWidth', 3);

xlabel('Colonies');
ylabel('Yield per Colony (lbs)');
zlabel('Normalized Profit');
title('PSO Final Results - 3D Surface with Optimization Trajectory');
colormap(jet);
colorbar;
grid on;
view(45, 30);

subplot(2, 2, 3);
convergence_data = -trajectory_z * max(Z(:));  % Convert back to profit
plot(1:length(convergence_data), convergence_data, 'b-', 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Fitness');
title('Convergence History');
grid on;

subplot(2, 2, 4);
contour(X, Y, Z, 20);
hold on;
scatter(position(:, 1), position(:, 2), 30, 'b', 'filled');
scatter(global_best_pos(1), global_best_pos(2), 100, 'r', 'filled');
plot(trajectory_x, trajectory_y, 'w-', 'LineWidth', 2);
xlabel('Colonies');
ylabel('Yield per Colony (lbs)');
title('2D Contour with Optimization Path');
colormap(jet);
colorbar;
grid on;

best_colonies = global_best_pos(1);
best_yield = global_best_pos(2);
total_production = best_colonies * best_yield;
total_profit = -global_best_fit;

fprintf('\n=== OPTIMIZATION COMPLETED ===\n');
fprintf('Time elapsed: %.2f seconds\n', elapsed_time);
fprintf('\n=== OPTIMAL SOLUTION ===\n');
fprintf('Best number of colonies: %.0f\n', best_colonies);
fprintf('Best yield per colony: %.2f lbs\n', best_yield);
fprintf('Total production: %.0f lbs (%.0f kg)\n', total_production, total_production/pounds_per_kg);
fprintf('Total profit: $%.2f\n', total_profit);

fprintf('\n=== CONSTRAINT CHECK ===\n');
fprintf('Demand utilization: %.1f%%\n', (total_production/max_demand_lb)*100);
fprintf('Storage utilization: %.1f%%\n', (total_production/max_storage_lb)*100);

if total_production > max_demand_lb
    fprintf('??  WARNING: Production exceeds demand limit!\n');
end
if total_production > max_storage_lb
    fprintf('??  WARNING: Production exceeds storage limit!\n');
end

fprintf('\n? Optimization completed successfully!\n');