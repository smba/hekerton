import pandas as pd
import os
import re

pwd = os.getcwd()

def split_on_empty_lines(s):

    # greedily match 2 or more new-lines
    blank_line_regex = r"(?:\r?\n){2,}"

    return re.split(blank_line_regex, s.strip())

with open('cov.txt') as file:
    txt = file.read()

ss = split_on_empty_lines(txt)


for s in ss:
    path = s.split('\n')[0][len(pwd)+1:-1]
    print(path)

    for line in s.split('\n'):
        splitted = line[:20].split('|')
        splitted = list(map(str.strip, splitted))
        if len(splitted) >= 2:
            try:
                lino = int(splitted[0])
            except ValueError:
                lino = None
            try:
                hits = int(splitted[1])
            except ValueError:
                hits = 0

            if hits > 0:
                print(f"{path}, {lino}, {hits}")
        else:
            continue
