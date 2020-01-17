function [mu, variance] = estimate_using_occupation(OBS,gamma)
[~, N] = size(gamma);
Nm = sum(gamma);
mu = zeros(2,1);
variance = zeros(2,1);
for i=1:N
    mu(i) = OBS*gamma(:,i)/Nm(i);
    variance(i) = sum((OBS-mu(i)).^2*gamma(:,i))/Nm(i);
end
end