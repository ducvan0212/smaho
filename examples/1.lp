%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Devices:                     2
% Timeslot:                    5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program base.

% init
init(object(device,1),pref(at,(1,1))).

init(object(device,1),pref(at,(5,2))).
init(object(device,1),pref(at,(5,3))).
init(object(device,1),pref(at,(5,4))).
init(object(device,1),pref(at,(5,5))).
init(object(device,2),pref(at,(5,1))).

init(object(device,2),pref(at,(1,2))).

init(object(device,2),pref(at,(5,3))).
init(object(device,2),pref(at,(5,4))).
init(object(device,2),pref(at,(5,5))).

init(object(device,1),cost(at,(1,1))).

init(object(device,1),cost(at,(5,2))).
init(object(device,1),cost(at,(5,3))).
init(object(device,1),cost(at,(5,4))).
init(object(device,1),cost(at,(5,5))).
init(object(device,2),cost(at,(5,1))).

init(object(device,2),cost(at,(1,2))).

init(object(device,2),cost(at,(5,3))).
init(object(device,2),cost(at,(5,4))).
init(object(device,2),cost(at,(5,5))).
init(object(device,1),uncertainty(at,(1,1))).
init(object(device,1),uncertainty(at,(10,2))).
init(object(device,1),uncertainty(at,(10,3))).
init(object(device,1),uncertainty(at,(10,4))).
init(object(device,1),uncertainty(at,(10,5))).
init(object(device,2),uncertainty(at,(10,1))).
init(object(device,2),uncertainty(at,(1,2))).
init(object(device,2),uncertainty(at,(10,3))).
init(object(device,2),uncertainty(at,(10,4))).
init(object(device,2),uncertainty(at,(10,5))).

% device D has to turn on at least x time, at most y times from timeslot t to t'
% init(object(device,D),constraint(on,(x,y),(t,t')))).
init(object(device,1),constraint(on,(3,3),(1,5))).
init(object(device,2),constraint(on,(2,2),(1,5))).
