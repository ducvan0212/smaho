#script(python)
import clingo
from IPython import embed
import subprocess
import os

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
  
  def solve_part(dir, pname):
    ifile = dir + "/instance.lp"
    pfile = dir + "/constraints/" + pname
    p = subprocess.Popen('./clingo1facts ' + ifile + ' ' + pfile + ' schedule.lp wf/cu.lp | ./clingo1facts - output.lp', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    for line in iter(p.stdout.readline, ''):
      print line
    return line.replace("\n","")
      
  def solve(dir):
    result = []
    group_dir = dir + "/constraints"
    for filename in os.listdir(group_dir):
      if filename.endswith(".lp"): 
        print(os.path.join(group_dir, filename))
        result.append( solve_part(dir, filename) )
        continue
      else:
        continue
    return result
    
  r = solve("examples/20_24_1")
  print r
  
  #prg.load("output.lp")
  #prg.ground([("base", [])])
  
  #while True:
  #  b = sum(UNCERTAIN)
  #  print("\n")
  #  debug("Uncertainty bound = {}".format(b))
  #  parts = []
  #  parts.append(("lower_uncertainty", [b]))
  #  prg.ground(parts)
  #  prg.assign_external(clingo.Function("uncertainty_bound", [b]), True)
  #  ret = prg.solve(on_model=on_model)
  #  
  #  if ret.unsatisfiable or ret.unknown:
  #    return
  #  
  #  print "Wanna lower uncertainty? (y/n): "
  #  decision = raw_input()
  #  if decision == "n":
  #    return
  #  debug("Release {}".format(b))
  #  prg.release_external(clingo.Function("uncertainty_bound", [b]))
  #  prg.cleanup()
    
#end.
