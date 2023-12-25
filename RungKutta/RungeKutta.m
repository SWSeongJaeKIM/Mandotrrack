clc;
clear all;
close all;

totalTime = 25;
timeStep = 0.01;
t = 0:timeStep:totalTime;
m = 80.0;
b = 50.0;
g = 9.81;

v = zeros(size(t));
k1 = zeros(size(t));
k2 = zeros(size(t));
k3 = zeros(size(t));
k4 = zeros(size(t));

initialVelocity = 20;
v(1) = initialVelocity;

for i = 1:numel(t)-1
    k1(i) = 0.01 * (g - b/m * v(i)^2);
    k2(i) = 0.01 * (g - b/m * (v(i) + k1(i)/2)^2);
    k3(i) = 0.01 * (g - b/m * (v(i) + k2(i)/2)^2);
    k4(i) = 0.01 * (g - b/m * (v(i) + k3(i))^2);
    
    v(i+1) = v(i) + (1/6) * (k1(i) + 2*k2(i) + 2*k3(i) + k4(i));
end

fprintf("t         v        k1      k2      k3      k4 \n");
for i = 1:numel(t)-1
    fprintf("%3.4f  %3.4f %3.4f %3.4f %3.4f %3.4f \n", t(i), v(i), k1(i), k2(i), k3(i), k4(i));
end

plot(t, v);
title('Runge Kutta v(m/s)');
xlabel('t');
ylabel('V', 'Rotation', 0);
