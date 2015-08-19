#!/usr/bin/python3.4

# ./chec_ans.py
# ./chec_ans.py 01   <- runs 01.hs


import hashlib
import os
import re
import subprocess
import sys
import time as timer


""" the answers """
with open('answers.txt') as f:
    ans = dict(re.findall('(.*), (.*)', f.read()))
""" the answers """


""" select files to run """
def grab(f):
    x = fmatch.match(f)
    if x: return x.group(1)
    else: return None

fmatch    = re.compile('^0*(\d+).*\.hs$')
directory = os.listdir()  
files     = sorted(filter(all, zip(directory, map(grab, directory))))

if len(sys.argv) > 1:
    # just one
    f = [ x for x in files if sys.argv[1] in x ][0]
    files = [f]
""" end select files to run """

    
""" system call to get the result (plus the time taken) """
def run(f):

    # Compile
    start_time = timer.time()
    proc = subprocess.Popen(['ghc', '-O2', f], stdout=subprocess.PIPE)
    proc.wait()
    compiled_in = timer.time()-start_time

    # Run
    start_time=timer.time()
    proc = subprocess.Popen(['./' + f[:-3]], stdout=subprocess.PIPE)
    proc.wait()

    # return
    res = proc.stdout.read().strip().decode('utf-8')
    return res, timer.time()-start_time, compiled_in


passed = total = 0
for (f,num) in files:
    # might throw in a ^C if it takes too long ...
    try:
        res, time, compiled = run(f)
        
    except KeyboardInterrupt:
        print(f + '  TOO SLOW TO FUNCTION\n')
        continue
    
    except:
        print('failed to compile?')
        continue

    md5 = hashlib.md5(res.encode('utf-8')).hexdigest()
    
    if ans[num] == md5:
        print('PASSED %s  ran in %f  compiled in %f' % (f, time, compiled))
        print()
        passed += 1

    else:
        print('FAILED %s  ran in %f  compiled in %s' % (f, time, compiled))
        print()
        
    total += 1

        
print('Scored {}/{}'.format(passed, total))

# clean up
for f in os.listdir('.'):
    if not any(x in f for x in ['.hs', '.txt', '.py']):
        os.remove(f)
