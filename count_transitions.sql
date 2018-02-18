#standardSQL
#
# Copyright 2017 Google, Inc.
# (Creative Commons Attribution 4.0 International Public License)
# See LICENSE.txt for details

# Finds all tests that are probably flaky, having more than 2
# transitions in a 1 month period.  NOTE: This may need to be tuned to
# match your particular situation or data.
#
# Simply sort the result by timestamp of the commit or something that
# tracks your branch, generate ROW_NUMBER(), and then join back against itself
# to find the transitions.
#
# This query simply sorts by the number of state changes of the target
# results.  Find a line that shows which tests are flaky,  this query
# excludes any target where there have not been at least 5 transitions.
#
# Only include results of PASSED, FAILED, FLAKY and SKIPPED.  In our system
# other results indicate problems running the tests or tests that we never ran
#
# NOTE: This result should be saved as the "flaky_tests" table
#

WITH result_values AS (
  SELECT
    ROW_NUMBER() OVER (PARTITION BY target_id ORDER BY changelist) AS row,
    target_id,
    changelist,
    result
  FROM `TestResultData.results`
  WHERE result IN ('PASSED', 'FAILED', 'FLAKY', 'SKIPPED')
)
SELECT
  A.target_id,
  count(*) AS transition_count
FROM result_values AS A
  LEFT OUTER JOIN result_values AS B
  ON A.target_id = B.target_id AND A.row = B.row-1
WHERE A.result != B.result
GROUP BY A.target_id
HAVING transition_count > 4 #  <= Tune this based on your data set
ORDER BY transition_count desc, A.target_id
;
