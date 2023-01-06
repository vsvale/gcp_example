-- Join Slow
SELECT 
  block_id, 
  MAX(i.input_sequence_number) AS max_seq_number,
  COUNT(t.transaction_id) as num_transactions_in_block
FROM `cloud-training-demos.bitcoin_blockchain.blocks` AS b
  -- Join on the separate table which stores transaction info
  JOIN `cloud-training-demos.bitcoin_blockchain.transactions` AS t USING(block_id)
  , t.inputs as i 
GROUP BY block_id;

-- Faster using nested and repeated fields
SELECT 
  block_id, 
  MAX(i.input_sequence_number) AS max_seq_number,
  COUNT(t.transaction_id) as num_transactions_in_block
FROM `cloud-training-demos.bitcoin_blockchain.blocks` AS b
  -- Use the nested STRUCT within BLOCKS table for transactions instead of a separate JOIN
  , b.transactions AS t
  , t.inputs as i
GROUP BY block_id;

-- Use UNNEST() When you need to break apart ARRAY values for analysis. Here the transactions.outputs.output_satoshis field is an array that needs to be unnested before we can analyze it:
SELECT DISTINCT
  block_id, 
  TIMESTAMP_MILLIS(timestamp) AS timestamp,
  t.transaction_id,
  t_outputs.output_satoshis AS satoshi_value,
  t_outputs.output_satoshis * 0.00000001 AS btc_value
FROM `cloud-training-demos.bitcoin_blockchain.blocks` AS b
  , b.transactions AS t 
  , t.inputs as i
  , UNNEST(t.outputs) AS t_outputs
ORDER BY btc_value DESC
LIMIT 10;

-- Creating your own arrays with ARRAY_AGG()
SELECT
  fullVisitorId,
  date,
  ARRAY_AGG(v2ProductName) AS products_viewed,
  --ARRAY_LENGTH() function to count
  ARRAY_LENGTH(ARRAY_AGG(DISTINCT v2ProductName)) AS distinct_products_viewed,
  ARRAY_AGG(pageTitle) AS pages_viewed,
  -- DISTINCT COUNT
  ARRAY_LENGTH(ARRAY_AGG(DISTINCT pageTitle)) AS distinct_pages_viewed
  FROM `data-to-insights.ecommerce.all_sessions`
WHERE visitId = 1501570398
GROUP BY fullVisitorId, date
ORDER BY date

-- SCTRUC and ARRAY
SELECT STRUCT("Rudisha" as name, [23.4, 26.3, 26.4, 26.1] as splits) AS runner

-- return a field nested in struct
SELECT race, participants.name
FROM racing.race_results AS r, r.participants

-- count in struct
SELECT COUNT(p.name) AS racer_count
FROM racing.race_results AS r, UNNEST(r.participants) AS p

-- filter struct
#standardSQL
SELECT
  p.name,
  SUM(split_times) as total_race_time
FROM racing.race_results AS r
, UNNEST(r.participants) AS p
, UNNEST(p.splits) AS split_times
WHERE p.name LIKE 'R%'
GROUP BY p.name
ORDER BY total_race_time ASC;