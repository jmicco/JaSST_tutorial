#standardSQL
#
# Copyright 2017 Google, Inc.
# (Creative Commons Attribution 4.0 International Public License)
# See LICENSE.txt for details
#
# This query counts the number of times a file with the given extension
# was committed in the public sample set.
#
SELECT
  IF(REGEXP_CONTAINS(filename, "\\.([^\\.]+)$"),
    REGEXP_EXTRACT(filename, "\\.([^\\.]+)$"),
    '<no extension>') AS extension,
    COUNT(*) AS count
FROM `TestResultDataFull.changed_files`
GROUP BY extension
ORDER BY count DESC
;
