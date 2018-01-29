#standardSQL
#
# Copyright 2017 Google, Inc.
# (Creative Commons Attribution 4.0 International Public License)
# See LICENSE.txt for details
#
# Counts the number of all result points in the result set.
#
SELECT COUNT(*) as result_count
FROM `TestResultData.results`;
