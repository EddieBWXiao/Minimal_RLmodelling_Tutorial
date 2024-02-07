close all;clear;
load('example_outcome_sequence_1.mat') %loads data

nsims = 100;
alpha_sim = unifrnd(0,1,[nsims,1]);
beta_sim = exprnd(10,[nsims,1]);
alpha_fit = nan(size(alpha_sim));
beta_fit = nan(size(beta_sim));

for i = 1:nsims
    params = [alpha_sim(i),beta_sim(i)];
    [~, sim]= RW1lr1beta_2arm(params, data);
    
    %% fitting 
    %c.f., https://github.com/AnneCollins/TenSimpleRulesModeling/blob/master/FittingFunctions/fit_M3RescorlaWagner_v1.m
    %data is already generated in sim
    obFunc = @(params_to_fit) -RW1lr1beta_2arm(params_to_fit,sim.data);
    
    %set parameter boundaries
    X0 = [rand exprnd(10)];
    LB = [0 0];
    UB = [1 inf];
    [fitted_params, NegLL] = fmincon(obFunc, X0, [], [], [], [], LB, UB);
    
    alpha_fit(i) = fitted_params(1);
    beta_fit(i) = fitted_params(2);

end

figure;
plot(alpha_sim,alpha_fit,'o')
figure;
plot(beta_sim,beta_fit,'o')
xlim([min(beta_sim),max(beta_sim)])
ylim([min(beta_sim),max(beta_sim)])
