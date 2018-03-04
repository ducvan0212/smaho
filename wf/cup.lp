
#const w_cost=5.
#const w_uncertainty= 10-w_cost.

%- weight_function table
wf(C,U,P,w_cost*C + w_uncertainty*U):- cost(_,C,_), uncertainty(_,U,_), pref(_,P,_).
