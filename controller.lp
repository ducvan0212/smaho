#script(python)
import clingo
from IPython import embed

UNCERTAIN = []

def main(prg):
  def on_model(m):
    del UNCERTAIN[:]
    for i in m.symbols(True):
      if i.name == "weight":
        UNCERTAIN.append(i.arguments[1].arguments[1].number) 
    
    print "\nUncertainty {}: {}".format(UNCERTAIN, sum(UNCERTAIN))
  
  prg.load("examples/1.lp")
  prg.load("schedule.lp")
  prg.load("wf/cu.lp")
  prg.load("output.lp")
  prg.ground([("base", [])])
  
  ret = prg.solve(on_model=on_model)
  if ret.unsatisfiable or ret.unknown:
    return
  else:
    b = sum(UNCERTAIN)  
    print "Find a solution with uncertainty: {}".format(b)
    
  while True:
    parts = []
    parts.append(("lower_uncertainty", [b]))
    prg.ground(parts)
    print "Find another solution that has uncertainty < {}".format(b)
    prg.assign_external(clingo.Function("uncertainty_bound", [b]), True)
    ret = prg.solve(on_model=on_model)

    if ret.unsatisfiable or ret.unknown:
      return
    else:
      print "=============\nLower uncertainty? (y/n): ",
      decision = raw_input()
      if decision == "n":
        return
      prg.release_external(clingo.Function("uncertainty_bound", [b]))
      prg.cleanup()
      b = sum(UNCERTAIN)  
      
#end.
