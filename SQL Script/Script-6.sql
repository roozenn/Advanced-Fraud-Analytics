WITH promotion_usage AS (
    SELECT
        t.buyer_id,
        t.dpt_promotion_id,
        t.transaction_created_datetime,
        LAG(t.transaction_created_datetime) OVER (PARTITION BY t.buyer_id, t.dpt_promotion_id ORDER BY t.transaction_created_datetime) AS previous_transaction_datetime
    FROM transaction_v2 t
    WHERE t.dpt_promotion_id IS NOT NULL
)
SELECT 
    buyer_id,
    dpt_promotion_id,
    transaction_created_datetime,
    previous_transaction_datetime,
    julianday(transaction_created_datetime) - julianday(previous_transaction_datetime) AS time_diff
FROM promotion_usage
WHERE previous_transaction_datetime IS NOT NULL
AND (julianday(transaction_created_datetime) - julianday(previous_transaction_datetime)) < 0.0001  -- Selisih waktu kurang dari 1 hari
ORDER BY buyer_id, dpt_promotion_id, transaction_created_datetime;
