#standardSQL
#
# Copyright 2017 Google, Inc.
# (Creative Commons Attribution 4.0 International Public License)
# See LICENSE.txt for details
#
# This query counts the number of times an author committed a change
# that caused a test to fail in the dataset
#
SELECT
  author,
  COUNT(*) AS count
from `TestResultDataFull.commit_data`
WHERE changelist IN (
  SELECT changelist
  FROM `TestResultDataFull.breaking_transitions`
  GROUP BY changelist)
GROUP BY author
ORDER BY count DESC
;
