### define
with beam.Pipeline(options=pipeline_options) as p: 

### read from cloud Storage
lines = p | beam.io.ReadFromText("gs://.../input-*.csv.gz")

### read from Pub/Sub
lines = p | beam.io.ReadFromPubSub("topic=know_args.input_topic")

### read from BigQuery
query = "SELECT * FROM project.dataset.tablename"
BQ_SOURCE = beam.io.BigQuerySource(query=<query>,use_standard_sql=True)
BQ_data = pipeline | beam.io.Read(BQ_SOURCE)

### write to BigQuery (overwrite|create if not exists)
from apache_beam.io.gcp.internal.clients import bigquery

table_spec = bigquery.TableReference(
    projectId='clouddataflow-readonly',
    datasetId='samples',
    tableId='weather_stations'
)

p | beam.io.WriteToBigQuery(
    tablespec,
    schema=table_schema,
    write_disposition=beam.io.BigQueryDisposition.WRITE_TRUNCATE,
    create_disposition=beam.io.BigQueryDisposition.CREATE_IF_NEEDED
)

### Transform
#### Map
