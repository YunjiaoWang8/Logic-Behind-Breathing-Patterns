
 %%%% This file is used to generate the time series in Fig.3 %%%%

%% Generate controller signals

%%%%%%%%%%% Parameter for Fig.3(Left) %%%%%%%%%%%%
parameters_phase3_paperC;
%%%%%%%%%%% Parameter for Fig.3(Middle) %%%%%%%%%%%%
%parameters_phase2_paperC;
%%%%%%%%%%% Parameter for Fig.3(Right) %%%%%%%%%%%%
%parameters_phase1_paperC;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 TotalTime = 2000; 
 
%%%%% Generate c1 %%%%%%%%%%%%%%%%%%%%% 
signal_period1 = params1(5);
c1 = signalGenerator(TotalTime, signal_period1);

% Generate c3

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
signal_period3 = params3(3);
c3 = signalGenerator(TotalTime, signal_period3);

% Generate c4:

signal_period4 = params4(3);
c4 = signalGenerator(TotalTime, signal_period4);
%c4 = signalGenerator_unif(TotalTime, signal_period4);
%% pre-alocate memory for trajectories.
% other nodes in the excitatory loop. 
% Net1 includes all nodes: x1, nodes in its excitatory loops and si. Net1(1)  = x1, Net1(2) -- Net1(n_pos) represent all
%  Net1(n_pos1 + 1) to Net1(end) represent the memories.
memoryLen1 = params1(2);
n_pos1 = params1(3);
Net1 = zeros(TotalTime, memoryLen1+n_pos1); 


% Net3 includes all nodes: x3 and its memories.
memoryLen3 = params3(1);
Net3 = zeros(TotalTime, memoryLen3+1);

% Net4 includes all nodes: x4 and its memories.
memoryLen4 = params4(1);
Net4 = zeros(TotalTime, memoryLen4+1);
%% initialize Xs and S's
current_state_Net1 = Net1(1,:);
current_state_Net3 = Net3(1,:);
current_state_Net4 = Net4(1,:);
 x1=current_state_Net1(1);
 x3=current_state_Net3(1);
 x4=current_state_Net4(1);

%% Trajectories
for k = 1:TotalTime
    
    %% updating for x1  
     next_state_Net1 = f1(current_state_Net1, x3, x4, c1(k), params1);
    
    
     %% updating for x3
     next_state_Net3 = f3_A(current_state_Net3, c3(k), params3);
    
     
     
     %% updating for x4   
    next_state_Net4 = f4(current_state_Net4, x3, c4(k), params4);
 
    Net1(k,:) = next_state_Net1;
    Net3(k,:) = next_state_Net3;
    Net4(k,:) = next_state_Net4;
    % update the current value of Xs and S's
    current_state_Net1 = next_state_Net1;
    current_state_Net3 = next_state_Net3;
    current_state_Net4 = next_state_Net4;
    x1=current_state_Net1(1);
    x3=current_state_Net3(1);
    x4=current_state_Net4(1);
end
colour='.b';
eps=0.00;

node1 = Net1(:,1)+eps;
node3 = Net3(:,1)+eps;
node4 = Net4(:,1)+eps;

clf;
figure(1)
subplot(3, 1, 1);
plot(node4, colour);
ylabel('X_4', 'FontSize', 20);

set(gca,'FontSize',12);
hold on;

subplot(3, 1, 2);
plot(node3, colour);
ylabel('X_3', 'FontSize', 20);

set(gca,'FontSize',12);
hold on;

subplot(3, 1, 3);
plot(node1, colour);
ylabel('X_1', 'FontSize', 20);
xlabel('Step','FontSize', 20);
set(gca,'FontSize',12);
hold off;

