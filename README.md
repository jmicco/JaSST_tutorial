# JaSST 2018 tutorial lab

In order to participate in the hands-on potion of this tutorial, you will
need a laptop with internet access and a Google account.  A github
account and/or a place to sync the github repository is optional.

Raw data from our paper can be found
[here](https://drive.google.com/drive/folders/0B5_QHWCtac81VGNKYnhrQkJBZGM).

I pre-loaded the data using
[swizzle.py](https://github.com/jmicco/JaSST_tutorial/blob/master/swizzle.py)
into BigQuery for 10K and 100K samples and the full data set.  We will
be able to run some queries to reproduce the results from our paper!
You could upload the data yourself, but that will not be necessary
today.

Google has agreed to pay for the BigQuery costs associated with this
lab, you will need to send me your Google account information at:
[john.micco@gmail.com](mailto:john.micco@gmail.com) so that I can
authorize your account to view and query the data.

This repository contains the queries that we will be running using
[bigquery](https://bigquery.cloud.google.com/queries/mystic-berm-192720)

You could reproduce these repositories using the swizzle.py program
included in this repository.  I produced 10K and 100K samples simply
by using

```
head -10000 <datafile> > sample10k.csv
head -100000 <datafile> > sample100k.csv
```

All of the queries are in this github repository:

* [breaking_transitions.sql](https://github.com/jmicco/JaSST_tutorial/blob/master/breaking_transitions.sql)
  - Finds all of the transitions for non-flaky tests where they started
  failing.  This data can be used to then find which file extensions or
  users must frequently broke the build.

* [count_breaking_authors.sql](https://github.com/jmicco/JaSST_tutorial/blob/master/count_breaking_authors.sql)
  - This query counts the number of times an author committed a change
  that caused a test to fail in the dataset

* [count_breaking_extensions.sql](https://github.com/jmicco/JaSST_tutorial/blob/master/count_breaking_extensions.sql)
  - This query counts the number of times a file with the given
  extension was committed in a confirmed breaking change

* [count_commits_per_day.sql](https://github.com/jmicco/JaSST_tutorial/blob/master/count_commits_per_day.sql)
  - Returns the number of commits / day

* [count_extensions.sql](https://github.com/jmicco/JaSST_tutorial/blob/master/count_extensions.sql)
  - This query counts the number of times a file with the given
  extension was committed in a confirmed breaking change

* [count_points.sql](https://github.com/jmicco/JaSST_tutorial/blob/master/count_points.sql)
  - simply counts how many total P/F results are in the entire set

* [count_results.sql](https://github.com/jmicco/JaSST_tutorial/blob/master/count_results.sql)
  - Counts the number of each type of result in the set

* [count_transitioning_targets.sql](https://github.com/jmicco/JaSST_tutorial/blob/master/count_transitioning_targets.sql)
  - Simply uses the target_transitions table to count the number of
  distinct targets with transitions in the dataset.

* [count_transitions.sql](https://github.com/jmicco/JaSST_tutorial/blob/master/count_transitions.sql)
  - Counts the number of transitions for each target - high numbers of
  transitions / time period indicate tests that are flaky.  The
  results of this query are stored in the flaky_tests table.

* [shared_history.sql](https://github.com/jmicco/JaSST_tutorial/blob/master/shared_history.sql)
  - Shows the tests that transitioned at the same time during the
  month.  Tests sharing the history across the month likely are not
  flaky.  Depends on the target_transitions table.

* [target_transitions.sql](https://github.com/jmicco/JaSST_tutorial/blob/master/target_transitions.sql)
  - Finds all of the places where a transition occurred for all
  targets.  The results of this query were saved as the
  target_transitions table.

We will walk through running these queries and interpreting the
results in the lab.
