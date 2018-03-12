% ./clingo1facts generator/cost.lp examples/price_energy_20_24.lp > examples/cost_20_24.lp

init(object(device,ID),cost(at,(PRICE * CONSUMED_ENERGY_IN_WH,TIME))) :- dev(ID, TYPE_LOCATION, CONSUMED_ENERGY_IN_WH), cost(TIME,PRICE).

#show init/2.