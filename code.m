clc;
clear;
close all;

% Load the image
img = imread('tiger.jpg');
img_gray = rgb2gray(img);  % Convert to grayscale if necessary

% Define constants
h = 6.626e-34;   % Planck’s constant (J·s)
c = 3e8;         % Speed of light (m/s)

% Assuming you are working with visible light, define a sample wavelength range (in meters)
lambda_min = 400e-9;  % 400 nm (violet)
lambda_max = 700e-9;  % 700 nm (red)

% Normalize the pixel intensities to get a corresponding wavelength for each pixel
img_double = im2double(img_gray);  % Convert image to double for computation
lambda = lambda_min + (lambda_max - lambda_min) * (1 - img_double);  % Map pixel values to wavelength

% Calculate the photon energy for each pixel
E = (h * c) ./ lambda;  % Energy in Joules

% 1. Display the energy image
figure;
imshow(E, []);
title('Photon Energy of Image Pixels (in Joules)');

% 2. Heatmap visualization of photon energy
figure;
imagesc(E);
colorbar;
title('Heatmap of Photon Energy Distribution');
xlabel('X Pixels');
ylabel('Y Pixels');

% 3. Histogram of photon energy values
figure;
histogram(E(:), 100);  % Flatten the matrix and plot a histogram with 100 bins
title('Photon Energy Distribution');
xlabel('Photon Energy (Joules)');
ylabel('Frequency');

% 4. 3D Surface plot of photon energy
[X, Y] = meshgrid(1:size(E, 2), 1:size(E, 1));  % Create meshgrid for X and Y coordinates
figure;
surf(X, Y, E, 'EdgeColor', 'none');  % Surface plot without edges for smoother visualization
colorbar;
title('3D Surface Plot of Photon Energy');
xlabel('X Pixels');
ylabel('Y Pixels');
zlabel('Photon Energy (Joules)');
view(3);  % Set the view to 3D

%% Additional Analysis

% 5. Statistical analysis of photon energy
mean_energy = mean(E(:));
median_energy = median(E(:));
std_energy = std(E(:));
min_energy = min(E(:));
max_energy = max(E(:));
range_energy = [min_energy, max_energy];

fprintf('Statistical Analysis of Photon Energy:\n');
fprintf('Mean Energy: %e Joules\n', mean_energy);
fprintf('Median Energy: %e Joules\n', median_energy);
fprintf('Standard Deviation: %e Joules\n', std_energy);
fprintf('Min Energy: %e Joules\n', min_energy);
fprintf('Max Energy: %e Joules\n', max_energy);
fprintf('Energy Range: [%e, %e] Joules\n', min_energy, max_energy);

% 6. Energy distribution across rows and columns
sum_energy_rows = sum(E, 2);  % Sum of energy across rows
sum_energy_cols = sum(E, 1);  % Sum of energy across columns

% Plot row-wise energy distribution
figure;
plot(sum_energy_rows);
title('Row-wise Photon Energy Distribution');
xlabel('Row Index');
ylabel('Total Photon Energy (Joules)');

% Plot column-wise energy distribution
figure;
plot(sum_energy_cols);
title('Column-wise Photon Energy Distribution');
xlabel('Column Index');
ylabel('Total Photon Energy (Joules)');

% 7. Contour plot of photon energy
figure;
contour(X, Y, E, 20);  % Contour plot with 20 contour levels
colorbar;
title('Contour Plot of Photon Energy');
xlabel('X Pixels');
ylabel('Y Pixels');

% 8. Cumulative Distribution Function (CDF)
figure;
cdfplot(E(:));  % CDF of photon energy
title('Cumulative Distribution Function of Photon Energy');
xlabel('Photon Energy (Joules)');
ylabel('Cumulative Probability');
