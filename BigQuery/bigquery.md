# BigQuery
- Serveless
- Free Tier: 1TB query mês
- Snapshot
- Autobackup
- TimeTravel
- BigQuery is Google's fully managed, NoOps, low cost analytics database. With BigQuery you can query terabytes and terabytes of data without having any infrastructure to manage or needing a database administrator. BigQuery uses SQL and can take advantage of the pay-as-you-go model. BigQuery allows you to focus on analyzing data to find meaningful insights.

## Batch load
- CSV, JSON, AVRO, DATASTORE_BACKUP, PARQUET, ORC, GZIP
- Load compress files is not fast as uncompressed files
- AVRO auto detect schema, CSV and JSON best verify auto infer
- Automate setting up Cloud Functions to listen to a Cloud Storage event that is associated with new files arriving in a given bucket and launch a BigQuery load job

## [Nested and repeated fields](https://cloud.google.com/bigquery/docs/nested-repeated)
- Nested array fields and STRUCT fields allow for differing data granularity in the same table
![nestedandstruct.png](/imgs/nestedandstruct.png)
- BQ nested and repeated columns allow you to achieve the performance benefits of denormalization while retaining the structure of the data.
- keep a dimension table smaller than 10 GB normalized, unless the table rarely goes through UPDATE and DELETE operation
- Denormalize a dimension table larger than 10 GB, unless data manipulation or costs outweigh benefits of optimal queries
- Data in an array [ ] must all be the same type
- The easiest way to think about a STRUCT is to consider it conceptually like a separate table that is already pre-joined into your main table.

## Python BigQuery
[Python Client for Google BigQuery](https://github.com/googleapis/python-bigquery)