function plotResults(t, y)
    % Unpack state variables
    u = y(:, 1); v = y(:, 2); w = y(:, 3);
    phi = y(:, 4); theta = y(:, 5); psi = y(:, 6);
    p = y(:, 7); q = y(:, 8); r = y(:, 9);

    % Create a figure for velocity
    figure;
    subplot(3,1,1);
    plot(t, u, 'b');
    xlabel('Time (s)');
    ylabel('u (m/s)');
    title('Body Frame Longitudinal Velocity (u)');
    grid on;
    
    subplot(3,1,2);
    plot(t, v, 'r');
    xlabel('Time (s)');
    ylabel('v (m/s)');
    title('Body Frame Lateral Velocity (v)');
    grid on;
    
    subplot(3,1,3);
    plot(t, w, 'g');
    xlabel('Time (s)');
    ylabel('w (m/s)');
    title('Body Frame Vertical Velocity (w)');
    grid on;

    % Create a figure for orientation
    figure;
    subplot(3,1,1);
    plot(t, rad2deg(phi), 'b');
    xlabel('Time (s)');
    ylabel('Roll angle (degrees)');
    title('Roll Angle');
    grid on;

    subplot(3,1,2);
    plot(t, rad2deg(theta), 'r');
    xlabel('Time (s)');
    ylabel('Pitch angle (degrees)');
    title('Pitch Angle');
    grid on;

    subplot(3,1,3);
    plot(t, rad2deg(psi), 'g');
    xlabel('Time (s)');
    ylabel('Yaw angle (degrees)');
    title('Yaw Angle');
    grid on;

    % Create a figure for rotational rates
    figure;
    subplot(3,1,1);
    plot(t, rad2deg(p), 'b');
    xlabel('Time (s)');
    ylabel('Roll rate (degrees/s)');
    title('Roll Rate');
    grid on;

    subplot(3,1,2);
    plot(t, rad2deg(q), 'r');
    xlabel('Time (s)');
    ylabel('Pitch rate (degrees/s)');
    title('Pitch Rate');
    grid on;

    subplot(3,1,3);
    plot(t, rad2deg(r), 'g');
    xlabel('Time (s)');
    ylabel('Yaw rate (degrees/s)');
    title('Yaw Rate');
    grid on;

    % Other custom plots can be added here as required

end
