function HelicopterGUI
    % Create figure
    f = figure('Visible','off','Position',[360,500,450,325]);

    % Create sliders for control inputs
    collectiveSlider = uicontrol('Style', 'slider', 'Min', 0, 'Max', 1, 'Value', 0.5, 'Position', [100, 250, 200, 20]);
    uicontrol('Style', 'text', 'Position', [100, 270, 200, 20], 'String', 'Collective Control');

    cyclicPitchSlider = uicontrol('Style', 'slider', 'Min', -1, 'Max', 1, 'Value', 0, 'Position', [100, 200, 200, 20]);
    uicontrol('Style', 'text', 'Position', [100, 220, 200, 20], 'String', 'Cyclic Pitch Control');

    cyclicRollSlider = uicontrol('Style', 'slider', 'Min', -1, 'Max', 1, 'Value', 0, 'Position', [100, 150, 200, 20]);
    uicontrol('Style', 'text', 'Position', [100, 170, 200, 20], 'String', 'Cyclic Roll Control');

    % Create start simulation button
    startButton = uicontrol('Style', 'pushbutton', 'String', 'Start Simulation', 'Position', [100, 50, 100, 20], 'Callback', @startSimulation);

    % Move the GUI to the center of the screen.
    movegui(f,'center')

    % Make the GUI visible.
    f.Visible = 'on';

    % Callback function for start simulation button
    function startSimulation(~, ~)
        collective = collectiveSlider.Value;
        cyclic_pitch = cyclicPitchSlider.Value;
        cyclic_roll = cyclicRollSlider.Value;
        
        % Run the simulation with the control inputs from the sliders
        [t, y] = runHelicopterSimulation(collective, cyclic_pitch, cyclic_roll);
        
        % Plot the results
        figure
        subplot(3, 1, 1);
        plot(t, y(:,4) * 180/pi);
        xlabel('Time (s)');
        ylabel('Roll Angle (degrees)');
        title('Roll Angle vs. Time');

        subplot(3, 1, 2);
        plot(t, y(:,5) * 180/pi);
        xlabel('Time (s)');
        ylabel('Pitch Angle (degrees)');
        title('Pitch Angle vs. Time');

        subplot(3, 1, 3);
        plot(t, y(:,6) * 180/pi);
        xlabel('Time (s)');
        ylabel('Yaw Angle (degrees)');
        title('Yaw Angle vs. Time');
    end
end
