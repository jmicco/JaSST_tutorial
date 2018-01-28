import csv
import sys

args = sys.argv
args.pop(0);
if len(args) != 1:
  raise 'Specify the input data file as an argument only'

# Takes as input the testTargetsResults.csv file from the
# data set from:
# https://drive.google.com/drive/folders/0B5_QHWCtac81VGNKYnhrQkJBZGM
# It creates a primary key (with a counter) for each test and separates
# the targets from the results and associates them with the target primary
# key.
# The results can be uploaded to BigQuery.
# The entire data set is very large and difficult to experiment with,
# so I recommend using only a sample.
# I created a 10000 target sample and a 100000 target sample
# simply by doing head -10000 testTargetsResults.csv > sample10000.csv
# and then processing that.
# When uploading to BigQuery, the schema for the target_table is:
#
# [
#    {
#        "mode": "REQUIRED",
#        "name": "id",
#        "type": "INTEGER"
#    },
#    {
#        "mode": "REQUIRED",
#        "name": "target",
#        "type": "STRING"
#    },
#    {
#        "mode": "REQUIRED",
#        "name": "flags",
#        "type": "STRING"
#    }
# ]
#
# The schema for the result_table is:
#
#
# [
#    {
#        "mode": "REQUIRED",
#        "name": "target_id",
#        "type": "INTEGER"
#    },
#    {
#        "mode": "REQUIRED",
#        "name": "changelist",
#        "type": "INTEGER"
#    },
#    {
#        "mode": "REQUIRED",
#        "name": "result",
#        "type": "STRING"
#    },
#    {
#        "mode": "REQUIRED",
#        "name": "timestamp",
#        "type": "TIMESTAMP"
#    }
#]

pk = 1;
with open(args[0]) as csvfile:
  with open('target_table.csv', 'w') as target_table:
    with open('result_table.csv', 'w') as result_table:
      readCSV = csv.reader(csvfile, delimiter=',')
      targetCSV = csv.writer(target_table, delimiter=',')
      resultCSV = csv.writer(result_table, delimiter=',')
      for row in readCSV:
        targetFlags = row.pop(0).split('^', 2)
        targetCSV.writerow([pk] + targetFlags)
        for result in set(row):
          resultTuple = result.split('-',3)
          if len(resultTuple) == 3:
            resultCSV.writerow([pk]+resultTuple)
        pk = pk +1
