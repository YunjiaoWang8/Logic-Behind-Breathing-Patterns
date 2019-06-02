function nextState = f4(currentState, x3, control, params4)

% this is the governing function of node x4 and its signals

% initialize x

%%%%%%%%%%%%%%%%%%%
len = length(currentState);  
nextState = zeros(len, 1);

activeThreshold = params4(2);   

% updating x4

sumActivator_x = sum(currentState(2:end));

if (sumActivator_x>= activeThreshold)
    nextState(1) = 1;
end

% updating the nodes in the memory chain

currentS = currentState(2:end);
lenS = length(currentS);
nextS = zeros(lenS,1);
nextS(1) = control*(1-x3); %  x3 is the inhibitor on the memories
for k = 2:lenS
    nextS(k) = currentS(k-1)*(1-x3);
end

%% memory erase when x4 is on
m = params4(4);
if currentState(1)>0
    for k = m+1:lenS
        nextS(k) = 0;
    end
end
nextState(2:len) = nextS;

