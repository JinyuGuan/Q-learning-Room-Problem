% Action: up, down, left, right
clc
clear
A0 = [0 0 0 1];
A1 = [0 1 1 1];
A2 = [1 1 1 0];
A3 = [0 0 0 0];
A4 = [1 1 0 0];
A5 = [1 0 0 0];
A6 = [1 1 1 1];
A = [A0; A1; A2; A3; A4; A5; A6];
R = A - 1; % Reward Matrix
Newstate = zeros(7, 7); % Initial StateToState Matrix
%%
% Build Reward Matrix (Not necessary)
for i = 1:length(A)
    actions = find(A(i, :) == 1);
    for j = 1: length(actions)
        S = ActionToState(i - 1, actions(j), 3, 2);
        if(S < 6 & S >= 0)
            Newstate(i, S + 1) = 1;
            R(i, actions(j)) = 0;
        else
            S = 6;
            Newstate(i, S + 1) = 1;
            R(i, actions(j)) = 100;
        end
    end
end
%%
% Q-learning processing
t0 = cputime;
N = 200;
state = 4;
Q = zeros(7, 4);
QmaxM = 0;
S = 0;
for i = 1:N
    actions = find(A(state + 1, :) == 1);
    S = 0;
    Qmax = 0;
    QmaxM = 0;
    for j = 1:length(actions)
        S(j) = ActionToState(state, actions(j), 3, 2);
        if(S(j) < 6 & S(j) >= 0)
            Qmax = max(Q(S(j) + 1, :));
        else
            S(j) = 6;
            Qmax = max(Q(S(j) + 1, :));
        end
        Q(state + 1, actions(j)) = R(state + 1, actions(j)) + 0.5*Qmax;
        QmaxM = [QmaxM Qmax];
    end
    %%%%%%%%%%%%%%%%%%%%
    % Generate New State
    [m n] = max(QmaxM);
    if(rand(1) < 0.8)
        state = S(unidrnd(length(actions)));
    else
        state = S(j);
    end
    %%%%%%%%%%%%%%%%%%%%
    plot(i, max(max(Q)), 'bo')
    hold on
end
t1 = cputime - t0
%%
% Results
action = 0;
state = 5;
while(1)
    if(state < 0 | state > 6)
        state = 6
        break
    end
    state
    [m action] = max(Q(state + 1, :));
    state = ActionToState(state, action, 3, 2);
end