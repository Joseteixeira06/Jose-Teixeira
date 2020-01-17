function [alpha, P]=forward_procedure(a,b,pi,eta)
N = length(pi);
T = size(b,2);
%%
alpha = zeros(T,N);
% Initialise at t = 1
for i = 1:N
    alpha(1,i) = pi(i)*b(i,1);
end

%  Recur for t={2,3,...,T}
for t = 2:T
    for j = 1:N
        alpha(t,j) = sum(alpha(t-1,:).*a(:,j)')*b(j,t);
    end
end

% Finalise
P = alpha(T,:)*eta';
end