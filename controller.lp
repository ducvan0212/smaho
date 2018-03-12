#script(python)
import clingo
from IPython import embed

DEBUG     = False
UNCERTAIN = [99999]

def main(prg):
  def debug(msg):
    if DEBUG: print msg 
    
  def on_model(m):
    del UNCERTAIN[:]
    for i in m.symbols(True):
      if i.name == "weight":
        UNCERTAIN.append(i.arguments[1].arguments[1].number) 
    
    debug("Uncertainty array {}".format(UNCERTAIN))
    print "Found a solution that has uncertainty = {}".format(sum(UNCERTAIN))
  
  prg.load("examples/1.lp")
  prg.load("schedule.lp")
  prg.load("wf/cu.lp")
  prg.load("output.lp")
  prg.ground([("base", [])])
  
  while True:
    b = sum(UNCERTAIN)
    print("\n")
    debug("Uncertainty bound = {}".format(b))
    parts = []
    parts.append(("lower_uncertainty", [b]))
    prg.ground(parts)
    prg.assign_external(clingo.Function("uncertainty_bound", [b]), True)
    ret = prg.solve(on_model=on_model)
    
    if ret.unsatisfiable or ret.unknown:
      return
    
    print "Wanna lower uncertainty? (y/n): "
    decision = raw_input()
    if decision == "n":
      return
    debug("Release {}".format(b))
    prg.release_external(clingo.Function("uncertainty_bound", [b]))
    prg.cleanup()
    
#end.
