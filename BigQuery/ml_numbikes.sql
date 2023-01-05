-- Create a model with SQL statement
CREATE OR REPLACE MODEL numbikes.MODEL
OPTIONS
(
    model_type='linear_reg',
    input_label_cols='num_trips',
    ls_init_learn_rate-.15,
    l1_reg=1,
    max_iterations=5
) AS
WITH bike_data AS (
    SELECT
    COUNT(*) as num_trips
)

-- inspect what a model learned with ML.WEIGHTS
-- Near 0 feature is less important to the prediction. Near 1 or -1 is better
SELECT
    category,
    weight
FROM
    UNNEST((
        SELECT
            category_weights
        FROM
            ML.WEIGHTS(MODEL `bracketology.ncaa_model`)
        WHERE
            processed_input='seed'
    ))
like 'school_ncaa'
ORDER BY weight DESC

-- Evaluate the model
SELECT * FROM ML.EVALUATE(MODEL `bracketology.ncaa_model`)

-- Write a SQL prediction query and invoke ml.predict
SELECT
predicted_num_trips, num_trips, trip_data
FROM
ml.PREDICT(
    MODEL `numbikes.model`,
    (WITH bike_data AS
        (SELECT COUNT(*) as num_trips)
    )
    )

CREATE OR REPLACE TABLE `bracketology.predictions` AS (
    SELECT * FROM ML.PREDICT(MODEL `bracketology.ncaa_model`, (SELECT * FROM `data-to-insights.ncaa.2018_tournament_results`))
)