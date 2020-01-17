function [beta, P]=backward_procedure(a,b,pi,eta)
N = length(pi);
T = size(b,2);
%%
beta = zeros(T,N);
% Initialise at t = T
beta(T,:) = eta;

%  Recur for t={T-1,T-2,...,1}
for t = T-1:-1:1
    for i = 1:N
        beta(t,i) = sum(a(i,:).*b(:,t+1)'.*beta(t+1,:));
    end
end

% Finalise
P = sum(pi.*b(:,1)'.*beta(1,:));
end