function HelicopterGUI()
    % Create main UI figure
    fig = uifigure('Name', 'Helicopter Simulation', 'Position', [100, 100, 800, 600]);

    % Create panel for control inputs
    controlPanel = uipanel(fig, 'Title', 'Control Inputs', 'Position', [10, 410, 300, 180]);
    
    % Create sliders for control inputs
    createLabeledSlider(controlPanel, 'Collective', [20, 140, 260, 3], 0, 1);
    createLabeledSlider(controlPanel, 'Cyclic Pitch', [20, 100, 260, 3], -1, 1);
    createLabeledSlider(controlPanel, 'Cyclic Roll', [20, 60, 260, 3], -1, 1);
    createLabeledSlider(controlPanel, 'Tail Rotor', [20, 20, 260, 3], 0, 1);
    
    % Create buttons to start and stop the simulation
    startButton = uibutton(controlPanel, 'Position', [20, 10, 80, 30], 'Text', 'Start', ...
        'ButtonPushedFcn', @(btn,event) startSimulation());
    stopButton = uibutton(controlPanel, 'Position', [120, 10, 80, 30], 'Text', 'Stop', ...
        'ButtonPushedFcn', @(btn,event) stopSimulation());

    % Create axes for plotting the helicopter's trajectory
    ax = axes(fig, 'Position', [.4 .1 .5 .8]);
    xlabel(ax, 'X (m)');
    ylabel(ax, 'Y (m)');
    zlabel(ax, 'Z (m)');
    title(ax, 'Helicopter Trajectory');
    grid(ax, 'on');
    hold(ax, 'on');

    % Function to create a labeled slider
    function createLabeledSlider(parent, label, position, min, max)
        uilabel('Parent', parent, 'Text', label, 'Position', [position(1), position(2) + 20, position(3), 20]);
        uislider('Parent', parent, 'Position', position, 'Limits', [min, max]);
    end

    % Function to start the simulation
    function startSimulation()
        % Retrieve the current control input values from sliders
        collective = findobj(controlPanel, 'Tag', 'Collective');
        cyclic_pitch = findobj(controlPanel, 'Tag', 'Cyclic Pitch');
        cyclic_roll = findobj(controlPanel, 'Tag', 'Cyclic Roll');
        tail_rotor = findobj(controlPanel, 'Tag', 'Tail Rotor');
        control_inputs = [collective.Value, cyclic_pitch.Value, cyclic_roll.Value, tail_rotor.Value];
        
        % Initialize the simulation parameters
        parameters = initializeParameters();

        % Run the helicopter simulation with the given control inputs and parameters
        [time, state] = runHelicopterSimulation(control_inputs, parameters);

        % Plot the results
        plotResults(ax, time, state);
    end

    % Function to stop the simulation
    function stopSimulation()
        % TODO: Implementation to stop the simulation
    end
end
