SELECT 
    t.buyer_id,
    t.seller_id,
    COUNT(t.dpt_id) AS transaction_count,
    SUM(t.transaction_amount) AS total_transaction_amount,
    AVG(t.relationship_score) AS avg_relationship_score
FROM 
    transactionTable t
GROUP BY 
    t.buyer_id, t.seller_id
HAVING 
    COUNT(t.dpt_id) > (SELECT AVG(transaction_count) FROM (
                        SELECT 
                            COUNT(dpt_id) AS transaction_count
                        FROM 
                            transactionTable
                        GROUP BY 
                            buyer_id, seller_id))
    OR SUM(t.transaction_amount) > (SELECT AVG(transaction_amount) FROM (
                                      SELECT 
                                          SUM(transaction_amount) AS transaction_amount
                                      FROM 
                                          transactionTable
                                      GROUP BY 
                                          buyer_id, seller_id))
ORDER BY 
    transaction_count DESC, total_transaction_amount DESC;
