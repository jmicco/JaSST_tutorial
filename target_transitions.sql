#standardSQL
#
# Copyright 2017 Google, Inc.
# (Creative Commons Attribution 4.0 International Public License)
# See LICENSE.txt for details
#
# Finds the changes that caused transitions for targets
# This is designed to be used as input for the query showing that
# targets sharing histories are not likely to be flaky.
#
# NOTE: This result should be saved as the target_transitions table
#

WITH result_values AS (
  SELECT
    ROW_NUMBER() OVER (PARTITION BY target_id ORDER BY changelist) as row,
    target_id,
    changelist,
    result
  FROM `TestResultData.results`
  WHERE result IN ('PASSED', 'FAILED', 'FLAKY', 'SKIPPED')
  ORDER BY row
), transitions_by_cl as (
  SELECT
    A.changelist,
    A.target_id
  FROM result_values AS A
    LEFT OUTER JOIN result_values AS B
    ON A.target_id = B.target_id AND A.row = B.row-1
  WHERE A.result != B.result
  ORDER BY A.changelist, A.target_id
)
SELECT
  changelist,
  target_id
FROM transitions_by_cl
;
