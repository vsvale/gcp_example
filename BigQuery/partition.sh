# Ingestion time
bq query --destination_table mydataset.mytable --time_partitioning_type=DAY

# Time Column
bq mk --table --schema a:STRING, tm:TIMESTAMP --time_partitioning_field tm

# Integer column
bq mk --table --schema "customer_id:integer, value:integer" --range_partitioning=customer_id,0,100,10 my_dataset.my_table
