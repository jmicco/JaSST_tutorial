#standardSQL
#
# Copyright 2017 Google, Inc.
# (Creative Commons Attribution 4.0 International Public License)
# See LICENSE.txt for details
#
# Simply uses the target_transitions table to count the number
# of distinct targets with transitions in the dataset.
#

SELECT COUNT(DISTINCT(target_id)) AS transitioning_targets
FROM `TestResultData100K.target_transitions`
;
