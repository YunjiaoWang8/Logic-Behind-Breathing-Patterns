 function nextState = f3_A(currentState, control, params3)

% this is the governing function of node x3 and its signals
% x3 is the same network as x1

% initialize x

%%%%%%%%%%%%%%%%%%%
len = length(currentState);  
nextState = zeros(len, 1);
activeThreshold = params3(2);   

% updating x3
n_pos = params3(5); % number of nodes in self excitation loop
sumActivator_x = sum(currentState(n_pos:end));
if (sumActivator_x>= activeThreshold)% 
    nextState(1) = 1;
end

% updating the inner loop
for k = 2:n_pos
    nextState(k) = currentState(k-1);
end

% updating the nodes in the memory chain

currentS = currentState(n_pos+1:end);
lenS = length(currentS);
nextS = zeros(lenS,1);
 
nextS(1) = control; % 


for k = 2:lenS
    nextS(k) = currentS(k-1);
end

%% Memory erase if x3 is on.
m = params3(4);
if currentState(1)>0
    for k = m+1:lenS
        nextS(k) = 0;
    end
end
nextState(n_pos+1:len) = nextS;

