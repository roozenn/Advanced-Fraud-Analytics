WITH FraudOrBlacklistedUsers AS (
    -- Menyaring pengguna yang terflag fraud atau blacklist
    SELECT 
        company_id,
        user_fraud_flag,
        blacklist_account_flag
    FROM 
        comp_v2
    WHERE 
        user_fraud_flag = 1 OR blacklist_account_flag = 1
)
-- Menyaring dan menghitung transaksi antara buyer dan seller yang terflag fraud atau blacklist
SELECT 
    c.company_id,  -- ID perusahaan yang terdeteksi fraud atau blacklist
    c.user_fraud_flag,  -- Flag fraud untuk perusahaan
    c.blacklist_account_flag,  -- Flag blacklist untuk perusahaan
    t.buyer_id,  -- ID pembeli
    t.seller_id,  -- ID penjual
    COUNT(t.dpt_id) AS transaction_count,  -- Jumlah transaksi antara buyer dan seller ini
    SUM(t.transaction_amount) AS total_transaction_amount,  -- Total transaksi antara buyer dan seller ini
    t.suspicious,  -- Kolom suspicious yang sudah ada
    t.relationship_score  -- Skor hubungan antara buyer dan seller
FROM 
    transaction_v2 t
JOIN 
    FraudOrBlacklistedUsers c ON (t.buyer_id = c.company_id OR t.seller_id = c.company_id)  -- Hanya transaksi dengan pengguna fraud atau blacklist
GROUP BY 
    t.buyer_id, t.seller_id, c.company_id  -- Mengelompokkan berdasarkan interaksi antara buyer dan seller
ORDER BY 
    transaction_count DESC, total_transaction_amount DESC;  -- Urutkan berdasarkan jumlah transaksi dan total nilai transaksi
