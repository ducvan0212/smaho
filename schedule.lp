#include "./input.lp".


L { on(D,T): timeslot(T), S<=T, T<=F } U :- isDevice(D), bound(D,(L,U),(S,F)).

weight(D,w(C,U,P),T) :- on(D,T), cost(D,C,T), uncertainty(D,U,T), pref(D,P,T).

%- look for sum of records in weight_function table which is calculated in wf/*
total_weight(D,S) :- S = #sum {W,w(C,U,P),T: weight(D,w(C,U,P),T), wf(C,U,P,W)}, isDevice(D).

:- order(D,D',(S,F)), isDevice(D), isDevice(D'),
   on(D ,T ), S <= T , T  <= F,
   on(D',T'), S <= T', T' <= F,
   T >= T'.
   
#minimize { S@1,D: total_weight(D,S) }.

#program lower_uncertainty(n).
#external uncertainty_bound(n).
:- S = #sum {U,D,T: weight(D,w(C,U,P),T)}, S >= n, uncertainty_bound(n).