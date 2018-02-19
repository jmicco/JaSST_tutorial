# Copyright 2017 Google, Inc.
# (Creative Commons Attribution 4.0 International Public License)
# See LICENSE.txt for details

import csv
import sys
import os

args = sys.argv
args.pop(0);
if len(args) != 0:
  raise Exception('Please use: git log --date=format:\'%Y-%m-%d %T\' --name-only --pretty=format:\'%H,%an,%cd\' | python extract_git_commits.py')

# Takes as input the the streaming output from git log:
# git log --date=format:\'%Y-%m-%d %T\' --name-only --pretty=format:\'%H,%an,%cd\'
#
# and will produce a similar format to the commit data that we experimented with in
# the tutorial
#
# The resulting files can be uploaded to BigQuery.
# When uploading to BigQuery, the schema for the commit_data table is:
#
# [
#    {
#        "mode": "REQUIRED",
#        "name": "commit",
#        "type": "STRING"
#    },
#    {
#        "mode": "REQUIRED",
#        "name": "author",
#        "type": "STRING"
#    },
#    {
#        "mode": "REQUIRED",
#        "name": "timestamp",
#        "type": "TIMESTAMP"
#    }
# ]
#
# The schema for the changed_files is:
#
#
# [
#    {
#        "mode": "REQUIRED",
#        "name": "commit",
#        "type": "STRING"
#    },
#    {
#        "mode": "NULLABLE",
#        "name": "path",
#        "type": "STRING"
#    },
#    {
#        "mode": "REQUIRED",
#        "name": "filename",
#        "type": "STRING"
#    }
#]

csv.register_dialect('gitcommits', doublequote=False, escapechar='\\')

readCSV = csv.reader(sys.stdin, dialect='gitcommits')
commit=None

with open('commit_data.csv', 'w') as commit_table:
  with open('changed_files.csv', 'w') as files_table:
    commitCSV = csv.writer(commit_table, delimiter=',')
    filesCSV = csv.writer(files_table, delimiter=',')
    for row in readCSV:
      if len(row) == 3:
        commit = row
        commitCSV.writerow(row)
        files = []
      elif commit is not None and len(row) == 1:
        filesCSV.writerow([commit[0], os.path.dirname(row[0]), os.path.basename(row[0])])
