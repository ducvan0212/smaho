## How to run

In general:
```
clingo <instance> schedule.lp <weight_function> | clingo - <output>
```

E.g:
```
./clingo1facts examples/1.lp schedule.lp wf/cu.lp | clingo - output.lp
```