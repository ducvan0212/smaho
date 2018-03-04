import clingo
import datetime
import re  
import sys
import getopt
from IPython import embed 
import subprocess
import random

KEYWORDS = ["pref", "cost", "uncertainty"]

def main(argv):
  device = 10
  timeslot = 25
  try:
    opts, args = getopt.getopt(argv,"hd:t:",["device=","timeslot="])
  except getopt.GetoptError:
    print 'generator.py -d <device> -t <timeslot>'
    sys.exit(2)
  for opt, arg in opts:
    if opt == '-h':
      print 'generator.py -d <device> -t <timeslot>'
      sys.exit()
    elif opt in ("-d", "--divice"):
      device = int(arg) + 1
    elif opt in ("-o", "--ofile"):
      timeslot = int(arg) + 1
      
  with open("examples/" + str(device-1) + "_" + str(timeslot-1) + ".lp","w") as the_file:
    for d in range(1,device):
      for t in range(1,timeslot):
        for k in KEYWORDS:
          value = random.randint(1,10)
          the_file.write("init(object(device," + str(d) + ")," + k + "(at,(" + str(value) + "," + str(t) + "))).\n")
  
if __name__ == "__main__":
   main(sys.argv[1:])    