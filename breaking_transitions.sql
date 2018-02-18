#standardSQL
#
# Copyright 2017 Google, Inc.
# (Creative Commons Attribution 4.0 International Public License)
# See LICENSE.txt for details
#
# Finds all of the transitions for non-flaky tests where they started failing.
# This data can be used to then find which file extensions or users must frequently
# broke the build.
#
# NOTE: This result should be saved as the breaking_transitions table
#

SELECT
  A.changelist,
  A.target_id,
  B.result
FROM `TestResultData.target_transitions` AS A
  JOIN `TestResultData.results` AS B
    ON A.target_id = B.target_id AND A.changelist = B.changelist
WHERE A.target_id NOT IN (SELECT target_id FROM `TestResultData.flaky_tests`)
  AND B.result IN ('FAILED')
;
