#!/usr/bin/env python3

import time
import os
import sys

if len(sys.argv) != 2:
    print("Usage: " + sys.argv[0] + " <filename>")
    sys.exit(1)

os.system('stty -F /dev/ttyACM0 raw -echo 115200')
fin = open(sys.argv[1], "r")
fout = open("/dev/ttyACM0", "w")

for line in fin:
    for ch in line.strip('\n'):
        fout.write(ch)
        fout.flush()
        time.sleep(.1)
    fout.write('\r')
    fout.flush()
    time.sleep(.5)
fin.close()
fout.close()






