function [loglik, pout]= RW1lr1beta_2arm(params, data)
% modified by B.X. for creating a minimal tutorial
% 
% params = vector of parameter values for alpha and beta
% data.choice = vector of choices [1 2]
% data.outcome = vector of outcomes received, [0 1]
% 
% The learning model used to fit choices is a simple Rescorla-Wagner
% (Rescorla & Wagner 1972) function, using a softmax
% choice/link/observation function:  
%   learning model (RW):     vA <- vA + alpha*(r-vA)
%   choice function (softmax):    p(A) = exp(beta*vA)/(exp(beta*vA)_exp(beta*vB))
% 
% ------------------------------------------------------------------------
% Written by Hanneke den Ouden 2015 <h.denouden@gmail.com>
% Donders Center for Cognitive Neuroimaging
% Donders Center for Brain, Cognition and Behavior
% Radboud University Nijmegen
% ------------------------------------------------------------------------


% get behavioural data
choice  = data.choice; 
outcome = data.outcome; 
nt      = length(outcome);
nc      = 2; % number of choice options

% for simulations
if isempty(choice)
    sim_mode = true;
else
    sim_mode = false;
end

% get params
alpha   = params(1);% sensitivity to reward and punishment
beta    = params(2); %learning rate

% initialise variables
v0      = 0.5*ones(1,nc); % initial value 
VV      = nan(nt,nc); % evolution of value over time
PP      = nan(size(VV)); % evolution of choice prob over time

v = v0; % initialise v
for t = 1:nt
    
    % compute likelihood of the observed choices given the params and the
    % probability of 'go'
    ev  = exp(beta*v); % exp(inverse temp * expected value) for each option
    sev = sum(ev); %the sum to divide over
    p   = ev/sev; % probability each choice
    
    if sim_mode
        %generate the choice
        c = 2-binornd(1,p(1)); %p(1) since for ref option
        if c == 1
            %based on choice, get outcome
            r = outcome(t);
        elseif c == 2
            r = 1-outcome(t);
            %in sim_mode, outcome should be all of option 1
        end
        data.choice(t) = c;%store it back into data
        data.outcome(t) = r;%store it back into data!!
    else
        c   = choice(t);
        r   = outcome(t);
    end
    
    % store value of V and choice probability
    VV(t,:) = v; % store value of V
    PP(t,:) = p; 
    
    % update value 
    dv  = r-v(c); % compute prediction error
    v(c)   = v(c) + alpha*dv;    % update value
    
end

% comput the likelihood: sum of logs of p(observed choice) for all trials
if sim_mode
    loglik = NaN;
else
    loglik = sum(log(PP(data.choice==1,1)))+sum(log(PP(data.choice==2,2)));
end

% output parameters
pout = struct('VV',VV,'PP',PP, 'loglik',loglik,'params',params,'data',data);
end


