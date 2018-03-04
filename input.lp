% --------------------------------------------------------------------------------
% REPRESENTATION

device(D)   :- init(object(device,D), _             ).
timeslot(T) :- init(               _, pref(at,(_,T))).

isDevice(device(D)) :- device(D).

% device D at T has preference value V
pref(       device(D),V,T)   :- init(object(device,D),        pref(at,(V,T))).
cost(       device(D),V,T)   :- init(object(device,D),        cost(at,(V,T))).
uncertainty(device(D),V,T)   :- init(object(device,D), uncertainty(at,(V,T))).

% device D has constraint on Bound in Interval
bound(device(D),B,I) :- init( object(device,D),constraint(on,B,I) ).
