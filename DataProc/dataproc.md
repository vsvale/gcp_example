## Dataproc Autoscaling
- Not for idle cluster or scale to zero
- Autoscaling is based on Hadoop YARN metrics
- Not for Spark Structured Streaming

## Commands
- SUBMIT: `gcloud dataproc jobs submit pyspark 'gs://script.py' --cluster=sparkcluster --region='us-central1'`
- SERVELESS: `gcloud dataproc batches submit pyspark 'gs://script.py' --batch=batch-id-unique-name-it --deps-bucket=gs://repository --region='us-central1'`