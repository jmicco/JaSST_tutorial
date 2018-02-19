# Copyright 2017 Google, Inc.
# (Creative Commons Attribution 4.0 International Public License)
# See LICENSE.txt for details

import csv
import sys

args = sys.argv
args.pop(0);
if len(args) != 1:
  raise 'Specify the input data file as an argument only'

# Takes as input the commitData.csv file from the
# data set from:
# https://drive.google.com/drive/folders/0B5_QHWCtac81VGNKYnhrQkJBZGM
# It uses the changlist number each commit and separates
# the commits from the filelist and associates them with the changelist number
# as primary key.
# The resulting files can be uploaded to BigQuery.
# When uploading to BigQuery, the schema for the commit_data table is:
#
# [
#    {
#        "mode": "REQUIRED",
#        "name": "changelist",
#        "type": "INTEGER"
#    },
#    {
#        "mode": "REQUIRED",
#        "name": "author",
#        "type": "STRING"
#    },
#    {
#        "mode": "REQUIRED",
#        "name": "timestamp",
#        "type": "INTEGER"
#    }
# ]
#
# The schema for the changed_files is:
#
#
# [
#    {
#        "mode": "REQUIRED",
#        "name": "changelist",
#        "type": "INTEGER"
#    },
#    {
#        "mode": "REQUIRED",
#        "name": "path",
#        "type": "STRING"
#    },
#    {
#        "mode": "REQUIRED",
#        "name": "filename",
#        "type": "STRING"
#    }
#]

with open(args[0]) as csvfile:
  with open('commit_data.csv', 'w') as target_table:
    with open('changed_files.csv', 'w') as result_table:
      readCSV = csv.reader(csvfile, delimiter=',')
      commitCSV = csv.writer(target_table, delimiter=',')
      filesCSV = csv.writer(result_table, delimiter=',')
      for row in readCSV:
        changelist = row.pop(0);
        author = row.pop(0);
        timestamp = row.pop(0);
        commitCSV.writerow([changelist, author, timestamp])
        for result in row:
          resultTuple = result.split(':',3)
          if len(resultTuple) == 2 and resultTuple[1]:
            filesCSV.writerow([changelist]+resultTuple)
