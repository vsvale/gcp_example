-- partition can improve query cost and performance
SELECT
field
from mydataset.table
where
_PARTITIONTIME > TIMESTAMP_SUB(TIMESTAMP('2016-04-15'),INTERVAL 5 DAY)

-- cluster
CREATE TABLE mydataset.myclusteredtable(
    c1 NUMERIC,
    userID STRING,
    c3 STRING,
    eventDate TIMESTAMP,
    c5 GEOGRAPHY
)
PARTITION BY DATE(eventDate)
CLUSTER BY userID
OPTIONS(
    partition_expiration_days=3,
    description="cluster"
)
AS SELECT * FROM mydataset.mothertable