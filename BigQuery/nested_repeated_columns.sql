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