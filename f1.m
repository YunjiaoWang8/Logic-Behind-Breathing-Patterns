function nextState = f1(currentState, x3, x4, control, params1)

% this is the governing function of node x1 and its signals

% initialize x

len = length(currentState);
nextState = zeros(len, 1);

activeThreshold = params1(4); % the number of activator needed for activating x1.
n_pos = params1(3); % number of nodes in self excitation loop, including x_1 

% updating x1

sumActivator_x1 = sum(currentState(n_pos:end));
if (sumActivator_x1>= activeThreshold) %&& (x4==0)
    nextState(1) = 1;
end

% updating the nodes in the excitatory loop

for k = 2:n_pos
    nextState(k) = currentState(k-1);
end

% updating the nodes in the memory chain

currentS = currentState(n_pos+1:end);
lenS = length(currentS);
nextS = zeros(lenS,1);

nextS(1) = control*(1-x3)*(1-x4); % x3 and x4 act on memories as inhibitors
 for k = 2: lenS
     nextS(k) = currentS(k-1)*(1-x3)*(1-x4);
 end
 
m1 = params1(1);
if currentState(1)>0
    for k = m1+1:lenS
        nextS(k) = 0;
    end
end
nextState(n_pos+1:len) = nextS;
 