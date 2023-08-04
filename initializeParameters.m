function parameters = initializeParameters()
    % Physical parameters
    parameters.mass = 1500; % Total mass of the helicopter (kg)
    parameters.Ixx = 5000; % Inertia about X-body axis (kg*m^2)
    parameters.Iyy = 4000; % Inertia about Y-body axis (kg*m^2)
    parameters.Izz = 6000; % Inertia about Z-body axis (kg*m^2)
    parameters.Ixz = 100;  % Product of inertia Ixz (kg*m^2)
    parameters.gravity = 9.81; % Acceleration due to gravity (m/s^2)
    parameters.rho = 1.225; % Air density (kg/m^3)

    % Main rotor parameters
    parameters.S_main_rotor = 100; % Main rotor disc area (m^2)
    parameters.b_main_rotor = 4;   % Main rotor blade number
    parameters.c_main_rotor = 0.3; % Main rotor chord (m)
    parameters.L_main_rotor = 0.5; % Main rotor lift coefficient
    parameters.k_drag = 0.1;       % Main rotor drag factor

    % Tail rotor parameters
    parameters.S_tail_rotor = 10;  % Tail rotor disc area (m^2)
    parameters.b_tail_rotor = 4;   % Tail rotor blade number
    parameters.c_tail_rotor = 0.2; % Tail rotor chord (m)
    parameters.L_tail_rotor = 0.4; % Tail rotor lift coefficient

    % Aerodynamic moment coefficients
    parameters.M_flapping = 0.05;  % Flapping moment coefficient
    parameters.M_drag = 0.02;      % Drag moment coefficient
    parameters.M_gyro = 0.01;      % Gyroscopic moment coefficient

    % Linearized system dynamics for control
    parameters.A_lin = zeros(6); % Linearized A matrix for linear dynamics
    parameters.B_lin = zeros(6,4); % Linearized B matrix for linear dynamics
    parameters.A_ang = zeros(3); % Linearized A matrix for angular dynamics
    parameters.B_ang = zeros(3,4); % Linearized B matrix for angular dynamics

    % Additional parameters can be added based on the complexity of the
    % helicopter model, including engine parameters, transmission ratios,
    % damping coefficients, fuselage aerodynamics, ground effects, etc.
end
