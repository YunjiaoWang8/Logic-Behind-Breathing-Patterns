clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%  parameter values for 3-phase %%%%%%%%%%
parameters_phase3_paperC;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TotalTime = 6000;
%%%%% Computing the region of the period of c1  %%%%%%%%%
% in order to have 3-phase, we require the frequency of c1 lower than the
% frequency of c4. So we use the period of c4 to find the range of c1.
startPeriod = 1; 
period4 = params4(3);
endPeriod = floor(period4*3/2) - 1;

step_period = 5;
num_period = floor((endPeriod - startPeriod)/step_period);

Data_inp_exp = struct('signal_period', 0, 'expiration', [], 'inspiration', [],'totalBreath',[]);
numData = 0; 

%% Generating data and store in All_data %%%

for k = 1:num_period
    k
    signal_period = startPeriod + step_period*(k-1);
    
    params1(5) = signal_period;
    totT = TotalTime + 2*signal_period; % add 2*period to let the memory gets to 10... 0 1 0
    % Compute time series couple of times to get the data, note that we use
    % random signal generator in TrajectoryGenerator_3Nodes
    
    for i = 1:10
        [Net1,  Net3, Net4] = TrajectoryGenerator_3Nodes(totT, params1,  params3,params4);
        %% The following is for the purpose of checking the time series. Comment them out if you don't want to see the figures.
        node1 = Net1(:,1);
        node3 = Net3(:,1);
        node4 = Net4(:,1);
        
        figure(1)
        hold off
        subplot(2, 2, 1)
        plot(node1, '*')
        ylabel('x1')
        
        
        
        subplot(2, 2, 2)
        plot(node3, '*')
        ylabel('x3')
        
        subplot(2, 2, 3)
        plot(node4, '*')
        ylabel('x4')
        
        %% Find consecutive 1s and 0s and store them in Data_inp_exp
        starts = findPattern(node1, [0;1]);
        ends = findPattern(node1, [1;0]);
        len_starts = length(starts);
        len_ends = length(ends);
        if len_starts > 3
            starts = starts(2:end);
            ends = ends(2:end);
            minLen = min(length(starts), length(ends));
            if starts(1) < ends(1) % 01 occurs earlier than 10
                number_1s = ends(1:minLen) - starts(1:minLen);
                number_0s =  starts(2:minLen) - ends(1:minLen-1);
            elseif starts(1) > ends(1)
                number_1s =   ends(2:minLen) - starts(1:minLen-1);
                number_0s =  starts(1:minLen) - ends(1:minLen);
            end
            numData = numData+1;
            Data_inp_exp(numData).expiration = number_0s;
            Data_inp_exp(numData).inspiration = number_1s;
             Data_inp_exp(numData).totalBreath = starts(2:len_starts-1) - starts(1:len_starts-2);
            Data_inp_exp(numData).signal_period = signal_period;
        else
            disp('Trajectory is not long enough, please increase the value of TotalTime')
        end
    end
end

%% Rewrite the data in a matrix form that could be saved and plot in R.

% The matrix consists of three column
%  Signal_Period, Type (expiration(0), inspiration(1))), value
% Pre-alocate the data
All_data = zeros(80000, 3);
count = 0;
% 
for j = 1:numData
    % add expiration data
    len0 = length(Data_inp_exp(j).expiration);
    sg = Data_inp_exp(j).signal_period;
    All_data(count+1:count+len0, 1:2) = repmat([sg, 0], [len0, 1] );
    All_data(count+1:count+len0, 3) = Data_inp_exp(j).expiration;
    count = count + len0;
    % add inspriation data
    len1 = length(Data_inp_exp(j).inspiration);
    All_data(count+1:count+len1, 1:2) = repmat([sg, 1], [len1, 1] );
    All_data(count+1:count+len1, 3) = Data_inp_exp(j).inspiration;
    count = count + len1;  
    % add totalBreathing data
    len2 = length(Data_inp_exp(j).totalBreath);
    All_data(count+1:count+len2, 1:2) = repmat([sg, 2], [len2, 1] );
    All_data(count+1:count+len2, 3) = Data_inp_exp(j).totalBreath;
    count = count + len2; 
end
All_data = All_data(1:count, :);
save('AllData_varyingc1_totBreath.mat', 'All_data')

