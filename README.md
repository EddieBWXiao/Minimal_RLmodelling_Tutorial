Minimal code required to simulate and fit a basic reinforcement learning model (vaguely aka Q-learning model, vaguely aka Rescorla-Wagner model)

-Inspired by the tutorial from Hanneke den Ouden (http://www.hannekedenouden.ruhosting.nl/RLtutorial/Instructions.html) and Anne Collins (https://github.com/AnneCollins/TenSimpleRulesModeling).

# Contents
simulate_and_fit is the main function for demonstrating 1) how to simulate the behaviour / create a "virtual participant" with a given combination of computational parameters, and 2) fit the simulated data with maximum likelihood estimation. The fitting procedure can be applied to real data as well.

RW1lr1beta_2arm.m is adapted from the tutorial written by Hanneke den Ouden

-This function is the model specification; it can act both as the likelihood function, which it does in the original den Ouden tutorial, and as a function to simulate choices (which makes life easier, I hope).



# Purpose

-Existing RL tutorials can be "clunky": they can give more in-depth introductions to a topic, but it can be 1) overwhelming to think about all the steps of modelling at once without previous hands-on experiment, 2) impossible to adapt the code for one's own project.

-This repository includes the bare minimum of code needed to get started. It should be a plug-and-play situation, as long as MATLAB has been installed.

-May be suitable for people who would like to get a quick start with cognitive computational modelling, has quickly read the den Ouden tutorial / the Wilson & Collins (2019) paper, and would like to write MATLAB-based modelling scripts "from scatch" (i.e., without relying on the more powerful but also more complicated toolboxes such as the HGF / VBA ).
