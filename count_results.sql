#standardSQL
#
# Copyright 2017 Google, Inc.
# (Creative Commons Attribution 4.0 International Public License)
# See LICENSE.txt for details
#
# Counts the number of each result appearing in the result data.
# Shows how many failures you are seeing when running tests
#

SELECT
  result,
  COUNT(*) AS count,
  FORMAT('%04.2f%%', COUNT(*) * 100.0 / (SELECT COUNT(*) FROM TestResultData.results WHERE result != 'AFFECTED_TARGET')) AS percentage
FROM `TestResultData.results`
WHERE result != 'AFFECTED_TARGET'
GROUP BY result
ORDER BY count DESC;
