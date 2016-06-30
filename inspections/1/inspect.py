# -*- coding: UTF-8 -*-
import sys as Sys
import csv
import json
import glob
import requests
from firebase import Firebase
from firebase_token_generator import create_token

auth_payload = {"uid": "ySsRm3jHsmfGcI1uf79ZIvGJvwx1"}
token = create_token("TDffFFSZK6P8MFJM4WZA0itwuil406XejqJ7nIl0", auth_payload)

fire = Firebase('https://eat-here-or-there.firebaseio.com/nyc/inspections', token)

fire.remove()
fieldnames = ['CAMIS', 'INSPECTION DATE', 'ACTION', 'VIOLATION CODE', 'VIOLATION DESCRIPTION', 'CRITICAL FLAG', 'SCORE', 'GRADE', 'GRADE DATE', 'RECORD DATE', 'INSPECTION TYPE']
# Print iterations progress
def printProgress (iteration, total, prefix = '', suffix = '', decimals = 2, barLength = 100):
    """
        Call in a loop to create terminal progress bar
        @params:
        iteration   - Required  : current iteration (Int)
        total       - Required  : total iterations (Int)
        prefix      - Optional  : prefix string (Str)
        suffix      - Optional  : suffix string (Str)
        decimals    - Optional  : number of decimals in percent complete (Int)
        barLength   - Optional  : character length of bar (Int)
        """
    filledLength    = int(round(barLength * iteration / float(total)))
    percents        = round(100.00 * (iteration / float(total)), decimals)
    bar             = '#' * filledLength + '-' * (barLength - filledLength)
    Sys.stdout.write('%s [%s] %s%s %s\r' % (prefix, bar, percents, '%', suffix)),
    Sys.stdout.flush()
    if iteration == total:
        print("\n")
def process(file):
    f = open(file, 'rU')
    reader = csv.DictReader(f, fieldnames=fieldnames)
    i = 0
    rows = list(reader)
    l = len(rows)
    for row in rows:
        id = row['CAMIS']
        inspect_loc = "https://eat-here-or-there.firebaseio.com/nyc/restaurants/{0}/inspections".format(id)

        fire_inspection = Firebase(inspect_loc, token)

        del row['CAMIS']
        try:
            fire_inspection.post(row)
        except (UnicodeDecodeError, requests.exceptions.ConnectionError) as e:
            print row
        i += 1
        printProgress(i, l, prefix = 'Progress:', suffix = 'Complete', barLength = 50)

for file in glob.glob("*.csv"):
    process(file)

print 'JSON uploaded'
