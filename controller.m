function [collective, cyclic_pitch, cyclic_roll, tail_rotor] = controller(t, y, y_ref, parameters)
    % Unpack state variables
    u = y(1); v = y(2); w = y(3);
    phi = y(4); theta = y(5); psi = y(6);
    p = y(7); q = y(8); r = y(9);

    % Unpack reference variables
    u_ref = y_ref(1); v_ref = y_ref(2); w_ref = y_ref(3);
    phi_ref = y_ref(4); theta_ref = y_ref(5); psi_ref = y_ref(6);

    % LQR controller for attitude control
    Q = diag([10, 10, 10, 1, 1, 1, 1, 1, 1]); % State cost matrix
    R = diag([1, 1, 1, 1]); % Control input cost matrix

    A = [parameters.A_lin, zeros(6,3); zeros(3,6), parameters.A_ang];
    B = [parameters.B_lin; parameters.B_ang];
    K = lqr(A, B, Q, R);

    x = [u - u_ref; v - v_ref; w - w_ref; phi - phi_ref; theta - theta_ref; psi - psi_ref; p; q; r];
    u_LQR = -K * x;

    collective = u_LQR(1);
    cyclic_pitch = u_LQR(2);
    cyclic_roll = u_LQR(3);
    tail_rotor = u_LQR(4);

    % PID controller for position control
    Kp = diag([5, 5, 5]); % Proportional gain
    Ki = diag([1, 1, 1]); % Integral gain
    Kd = diag([2, 2, 2]); % Derivative gain

    e_pos = y(1:3) - y_ref(1:3); % Position error
    e_int = integral(@(t) y(1:3) - y_ref(1:3), 0, t); % Integral of position error
    e_der = diff(y(1:3)); % Derivative of position error

    u_PID = Kp * e_pos + Ki * e_int + Kd * e_der;

    collective = collective + u_PID(3);
    cyclic_pitch = cyclic_pitch + u_PID(2);
    cyclic_roll = cyclic_roll + u_PID(1);

    % Apply constraints to the control inputs
    collective = max(0, min(1, collective));
    cyclic_pitch = max(-1, min(1, cyclic_pitch));
    cyclic_roll = max(-1, min(1, cyclic_roll));
    tail_rotor = max(0, min(1, tail_rotor));
end
