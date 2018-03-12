% --------------------------------------------------------------------------------
% REPRESENTATION

device(D)   :- init(object(device,D), _             ).
timeslot(T) :- init(               _, pref(at,(_,T))).

isDevice(device(D)) :- device(D).

% device D at T has preference value V
pref(       device(D),T,V)   :- init(object(device,D),        pref(at,(V,T))).
cost(       device(D),T,V)   :- init(object(device,D),        cost(at,(V,T))).
uncertainty(device(D),T,V)   :- init(object(device,D), uncertainty(at,(V,T))).

% device D has constraint on Bound in Interval
bound(device(D),B,I) :- init( object(device,D),constraint(on,B,I) ).

% partial order on device D and D'
order(device(D),device(D'),I):- init(object(device,D),constraint(before,(device,D'),I)).