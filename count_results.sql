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
  count(*) AS count
FROM `TestResultData.results`
GROUP BY result
ORDER BY count DESC;
