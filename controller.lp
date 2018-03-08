#script(python)

def main(prg):
  prg.load("examples/1.lp")
  prg.load("schedule.lp")
  prg.load("wf/cu.lp")
  prg.load("output.lp")
  prg.ground([("base", [])])
  with prg.solve(yield_=True) as it:
    for m in it: print(m)
    print(it.get())
    
#end.
