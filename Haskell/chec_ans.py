#!/usr/bin/python3.4

# ./chec_ans.py
# ./chec_ans.py 01   <- runs 01.hs




import subprocess
import os
import re
import hashlib
import time as timer
import sys






with open('answers.txt') as f:
    ans = dict(re.findall('(.*), (.*)', f.read()))

fmatch = re.compile('^(\d+).*\.hs$')
    
i = t = 0
files = sorted([ (f, str(int(fmatch.match(f).group(1)))) for f in os.listdir() if fmatch.match(f) != None ])

if len(sys.argv) > 1:
    f = [ x for x in files if sys.argv[1] in x ][0]
    files = [f]

def run(f):
    start_time=timer.time()
    proc = subprocess.Popen(['runhaskell',f],stdout=subprocess.PIPE)
    proc.wait()
    res = proc.stdout.read().strip().decode('utf-8')
    return res, timer.time()-start_time


for (f,num) in files:
    try:
        res, time = run(f)
    except KeyboardInterrupt:
        print(f + '  TOO SLOW TO FUNCTION\n')
        continue
    
    slow = "SLOW" if time > 10 else "FAST"
    md5 = hashlib.md5(res.encode('utf-8')).hexdigest()
    if ans[num] == md5:
        print('PASSED {}  {}'.format(slow,f))
        i += 1
    else:
        print('FAILED {}  {}'.format(slow,f))
    t += 1

print( 'Scored {}/{}'.format(str(i),str(t)) )



