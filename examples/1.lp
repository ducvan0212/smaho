%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Devices:                     2
% Timeslot:                    5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program base.

% init
init(object(device,1),pref(at,(5,1))).

init(object(device,1),pref(at,(5,2))).
init(object(device,1),pref(at,(5,3))).
init(object(device,1),pref(at,(5,4))).
init(object(device,1),pref(at,(5,5))).
init(object(device,2),pref(at,(5,1))).

init(object(device,2),pref(at,(5,2))).

init(object(device,2),pref(at,(5,3))).
init(object(device,2),pref(at,(5,4))).
init(object(device,2),pref(at,(5,5))).

init(object(device,1),cost(at,(5,1))).

init(object(device,1),cost(at,(5,2))).
init(object(device,1),cost(at,(5,3))).
init(object(device,1),cost(at,(5,4))).
init(object(device,1),cost(at,(5,5))).
init(object(device,2),cost(at,(5,1))).

init(object(device,2),cost(at,(5,2))).

init(object(device,2),cost(at,(5,3))).
init(object(device,2),cost(at,(5,4))).
init(object(device,2),cost(at,(5,5))).
init(object(device,1),uncertainty(at,(5,1))).
init(object(device,1),uncertainty(at,(1,2))).
init(object(device,1),uncertainty(at,(5,3))).
init(object(device,1),uncertainty(at,(5,4))).
init(object(device,1),uncertainty(at,(1,5))).
init(object(device,2),uncertainty(at,(1,1))).
init(object(device,2),uncertainty(at,(5,2))).
init(object(device,2),uncertainty(at,(5,3))).
init(object(device,2),uncertainty(at,(5,4))).
init(object(device,2),uncertainty(at,(1,5))).

%- device D has to turn on at least x timeslots, at most y timeslot from timeslot t to t'
%- init(object(device,D),constraint(on,(x,y),(t,t')))).
%- 1
init(object(device,1),constraint(on,(1,1),(1,2))).
%- 2
init(object(device,1),constraint(on,(1,1),(4,5))).
%- 3
init(object(device,2),constraint(on,(1,1),(1,2))).
%- 4
init(object(device,2),constraint(on,(1,1),(3,5))).

%- device D has to turn on BEFORE device D' in interval (t,t')
%- this type of constraint must come after specifying constraint 1 and 3.
%- otherwise, there will be no solution
%init(object(device,2),constraint(before,(device,1),(1,2))).