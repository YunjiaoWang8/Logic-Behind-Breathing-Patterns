function starts = findPattern(x, pattern)

% This function is used to find the given `pattern'
% in the vector x. The file is called by Varying_c1_phase3.m and so on.


pat_len = length(pattern);
x_len = length(x);

Max_num = floor(x_len/ pat_len); 

starts = zeros(Max_num, 1); 
search_len = x_len - pat_len+1;
k = 1;
n = 1; 
while n<= search_len
    s = x(n : n + pat_len-1);
    if (s==pattern)
        starts(k) = n;
        n = n + pat_len;
        k = k+1;
    else
        n = n+1;
    end        
end
if k>1
    starts = starts(1:k-1);
else
    starts = [];
end