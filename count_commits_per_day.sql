#standardSQL
#
# Copyright 2017 Google, Inc.
# (Creative Commons Attribution 4.0 International Public License)
# See LICENSE.txt for details
#
# This query counts the number of commits per day from the commit data
#
SELECT FORMAT_TIMESTAMP("%Y-%m-%d", timestamp) AS day, COUNT(*) as count
FROM `TensorFlowCommits.commit_data`
GROUP BY day
ORDER BY day
;
