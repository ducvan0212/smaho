con(D,T,T+1)  :- on(D,T), on(D,T+1).
con(D,S,F)    :- con(D,S,T), con(D,T,F), S < F.
span(D,(S,F)) :- con(D,S,F), not on(D,S-1), not on(D,F+1).
span(D,(T,T)) :- on(D,T), not on(D,T-1), not on(D,T+1).

%atoms(C) :- C = #count {D,I: span(D,I)}.

%#show on/2.
%#show cost/3.
#show weight/3.
%#show bound/3.
%#show order/3.
#show span/2.
%#show atoms/1.

