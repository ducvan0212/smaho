#include "./input.lp".


%L { on(D,T): timeslot(T), S<=T, T<=F } U :- isDevice(D), bound(D,(L,U),(S,F)).

{ on(D,T): timeslot(T) } :- isDevice(D).

:- isDevice(D), bound(D,(F1,F2),(S,F)), #count {on(D,T) : on(D,T),S<= T, T<= F} <1.
%:- isDevice(D), bound(D,(F1,F2),(S,F)), #count {on(D,T) : on(D,T), T < F} <1.

%:- isDevice(D), bound(D,(L,U),(_,_)), C = #count { T:on(D,T) }, L > C.
%:- isDevice(D), bound(D,(L,U),(_,_)), C = #count { T:on(D,T) }, C < U.

for_bound():- on(D,T), bound(D,(_,_),(S,F)).

weight(D,w(C,U,P),T) :- on(D,T), cost(D,T,C), uncertainty(D,T,U), pref(D,T,P).

:- order(D,D',(S,F)), isDevice(D), isDevice(D'),
   on(D ,T ), S <= T , T  <= F,
   on(D',T'), S <= T', T' <= F,
   T >= T'.
   
#minimize { W@1,D,T: weight(D,w(C,U,P),T), wf(C,U,P,W) }.

#program lower_uncertainty(n).
#external uncertainty_bound(n).
:- S = #sum {U,D,T: weight(D,w(C,U,P),T)}, S >= n, uncertainty_bound(n).

#show on/2.
#show bound/3.