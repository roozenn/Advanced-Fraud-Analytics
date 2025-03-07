SELECT 
    t.dpt_id,
    t.buyer_id,
    t.seller_id,
    t.transaction_amount,
    -- Menghitung Q1 (25th percentile) dan Q3 (75th percentile) secara manual
    (SELECT transaction_amount
     FROM transactionTable t1
     WHERE t1.buyer_id = t.buyer_id AND t1.seller_id = t.seller_id
     ORDER BY transaction_amount
     LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) / 4)) AS Q1,
     
    (SELECT transaction_amount
     FROM transactionTable t2
     WHERE t2.buyer_id = t.buyer_id AND t2.seller_id = t.seller_id
     ORDER BY transaction_amount
     LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) * 3 / 4)) AS Q3,
    
    -- Menghitung IQR (Interquartile Range)
    (SELECT 
        (SELECT transaction_amount
         FROM transactionTable t3
         WHERE t3.buyer_id = t.buyer_id AND t3.seller_id = t.seller_id
         ORDER BY transaction_amount
         LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) * 3 / 4)) -
        (SELECT transaction_amount
         FROM transactionTable t4
         WHERE t4.buyer_id = t.buyer_id AND t4.seller_id = t.seller_id
         ORDER BY transaction_amount
         LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) / 4)) AS IQR
    ) AS IQR,
    
    -- Batas bawah dan atas untuk deteksi anomali
    (SELECT transaction_amount
     FROM transactionTable t5
     WHERE t5.buyer_id = t.buyer_id AND t5.seller_id = t.seller_id
     ORDER BY transaction_amount
     LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) / 4)) - 1.5 * 
     (SELECT 
        (SELECT transaction_amount
         FROM transactionTable t6
         WHERE t6.buyer_id = t.buyer_id AND t6.seller_id = t.seller_id
         ORDER BY transaction_amount
         LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) * 3 / 4)) -
        (SELECT transaction_amount
         FROM transactionTable t7
         WHERE t7.buyer_id = t.buyer_id AND t7.seller_id = t.seller_id
         ORDER BY transaction_amount
         LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) / 4)) AS IQR
    ) AS Lower_Bound,

    (SELECT transaction_amount
     FROM transactionTable t8
     WHERE t8.buyer_id = t.buyer_id AND t8.seller_id = t.seller_id
     ORDER BY transaction_amount
     LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) * 3 / 4)) + 1.5 * 
     (SELECT 
        (SELECT transaction_amount
         FROM transactionTable t9
         WHERE t9.buyer_id = t.buyer_id AND t9.seller_id = t.seller_id
         ORDER BY transaction_amount
         LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) * 3 / 4)) -
        (SELECT transaction_amount
         FROM transactionTable t10
         WHERE t10.buyer_id = t.buyer_id AND t10.seller_id = t.seller_id
         ORDER BY transaction_amount
         LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) / 4)) AS IQR
    ) AS Upper_Bound
    
FROM 
    transactionTable t
WHERE 
    t.transaction_amount < (SELECT transaction_amount
                             FROM transactionTable t11
                             WHERE t11.buyer_id = t.buyer_id AND t11.seller_id = t.seller_id
                             ORDER BY transaction_amount
                             LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) / 4)) - 1.5 * 
                             (SELECT 
                                (SELECT transaction_amount
                                 FROM transactionTable t12
                                 WHERE t12.buyer_id = t.buyer_id AND t12.seller_id = t.seller_id
                                 ORDER BY transaction_amount
                                 LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) * 3 / 4)) -
                                (SELECT transaction_amount
                                 FROM transactionTable t13
                                 WHERE t13.buyer_id = t.buyer_id AND t13.seller_id = t.seller_id
                                 ORDER BY transaction_amount
                                 LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) / 4)) AS IQR
                             )
    OR 
    t.transaction_amount > (SELECT transaction_amount
                            FROM transactionTable t14
                            WHERE t14.buyer_id = t.buyer_id AND t14.seller_id = t.seller_id
                            ORDER BY transaction_amount
                            LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) * 3 / 4)) + 1.5 * 
                            (SELECT 
                               (SELECT transaction_amount
                                FROM transactionTable t15
                                WHERE t15.buyer_id = t.buyer_id AND t15.seller_id = t.seller_id
                                ORDER BY transaction_amount
                                LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) * 3 / 4)) -
                               (SELECT transaction_amount
                                FROM transactionTable t16
                                WHERE t16.buyer_id = t.buyer_id AND t16.seller_id = t.seller_id
                                ORDER BY transaction_amount
                                LIMIT 1 OFFSET (COUNT(*) OVER (PARTITION BY t.buyer_id, t.seller_id) / 4)) AS IQR
                            )
ORDER BY t.buyer_id, t.seller_id, t.transaction_amount DESC;
