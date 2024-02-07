data.outcome = [1 1 1 1 1 1 1 0 1 1 1 0 0 0 0 1 0 1 0 1];
data.choice = [];
params = [0.5,10];
[~, pout]= RW1lr1beta_2arm(params, data);

figure;
plot(pout.data.outcome,'o')
hold on
plot(pout.PP(:,1))
plot((2-pout.data.choice)+0.05,'x')
hold off
ylim([-0.1 1.1])


