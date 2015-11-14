#!/usr/bin/python

import sys

print 'Color table:'

for i in range(256):
   sys.stdout.write('\033[38;5;%dm %3d: color test   ' % (i, i))

   if ((i + 1) % 8) == 0:
      sys.stdout.write('\n')

sys.stdout.write('\n')

unicodeRanges = {
   'General punctuation': (0x2000, 0x2069),
   'Block': (0x2580, 0x259f),
   'Misc': (0x2600, 0x26ff),
   'Musical symbols': (0x1d100, 0x1d1dd),
   'Emoticons': (0x1f600, 0x1f64f),
}

NBSP = unichr(0x00a0)

for (desc, (first, last)) in sorted(unicodeRanges.items(), key=lambda (d, (f, l)): f):
   print '\nUnicode table (%s):' % desc

   for i in range(first, last+1):
      sys.stdout.write(('0x%4x: %s' % (i, unichr(i) + NBSP + NBSP)).encode('utf-8'))

      if ((i + 1) % 16) == 0:
         sys.stdout.write('\n')

   if ((i + 1) % 16) != 0:
      sys.stdout.write('\n')

