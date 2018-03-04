#include "./input.lp".


L { on(D,T): timeslot(T), T>=S, T<=F } U :- isDevice(D), bound(D,(L,U),(S,F)).

weight(D,w(C,U,P),T) :- on(D,T), cost(D,C,T), uncertainty(D,U,T), pref(D,P,T).

%- look for sum of records in weight_function table which is calculated in wf/*
weight(D,S) :- S = #sum {W,w(C,U,P),T: weight(D,w(C,U,P),T), wf(C,U,P,W)}, isDevice(D).

#minimize { S@1,D: weight(D,S) }.
