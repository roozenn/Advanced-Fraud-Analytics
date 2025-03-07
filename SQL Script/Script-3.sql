SELECT
    fpt.dpt_id,
    fpt.buyer_id,
    fpt.seller_id,
    fpt.transaction_amount,
    ts.avg_amount,
    ts.stddev_amount,
    -- Menentukan apakah transaksi dianggap anomali berdasarkan batas 2x deviasi standar
    CASE
        WHEN fpt.transaction_amount > ts.avg_amount + 2 * ts.stddev_amount THEN 'Anomaly'
        WHEN fpt.transaction_amount < ts.avg_amount - 2 * ts.stddev_amount THEN 'Anomaly'
        ELSE 'Normal'
    END AS transaction_status
FROM transactionTable fpt
JOIN (
    -- Subquery untuk menghitung rata-rata dan deviasi standar
    SELECT
        buyer_id,
        seller_id,
        AVG(transaction_amount) AS avg_amount,
        -- Jika STDDEV tidak didukung, kita bisa tentukan deviasi standar manual atau gunakan nilai tetap
        0 AS stddev_amount  -- Jika STDDEV tidak bisa digunakan, coba menggunakan nilai 0 atau tentukan batas manual.
    FROM transactionTable
    GROUP BY buyer_id, seller_id
) ts
    ON fpt.buyer_id = ts.buyer_id
    AND fpt.seller_id = ts.seller_id;
