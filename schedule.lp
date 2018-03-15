#include "./input.lp".
#const b=0.

L { on(D,T): timeslot(T), S<=T, T<=F } U :- isDevice(D), bound(D,(L,U),(S,F)).

weight(D,w(C,U,P),T) :- on(D,T), cost(D,T,C), uncertainty(D,T,U), pref(D,T,P).

:- order(D,D',(S,F)), isDevice(D), isDevice(D'),
   on(D ,T ), S <= T , T  <= F,
   on(D',T'), S <= T', T' <= F,
   T >= T'.
   
#minimize { W@1,D,T: weight(D,w(C,U,P),T), wf(C,U,P,W) }.

:- S = #sum {U,D,T: weight(D,w(C,U,P),T)}, S >= b.