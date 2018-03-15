#not /usr/bin/env python

import clingo
from IPython import embed
import subprocess
import os
import shutil
import re
import sys

DEBUG  = False
MAXINT = 999999

def debug(msg):
  if DEBUG: print msg

def part_uncertainty(rfile):
  if not os.path.isfile(rfile):
    print '{} does not exist.'.format(rfile)
    return MAXINT
  else:
    uncertainty = []
    with open(rfile) as f:
      content = f.read().splitlines()
    for line in content:
      weights = re.findall(r"w\(\d+,\d+,\d+\)", line)
      for w in weights:
        uncertainty.append( int(re.findall(r"\d+", w)[1]) )
    return sum(uncertainty)  

def complete_solution_uncertainty(rdir):
  upart = []
  for rfile in os.listdir(rdir):
    if rfile.endswith(".txt"):
      upart.append( part_uncertainty(os.path.join(rdir, rfile)) )
  return sum(upart)
  
def solve_part(idir, constraint_file, lower_uncertainty):
  ifile = idir + "/instance.lp"
  cfile = idir + "/constraints/" + constraint_file
  rfile = idir + "/result/" + constraint_file.replace("lp",'txt')

  if lower_uncertainty:
    previous_uncertainty = part_uncertainty(rfile)
    debug('./clingo1facts ' + ifile + ' ' + cfile + ' schedule.lp wf/cu.lp -c b=' + str(previous_uncertainty) + '| ./clingo1facts - output.lp')
    p = subprocess.Popen('./clingo1facts ' + ifile + ' ' + cfile + ' schedule.lp wf/cu.lp -c b=' + str(previous_uncertainty) + '| ./clingo1facts - output.lp', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  else:
    debug('./clingo1facts ' + ifile + ' ' + cfile + ' schedule.lp wf/cu.lp -c b=' + str(MAXINT) + '| ./clingo1facts - output.lp')
    p = subprocess.Popen('./clingo1facts ' + ifile + ' ' + cfile + ' schedule.lp wf/cu.lp -c b=' + str(MAXINT) + '| ./clingo1facts - output.lp', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  
  last_line = ""
  for line in iter(p.stdout.readline, ''):
    debug(line)
    last_line = line
    
  if last_line.strip() == "UNKNOWN" or last_line.strip() == "UNSATISFIABLE":
    return False
    
  with open(rfile,"w") as f:
    f.write(line)

  return True

# return false if UNSAT
# return solution uncertainty if SAT
def solve(instance, ubound):
  ret = False
  result = []
  constraint_dir = instance + "/constraints"
  result_dir = instance + "/result"

  if not os.path.exists(result_dir):
    os.makedirs(result_dir)

  for constraint_file in os.listdir(constraint_dir):
    if constraint_file.endswith(".lp"):
      debug(os.path.join(constraint_dir, constraint_file))
      if ubound == MAXINT:
        ret = solve_part(instance, constraint_file, False)
        if not ret:
          return ret
      else:
        new_solution = solve_part(instance, constraint_file, True)
        if new_solution:
          return complete_solution_uncertainty(result_dir)
        else:
          continue
    else:
      continue
  
  return ret if not ret else complete_solution_uncertainty(result_dir)

def print_result(instance):
  result = []
  result_dir = instance + "/result"
  for rfile in os.listdir(result_dir):
    if rfile.endswith(".txt"):
      with open(result_dir + "/" + rfile) as f:
        content = f.read().splitlines()
      for line in content:
        result.append(line)
  print " ".join(result)
      
b = MAXINT
while True:
  print("\n")
  print("Uncertainty bound = {}".format(b))
  ret = solve("examples/20_24_1", b)
  print_result("examples/20_24_1")
  
  if not ret:
    sys.exit()
  
  print "Wanna lower uncertainty? (y/n): "
  decision = raw_input()
  if decision == "n":
    sys.exit()
    
  b = ret