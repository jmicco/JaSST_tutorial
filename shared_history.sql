#standardSQL
#
# Copyright 2017 Google, Inc.
# (Creative Commons Attribution 4.0 International Public License)
# See LICENSE.txt for details
#
# Uses the target_transitions table to show the history for a target
# finds other targets that share the same history
# These targets are unlikely to be flaky.
#
# Orders the result by the amount of completely shared histories in the range.
#

WITH target_transition_set AS (
  SELECT
    target_id,
    ARRAY_AGG(CAST(changelist AS STRING)) AS changelists
  FROM `TestResultData100K.target_transitions`
  GROUP BY target_id
  ORDER BY target_id
)
SELECT
  count(*) AS shared_count,
  ARRAY_TO_STRING(ARRAY_AGG(CAST(target_id AS STRING)), ',') AS targets,
  ARRAY_TO_STRING(changelists, ',') AS changelists
FROM target_transition_set
GROUP BY changelists
HAVING shared_count > 1
ORDER BY shared_count DESC
;
