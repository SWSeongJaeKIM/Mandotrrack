clc;
clear all;
close all;

sequenceLength = 10^2;
stateMean = 0;
stateVariance = 1;
initialState = normrnd(stateMean, sqrt(stateVariance), 1, 1); % s[-1]
a = 1/2; 
inputVariance = 2;

inputNoise = normrnd(0, sqrt(inputVariance), 1, sequenceLength + 2000);
systemState = filter(1, [1 -a], inputNoise, initialState);
systemState(1:2000) = []; % ignoring transient samples

% x[n] = s[n] + w[n]
observationVariance = 0.1;
measurementNoise = normrnd(0, observationVariance, 1, sequenceLength);
observedSignal = systemState + measurementNoise;

initialStateEstimate = stateMean;
initialMSE = stateVariance;
stateEstimate = zeros(1, sequenceLength);
predictedState = a * initialState; % Prediction
predictedMSE = a^2 * initialMSE + inputVariance; % Prediction MSE
kalmanGain = predictedMSE / (observationVariance + predictedMSE); % Kalman gain
stateEstimate(1) = predictedState + kalmanGain * (observedSignal(1) - predictedState); % Correction
mse = (1 - kalmanGain) * predictedMSE; % MSE

for i = 2:sequenceLength
    predictedState = a * stateEstimate(i-1); % Prediction
    predictedMSE = a^2 * mse + inputVariance; % Prediction MSE
    kalmanGain = predictedMSE / (observationVariance + predictedMSE); % Kalman gain
    stateEstimate(i) = predictedState + kalmanGain * (observedSignal(i) - predictedState); % Correction
    mse = (1 - kalmanGain) * predictedMSE; % MSE
end

plot(systemState, 'r')
hold on
plot(observedSignal, 'b')
plot(stateEstimate, 'g')
legend('Actual State', 'Noisy Signal', 'Estimated State')