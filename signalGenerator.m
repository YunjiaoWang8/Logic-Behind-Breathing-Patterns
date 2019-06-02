function c = signalGenerator(TotalTime,signal_period)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this function is used to generate a sequence of signals with period `signal_period'
c = zeros(TotalTime, 1);
num = floor(TotalTime / signal_period);
% randomize the signalGenerator
k = floor(signal_period*rand)+1;
for i = 0 : num
    c(i*signal_period + k) = 1;
end
%c = c(1:200);