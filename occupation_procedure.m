function gamma = occupation_procedure(alpha,beta)
[T,N] = size(alpha);
gamma = zeros(T,N);
for t = 1:T
    for i = 1:N
        gamma(t,i) = (alpha(t,i)*beta(t,i))/(alpha(t,:)*beta(t,:)');
    end
end
end