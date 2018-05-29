# Utilities for parsing and annotating dis10's output.
# Adam Sampson <ats@offog.org>

import re
import subprocess

# Define B4_9 = 35 ... B1_1 = 0.
for w in range(1, 5):
    for b in range(1, 10):
        globals()["B%d_%d" % (w, b)] = ((w - 1) * 9) + b - 1

SQUOZE = " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ.$%"

class Word:
    def __init__(self, addr, value, lines):
        self.addr = addr
        self.value = value
        self.lines = lines

    def bits(self, left=35, right=None):
        if right is None:
            right = left
        return (self.value >> right) & ((1L << (1 + left - right)) - 1)

    def sbits(self, left=35, right=None):
        if right is None:
            right = left
        val = self.bits(left, right)
        topbit = 1 << (left - right)
        if (val & topbit) != 0:
            return val - (topbit << 1)
        return val

    def squoze(self):
        s = ""
        v = self.value & ((1L << 32) - 1)
        for i in range(6):
            s = SQUOZE[v % 40] + s
            v /= 40
        return (self.value >> 32), s.rstrip()

    def show(self, *fields):
        print "%06o:  %012o  %s" % (self.addr, self.value,
                                    "".join(str(f) for f in fields))

    def dis(self, tag=None):
        for i, l in enumerate(self.lines):
            if i == 0 and tag is not None:
                print (l + (" " * 70))[:70] + "(" + tag + ")"
            else:
                print l

dummy_word = Word(0, 0, [])

def note(*fields):
    print "                       %s" % ("".join(str(f) for f in fields))

# Each dis10 output line looks like:
# 010503:  515350530000  hrlzi    7, 530000(10)   ;"IKHK  " "S.E0\0"
# There may be continuation lines for complex instructions.
word_re = re.compile(r'^([0-7]+):\s+([0-7]+)(\s+.*)?$')

def read_file(args):
    """Read an input file using dis10, and yield a Word for each word."""

    p = subprocess.Popen(["dis10", "-r"] + args, stdout=subprocess.PIPE)
    f = p.stdout

    # Discard lines until we see the first address.
    while True:
        l = f.readline()
        if l == "":
            # No data. Input must be empty.
            p.wait()
            return

        l = l.rstrip()
        m = word_re.match(l)
        if m is not None:
            break

    # Read the set of lines for each input word.
    lines = []
    while True:
        lines.append(l)
        addr = int(m.group(1), 8)
        value = int(m.group(2), 8)

        while True:
            l = f.readline()
            if l == "":
                # End of input.
                yield Word(addr, value, lines)
                return

            l = l.rstrip()
            m = word_re.match(l)
            if m is not None:
                break

        yield Word(addr, value, lines)
        lines = []

    p.wait()
