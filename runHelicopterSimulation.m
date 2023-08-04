function [t, y] = runHelicopterSimulation(collective, cyclic_pitch, cyclic_roll, tail_rotor, simulation_time)
    % Helicopter parameters
    parameters.mass = 1500; % kg
    parameters.Ixx = 500; % kg*m^2
    parameters.Iyy = 800; % kg*m^2
    parameters.Izz = 600; % kg*m^2
    parameters.gravity = 9.81; % m/s^2
    parameters.k_drag = 0.1; % Drag coefficient
    parameters.L_main_rotor = 500; % Main rotor lift coefficient
    parameters.L_tail_rotor = 100; % Tail rotor lift coefficient

    % Initial conditions
    initial_velocity = [0; 0; 0]; % Body frame velocity components (u, v, w)
    initial_orientation = [0; 0; 0]; % Euler angles (phi, theta, psi)
    initial_rotational_rate = [0; 0; 0]; % Body frame rotational rates (p, q, r)
    initial_conditions = [initial_velocity; initial_orientation; initial_rotational_rate];

    % Time span for simulation
    tspan = [0, simulation_time];

    % Options for ODE solver
    options = odeset('RelTol', 1e-6, 'AbsTol', 1e-6);

    % Run the simulation using ode45
    [t, y] = ode45(@(t, y) helicopter_ode(t, y, collective, cyclic_pitch, cyclic_roll, tail_rotor, parameters), tspan, initial_conditions, options);
end
