%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% parameters for cell 1 %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m1 = 100; % the memory s_{m+1} and on will be reset to 0 if x1 is on
memoryLen1 = 400; % the total number of s^1_i.
n_pos1 = 2; % number of nodes in self excitation loop, including x_1 
activeThreshold1 = 2; % the number of activator needed for activating x1.
signal_period1  = 110; %period of C1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% parameters for cell 3 %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

memoryLen3 = 400; % the total number of s^3_i.
activeThreshold3 = 2; % the number of activator needed for activating x3.
signal_period3  = 500; % period of C3
m3  = 100; %the memory s_{m3+1} and on will be reset to 0 if x3 is on
n_pos = 2; % number of nodes in self excitation loop, including x_1 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% parameters for cell 4 %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

memoryLen4 = 800; % the total number of si.
activeThreshold4 = 3; % the number of activator needed for activating x4.
signal_period4  = 1000; % period of C4
m4  = memoryLen4; %the memory s_{m3+1} and on will be reset to 0 if x3 is on


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% The following commands are to set up vectors of the parameters
% No need to change.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
params1(1) = m1;
params1(2) = memoryLen1;
params1(3) = n_pos1;
params1(4) = activeThreshold1;
params1(5) = signal_period1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
params3(1) = memoryLen3;
params3(2) = activeThreshold3;
params3(3) = signal_period3;
params3(4) = m3; 
params3(5) = n_pos;
%%%%%%%%%%%%%%%%%%%%%%%%%%%
params4(1) = memoryLen4;
params4(2) = activeThreshold4;
params4(3) = signal_period4;
params4(4) = m4; 
