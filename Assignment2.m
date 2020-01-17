clc;clear;close all;
%% Initialise parameters

% Transition matrix
trans_matrix = [0, 0.93, 0.07, 0;
    0, 0.74, 0.21, 0.05;
    0, 0.08, 0.9, 0.02;
    0, 0, 0, 0];

% Matrix of parameters
param_matrix = [3.0, 5.0;
    1.21, 0.25];

% Observation
observation = [1.8, 2.6, 2.7, 3.3, 4.4, 5.4, 5.2];

%% 1, 2
% Number of observations
T = length(observation);
N = size(param_matrix,2);
mu =  param_matrix(1,:);
sigma = sqrt(param_matrix(2,:));
x_pdf = 0:0.01:T;
b = zeros(N,T);
figure(1)
for i=1:N
    pd = makedist('Normal','mu',mu(i),'sigma',sigma(i));
    y = pdf(pd, x_pdf);
    b(i,:) = interp1(x_pdf,y,observation);
    plot(x_pdf,y,'o',observation,b(i,:),':.');
    hold on
end
grid on
legend('State1','State2')
xlabel('Time')
ylabel('Probability')
title('Probability density(Real)')
%% 3. Forward Likelihood
% Initialize transition matrix
pi = trans_matrix(1,2:3);
a = trans_matrix(2:3,2:3);
eta = trans_matrix(2:3,end)';
disp('3:****Forward Likelihood')
[alpha, P_forward]=forward_procedure(a,b,pi,eta)

%% 4. Backward Likelihood
disp('4:****Backward Likelihood')
[beta, P_backward]=backward_procedure(a,b,pi,eta)

%% 5. Occupation Likelihood
disp('5:****Occupation Likelihood')
gamma = occupation_procedure(alpha,beta)

%% 6. Re-estimate the mean and variance
disp('6:****Re-estimate mean and variance')
[est_mu, est_variance] = estimate_using_occupation(observation,gamma)

%% 7. Plot the pdfs using re-estimated mean and variance
figure(2)
for i = 1:length(pi)
    re_pd= makedist('Normal','mu',est_mu(i),'sigma',sqrt(est_variance(i)));
    y = pdf(re_pd, x_pdf);
    plot(x_pdf,y,'o');
    hold on
end
grid on
legend('State1','State2')
xlabel('Time')
ylabel('Probability')
title('Probability density(Estimated)')