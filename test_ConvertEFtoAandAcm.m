
clc
clear all
close all


set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
set(groot,'defaulttextInterpreter','latex');




area_cm2 = 0.02;  % Example area in cm² (adjust as per measurement setup)
R = 50;  % Resistivity in Ohm-cm


% Example electric field magnitudes in V/cm (change these values as per actual measurements)
electric_field_magnitudes_V_cm = [-4, -2, -1, -0.5, 0, 0.5, 1, 2, 4];  % Example electric field magnitudes in V/cm

% Convert electric field magnitudes to current in µA
currents_microA = electric_field_to_current(electric_field_magnitudes_V_cm, area_cm2,R);

% Calculate current density in A/cm²
current_density_A_cm2 = current_to_density(currents_microA, area_cm2);

% Plotting
figure;

% Plot current in mA
subplot(1, 2, 1);
plot(electric_field_magnitudes_V_cm, currents_microA*(10^-3), 'bo-', 'LineWidth', 2);
xlabel('Electric Field Magnitude (V/cm)');
ylabel('Current (mA)');
title('Electric Field Magnitude vs. Current');
xticklabels(strrep(xticklabels,'-','$-$'))
yticklabels(strrep(yticklabels,'-','$-$'))
grid on;

% Plot current density in A/cm²
subplot(1, 2, 2);
plot(electric_field_magnitudes_V_cm, current_density_A_cm2, 'ro-', 'LineWidth', 2);
xlabel('Electric Field Magnitude (V/cm)');
ylabel('Current Density (A/cm$^2$)');
title('Electric Field Magnitude vs. Current Density');
xticklabels(strrep(xticklabels,'-','$-$'))
yticklabels(strrep(yticklabels,'-','$-$'))
grid on;
sgtitle('Current and Current Density vs. Electric Field Magnitude');




% Function to convert measured current (mA) to electric field magnitude (V/cm)
function electric_field = current_to_electric_field(current_mA, area_cm2,R)
    % Convert area from cm² to m²
    area_m2 = area_cm2 * (1e-2)^2;  % Convert cm² to m²

    % Calculate current density in A/m²
    current_density = current_mA / area_m2;  % Current density in A/m²

    % Assume a constant conductivity or resistivity
    % R = 50;  % Resistivity in Ohm-cm
    conductivity = 1 / (R * (1e-2));  % Conductivity in Siemens per meter (Ohm-cm to Ohm-m conversion)

    % Calculate electric field magnitude in V/cm
    electric_field = current_density / conductivity * 1e-2;  % Convert to V/cm
end

% Function to convert electric field magnitude (V/cm) to current (µA)
function current_microA = electric_field_to_current(electric_field_V_cm, area_cm2,R)
    % Convert area from cm² to m²
    area_m2 = area_cm2 * (1e-2)^2;  % Convert cm² to m²

    % Convert electric field magnitude from V/cm to V/m
    electric_field_V_m = electric_field_V_cm * 1e2;  % Convert V/cm to V/m

    % Assume a constant conductivity or resistivity (adjust as per your case)
    % R = 50;  % Resistivity in Ohm-cm
    conductivity = 1 / (R * (1e-2));  % Conductivity in Siemens per meter (Ohm-cm to Ohm-m conversion)

    % Calculate current density in A/m²
    current_density = conductivity * electric_field_V_m;

    % Calculate current in µA
    current_microA = current_density * area_m2 * 1e6;  % Convert A/m² to µA
end

% Function to calculate current density in A/cm²
function current_density_A_cm2 = current_to_density(current_mA, area_cm2)
    % Convert area from cm² to m²
    area_m2 = area_cm2 * (1e-2)^2;  % Convert cm² to m²

    % Calculate current density in A/m²
    current_density = current_mA / area_m2;  % Current density in A/m²

    % Convert current density to A/cm²
    current_density_A_cm2 = current_density * 1e-4;  % Convert from A/m² to A/cm²
end
