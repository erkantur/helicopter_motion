% Constants and Parameters
g = 9.81; % Gravitational acceleration (m/s^2)
m = 1000; % Helicopter mass (kg)
Ixx = 800; % Moment of inertia around roll axis (kg*m^2)
Iyy = 1000; % Moment of inertia around pitch axis (kg*m^2)
Izz = 1200; % Moment of inertia around yaw axis (kg*m^2)
k_drag = 0.1; % Drag constant (proportional to velocity)

% Control inputs (constant for this example, usually would come from a control system)
collective = 0.5; % Collective control (0 to 1, controls overall thrust)
cyclic_pitch = 0; % Cyclic pitch control (controls pitch angle)
cyclic_roll = 0; % Cyclic roll control (controls roll angle)
tail_rotor = 0; % Tail rotor control (controls yaw angle)

% Initial Conditions
u0 = 0; % Initial forward velocity (m/s)
v0 = 0; % Initial lateral velocity (m/s)
w0 = 0; % Initial vertical velocity (m/s)
phi0 = 0; % Initial roll angle (rad)
theta0 = 0; % Initial pitch angle (rad)
psi0 = 0; % Initial yaw angle (rad)
p0 = 0; % Initial roll rate (rad/s)
q0 = 0; % Initial pitch rate (rad/s)
r0 = 0; % Initial yaw rate (rad/s)
initial_conditions = [u0, v0, w0, phi0, theta0, psi0, p0, q0, r0];

% Time span (30 seconds)
t_span = [0, 30];

% Solve the differential equation using ODE45
options = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);
[t, y] = ode45(@(t,y) helicopter_ode(t, y, collective, cyclic_pitch, cyclic_roll
