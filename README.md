# How to run

## Instance generator

```
generator.py -d <device> -t <timeslot>
```

Instances will be generated in *examples/* dir and are named as format device_timeslot.lp

## Scheduler

In general:

```
clingo <instance> schedule.lp <weight_function> | clingo - <output>
```

E.g:

```
./clingo1facts examples/1.lp schedule.lp wf/cu.lp | clingo - output.lp
```