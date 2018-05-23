function S = ActionToState(state, action, cnum, rnum)
% action = 1 up
% action = 2 down
% action = 3 lift
% action = 4 right
if(action == 1)
    if(state == cnum*rnum)
        state = 4;
    else
        state = state - cnum;
    end
end

if(action == 2)
    if(state == cnum*rnum)
        state = 2;
    else
        state = state + cnum;
    end
end

if(action == 3)
    if(state == cnum*rnum)
        state = state;
    else
        state = state - 1;
    end
end

if(action == 4)
    if(state == cnum*rnum)
        state = state;
    else
        state = state + 1;
    end
end

S = state;

end