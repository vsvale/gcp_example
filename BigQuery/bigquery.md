#BigQuery

## Batch load
- CSV, JSON, AVRO, DATASTORE_BACKUP, PARQUET, ORC, GZIP
- Load compress files is not fast as uncompressed files
- AVRO auto detect schema, CSV and JSON best verify auto infer
- Automate setting up Cloud Functions to listen to a Cloud Storage event that is associated with new files arriving in a given bucket and launch a BigQuery load job