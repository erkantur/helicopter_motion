function [F, M] = aerodynamics(y, collective, cyclic_pitch, cyclic_roll, tail_rotor, parameters)
    % Unpack state variables
    u = y(1); v = y(2); w = y(3);
    phi = y(4); theta = y(5); psi = y(6);
    p = y(7); q = y(8); r = y(9);

    % Aerodynamic parameters
    S_main_rotor = parameters.S_main_rotor; % Main rotor area
    S_tail_rotor = parameters.S_tail_rotor; % Tail rotor area
    b_main_rotor = parameters.b_main_rotor; % Main rotor blade number
    b_tail_rotor = parameters.b_tail_rotor; % Tail rotor blade number
    c_main_rotor = parameters.c_main_rotor; % Main rotor chord
    c_tail_rotor = parameters.c_tail_rotor; % Tail rotor chord
    rho = parameters.rho; % Air density

    % Main rotor aerodynamic forces
    F_main_rotor_lift = 0.5 * rho * S_main_rotor * collective * parameters.L_main_rotor;
    F_main_rotor_drag = 0.5 * rho * S_main_rotor * parameters.k_drag * (u^2 + v^2 + w^2);

    % Tail rotor aerodynamic forces
    F_tail_rotor_lift = 0.5 * rho * S_tail_rotor * tail_rotor * parameters.L_tail_rotor;
    F_tail_rotor_drag = 0.5 * rho * S_tail_rotor * parameters.k_drag * (u^2 + v^2 + w^2);

    % Total aerodynamic forces in body frame
    F = [F_main_rotor_lift - F_main_rotor_drag; 
         F_tail_rotor_lift - F_tail_rotor_drag; 
         0];
    
    % Aerodynamic moments (torques) calculation
    % Calculating flapping, drag, and gyroscopic effects of main and tail rotors
    M_flapping_main_rotor = [cyclic_roll; cyclic_pitch; 0] * parameters.M_flapping;
    M_drag_main_rotor = [-u; -v; -w] * parameters.M_drag;
    M_gyro_main_rotor = cross([p; q; r], [F_main_rotor_lift; 0; 0]) * parameters.M_gyro;

    M_flapping_tail_rotor = [cyclic_roll; cyclic_pitch; 0] * parameters.M_flapping * tail_rotor;
    M_drag_tail_rotor = [-u; -v; -w] * parameters.M_drag * tail_rotor;
    M_gyro_tail_rotor = cross([p; q; r], [0; 0; F_tail_rotor_lift]) * parameters.M_gyro * tail_rotor;

    % Total aerodynamic moments in body frame
    M = M_flapping_main_rotor + M_drag_main_rotor + M_gyro_main_rotor + ...
        M_flapping_tail_rotor + M_drag_tail_rotor + M_gyro_tail_rotor;

    % Apply transformation to rotate into the body frame
    R_body_from_world = eul2rotm([psi, theta, phi]);
    F = R_body_from_world * F;
    M = R_body_from_world * M;
end
