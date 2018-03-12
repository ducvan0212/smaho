import clingo
import datetime
import re  
import sys
import getopt
from IPython import embed 
import subprocess
import random
import os

KEYWORDS = ["pref", "uncertainty"]

def main(argv):
  device    = 10
  timeslot  = 25
  affix     = "1"
  
  try:
    opts, args = getopt.getopt(argv,"hd:t:",["device=","timeslot="])
  except getopt.GetoptError:
    print 'generator.py -d <device> -t <timeslot> -a <affix>'
    print 'affix is optional. Default 1. Purpose: discriminate generated folder'
    sys.exit(2)
  for opt, arg in opts:
    if opt == '-h':
      print 'generator.py -d <device> -t <timeslot> -a <affix>'
      sys.exit()
    elif opt in ("-d", "--divice"):
      device = int(arg) + 1
    elif opt in ("-o", "--ofile"):
      timeslot = int(arg) + 1
    elif opt in ("-a", "--affix"):
      affix = arg
  
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
  p = subprocess.Popen('./clingo1facts generator/price_energy_20_24.lp generator/cost.lp', cwd=parent, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
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
    for d in range(1,device):
      i1       = random.randint(1,timeslot-1)
      i2       = random.randint(i1+1,timeslot)
      interval = "(" + str(i1) + "," + str(i2) + ")"
      len_inte = i2-i1
      v1       = random.randint(1,len_inte)
      v2       = random.randint(v1,len_inte)
      bound    = "(" + str(v1) + "," + str(v2) + ")"
      
      f.write("init(object(device," + str(d) + "),constraint(on," + bound + "," + interval + ")).\n")
      
if __name__ == "__main__":
   main(sys.argv[1:])    