# How to run

## Instance generator

Default generation: generate an instance that has 20 devices, 24 timeslots with cost encoded in `generator/price_energy_20_24.lp`: 

```
python generator.py
```

Advance generation:

```
python generator.py -d <device> -t <timeslot> -a <affix> -f <cost_file>
```

For specification
```
python generator.py -h
```

Instances will be generated in *examples/`<device>_<timeslot>_<affix>`/* dir. `instance.lp` will contain `cost`, `pref`, `uncertainty` matrixes and `constraints`. 
  
- Note 1: For now, there is just one  generated `constraint` for each device. Manually add more as you want.
- Note 2: Cost encode file *MUST* have the same number of devices and timeslots as provided for the generator

## Scheduler

In general:

```
clingo <instance> schedule.lp <weight_function> | clingo - <output>
```

E.g:

```
./clingo1facts examples/1.lp schedule.lp wf/cu.lp | ./clingo1facts - output.lp
```

## Run with python controller to lower uncertainty

```
clingo controller.lp
```

#### Configuration

```
$ clingo -v
clingo version 5.2.2
Address model: 64-bit

libgringo version 5.2.2
Configuration: with Python 2.7.10, with Lua 5.3.4

libclasp version 3.3.3 (libpotassco version 1.0.1)
Configuration: WITH_THREADS=1
Copyright (C) Benjamin Kaufmann

License: The MIT License <https://opensource.org/licenses/MIT>
```