#include "clingcon/csp.lp".

#include "./input.lp".

#const max = 1000.

{ on(D,T): timeslot(T) } :- isDevice(D).

&sum{OCCUR} <= U :- OCCUR = #count {T: on(D,T), T <= F, T >= S}, bound(D,(L,U),(S,F)).
&sum{OCCUR} >= L :- OCCUR = #count {T: on(D,T), T <= F, T >= S}, bound(D,(L,U),(S,F)).

&sum{T} <= T' :- order(D,D',(S,F)), isDevice(D), isDevice(D'),
                 on(D ,T ), S <= T , T  <= F,
                 on(D',T'), S <= T', T' <= F.

weight(D,w(C,U,P),T) :- on(D,T), cost(D,T,C), uncertainty(D,T,U), pref(D,T,P).
&dom{0..max} = weight.
&sum{X} = weight :- X = #sum {W,D,T :weight(D,w(C,U,P),T), wf(C,U,P,W)}.
&minimize {weight}.


