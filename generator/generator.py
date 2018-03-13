import clingo
import datetime
import re  
import sys
import getopt
from IPython import embed 
import subprocess
import random
import os
import shutil

KEYWORDS = ["pref", "uncertainty"]

def main(argv):
  device    = 21
  timeslot  = 25
  affix     = "1"
  cost_file = "generator/price_energy_20_24.lp"
  group     = 0
  
  try:
    opts, args = getopt.getopt(argv,"hd:t:a:f:g:",["device=","timeslot=","affix=","file=","group="])
  except getopt.GetoptError:
    print 'generator.py -d <device> -t <timeslot> -a <affix> -c <file> -g <group>'
    sys.exit(2)
  for opt, arg in opts:
    if opt == '-h':
      print '\n  generator.py -d <device> -t <timeslot> -a <affix> -c <file> -g <group>\n'
      print 'Parameters:'
      print '  device    Default 20.'
      print '  timeslot  Default 25.'
      print '  affix     Default 1. Purpose: discriminate generated folder'
      print '  file      Cost encode file. Template can be found at generator/price_energy_20_24.lp. Cost encode MUST have the same number of devices and timeslots as provided for the generator'
      print '  group:    Number of constraints grouped into subprograms for solving separately'
      sys.exit()
    elif opt in ("-d", "--divice"):
      device = int(arg) + 1
    elif opt in ("-o", "--ofile"):
      timeslot = int(arg) + 1
    elif opt in ("-a", "--affix"):
      affix = arg
    elif opt in ("-f", "--file"):
      cost_file = arg
    elif opt in ("-g", "--group"):
      group = int(arg)
      
  # create directory
  directory = "examples/" + str(device-1) + "_" + str(timeslot-1) + "_" + affix
  if not os.path.exists(directory):
    os.makedirs(directory)
    
  # random assign value for uncertainty and pref
  for k in KEYWORDS:
    fname =  str(directory) + "/" + k + ".lp"
    with open(fname,"w") as f:
      for d in range(1,device):
        for t in range(1,timeslot):
          value = random.randint(1,10)
          f.write("init(object(device," + str(d) + ")," + k + "(at,(" + str(value) + "," + str(t) + "))).\n")
  
  # calculate cost from seed file (which is price_energy_20_24)
  source = os.path.dirname(__file__)
  parent = os.path.join(source, '../')
  p = subprocess.Popen('./clingo1facts ' + cost_file + ' generator/cost.lp', cwd=parent, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  fname =  str(directory) + "/cost.lp"
  with open(fname,"w") as f:
    for line in iter(p.stdout.readline, ''):
      f.write(line.replace(" ","\n"))
  
  # combine all created files in to one and generate constraints
  fname = str(directory) + "/instance.lp"
  with open(fname,"w") as f:
    for k in KEYWORDS:
      f.write("#include \"" + k + ".lp\".\n")
    f.write("#include \"cost.lp\".\n\n")
  
  # create directory for constraint groups
  directory = directory + "/constraints"
  if os.path.exists(directory):
    shutil.rmtree(directory)
  os.makedirs(directory)
  
  # generate constraint groups
  if group == 0:
    fname = directory + "/g.lp"
    with open(fname,"w") as f:
      f.write("#program g1.\n")
      f.write("#external g1_flag.\n")

  for d in range(1,device):
    group_count = (d-1)/group + 1
    gname = "g" + str(group_count)
    fname = directory + "/" + gname + ".lp"
    with open(fname,"a") as f:
      i1       = random.randint(1,timeslot-2)
      i2       = random.randint(i1+1,timeslot-1)
      interval = "(" + str(i1) + "," + str(i2) + ")"
      len_inte = i2-i1
      v1       = random.randint(1,len_inte)
      v2       = random.randint(v1,len_inte)
      bound    = "(" + str(v1) + "," + str(v2) + ")"
      
      f.write("init(object(device," + str(d) + "),constraint(on," + bound + "," + interval + ")).\n")
        
      
if __name__ == "__main__":
   main(sys.argv[1:])    