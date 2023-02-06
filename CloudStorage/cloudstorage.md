# Cloud Storage
- Object Store: armazenar arquivos em formato bloco, garantir a redundancia e disponibilidade
- Data lake: built to destroy department silos and democratize the data inside the organization. Everybody now has a centralized data store for analytics and promise of machine learning
- Binary Objects, metadata and attributes
- Access via HTTP, APIs and REST
- use cases store videos, images, documents, websites, structured and unstructured data
- used in data engineer pipelines
- Global, Secure and Scalable Object Store
- HDFS-compatible System
- Desingned for structured and unstructured data
- Data democratization at scale
- Encrypted at rest

## Storage classes
- Standard: default, desingned for short-lived, frequently accessed data. 20$ per Tb
- Nearline: month, lower monthly storage cost for longer-lived and less frequently accessed data
- Coldline: quarter
- Archive: year
- Autoclass: 30d -> coldline, 90d Archive

## Location
- Region: fast, cheap, storage and processing at same place good for Analytics projects
- Multi-Region: redundancy,HA, serve data in different places with low latency
- Dual-Regions: HA, disaster recovery, good for production
- Turbo replication: replication every 15m

## Landing
- Receive ingestion
- json, csv, txt, parquet, ocr

## Processing
- Transforms
- parquet, delta

## Curated
- Business
- gold

### Batch pipeline
- Data Fusion: capture
- Cloud Storage: store
- Google DataProc: Process
- Google BigQuery: Analyze
