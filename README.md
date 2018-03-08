# How to run

## Instance generator

```
python generator.py -d <device> -t <timeslot>
```

Instances will be generated in *examples/* dir and will be named in format `<device>_<timeslot>.lp`.

TODO: generate constraints.

## Scheduler

In general:

```
clingo <instance> schedule.lp <weight_function> | clingo - <output>
```

E.g:

```
./clingo1facts examples/1.lp schedule.lp wf/cu.lp | ./clingo1facts - output.lp
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