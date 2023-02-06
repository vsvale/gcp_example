# Pub/Sub
- Pub & Sub application are made to consume mesages at low latency, and the core idea is to write and read a single message fast as possible, an abstraction similar to a table inside a database
- At Least Once: At least once delivery guarantee is when we send the message, the broker receives and store in the partition leader, but doesn't send a confirmation that all replicas receive and store the message. In this case, we can have duplicates.
- Messagind & Event Ingestion for real-time
- Serveless, autoscale and auto-provisions
- Publish and Subscribe Events
- Push delivery model
- Async calls with decouled Architecture
- used for communication between services & Integration

## One-to-many
- Fan-out
- one topic many subscribers

## Many-to-one
- Fan-in
- many topics one subscriber

## many-tomany
- many publishers to  a topic with many subscribers
- Load balacing mode

## Subscription Workflow
1. After a message is sent to a subscriber, the subscriber must acknowledge the message
2. if a message is sent out for delivery and a subscriber is yet to acknowledge it, the message is called outstanding
3. Pub/Sub repeatedly attempts to deliver any message that is not yet acknowledge. However, Pub/Sub tries not to deliver an outstanding message to any other subscriber on the same subscription
4. The subscriber has a configurable, limited amount of time, know as ackDeadline, to acknowledge the outstanding messsage. After the deadline passess, the message is no longer considered outstanding and Pub/Sub attempts to redeliver the message
- By default, subscriptions expire after 31 days of subscriber inactivity
- The deafult message retention duration is 7 days
- By default, a Pub/Sub topic discards messages as soon as they are acknowledged by all subscription attached to topic

## Type of Message delivery
- Pull: Desingned for large volumes. Efficiency and Throughput. client initiates requests to a Pub & Sub server to retrieve messages
- Push: Pub & Sub initiates a request to your subscriber client to deliver messages. Multiple topics same webhook. App Engine or cloud functions
- BigQuery: Messages do not require additional processing before storing them in a BigQuery table. Large Volume to scale up Quickly. Any Additional Message Processing

## Key Features
- Partition-Less In-Order Delivery: if messages have the same ordering key and are in the same region, you can enable message ordering and receive the messages in the order that the Pub/Sub service receives them
- Dead Letter Topics: if the Pub/Sub service attempts to deliver a message but the subscriber can't acknowledge it, Pub/Sub can foward the undeliverable message to a dead-letter topic to attempt delivery at a later time
- Seek & Replay: There could be times when you need to alter the acknowledgment stage of messages in bulk; the seek and replay feature allows you to do that
- Filtering: you can filter messages by message attributes, and when you receive messages from a subscriptiion with a filter, you only receive the messages that match the filter. Pub//Sub automatically acknowledges the messages that don't match the filter