function dydt = helicopter_ode(t, y, collective, cyclic_pitch, cyclic_roll, tail_rotor, parameters)
    % Unpack state variables
    u = y(1); v = y(2); w = y(3); % Body frame velocity components
    phi = y(4); theta = y(5); psi = y(6); % Euler angles
    p = y(7); q = y(8); r = y(9); % Body frame rotational rates

    % Unpack helicopter parameters
    m = parameters.mass;
    Ixx = parameters.Ixx;
    Iyy = parameters.Iyy;
    Izz = parameters.Izz;
    g = parameters.gravity;
    k_drag = parameters.k_drag;
    L_main_rotor = parameters.L_main_rotor; % Main rotor lift coefficient
    L_tail_rotor = parameters.L_tail_rotor; % Tail rotor lift coefficient

    % Rotor dynamics
    rotor_thrust = collective * L_main_rotor;
    tail_rotor_thrust = tail_rotor * L_tail_rotor;
    
    % Aerodynamic forces
    D = -k_drag * [u; v; w]; % Drag force
    L = rotor_thrust * [0; 0; 1]; % Lift force
    
    % Forces in body frame
    F_body = D + L + m * g * [0; 0; -1]; 

    % Transform to Earth frame
    R_body_to_earth = eul2rotm([psi, theta, phi]);
    F_earth = R_body_to_earth' * F_body;

    % Linear acceleration
    a = F_earth/m;

    % Moment calculations
    M_roll = cyclic_roll * L_main_rotor; 
    M_pitch = cyclic_pitch * L_main_rotor;
    M_yaw = tail_rotor_thrust;

    % Total moments
    M = [M_roll; M_pitch; M_yaw];

    % Rotational accelerations
    pdot = (Iyy - Izz) / Ixx * q * r + M(1) / Ixx;
    qdot = (Izz - Ixx) / Iyy * p * r + M(2) / Iyy;
    rdot = (Ixx - Iyy) / Izz * p * q + M(3) / Izz;

    % Euler angle derivatives
    phi_dot = p + tan(theta)*(q*sin(phi) + r*cos(phi));
    theta_dot = q*cos(phi) - r*sin(phi);
    psi_dot = (q*sin(phi) + r*cos(phi))/cos(theta);

    % Pack the derivatives
    dydt = [a; phi_dot; theta_dot; psi_dot; pdot; qdot; rdot];
end
