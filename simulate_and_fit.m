load('example_outcome_sequence_1.mat') %loads data

params = [0.5,10];
[~, sim]= RW1lr1beta_2arm(params, data);

%% visualise simulation
figure;
plot(data.outcome,'o')%must use outcome from original data
hold on
plot(sim.PP(:,1))
plot((2-sim.data.choice)+0.05,'x')
hold off
ylim([-0.1 1.1])

%% fitting 
%c.f., https://github.com/AnneCollins/TenSimpleRulesModeling/blob/master/FittingFunctions/fit_M3RescorlaWagner_v1.m
%data is already generated in sim
obFunc = @(params_to_fit) -RW1lr1beta_2arm(params_to_fit,sim.data);

%set parameter boundaries
X0 = [rand exprnd(3)];
LB = [0 0];
UB = [1 inf];
[fitted_params, NegLL] = fmincon(obFunc, X0, [], [], [], [], LB, UB);



