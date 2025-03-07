SELECT
	t.dpt_id,
	t.buyer_id,
	t.seller_id,
	t.transaction_amount,
	t.transaction_created_datetime,
	t.relationship_score,
	t.suspicious AS transaction_suspicious,
	c.company_id,
	c.company_kyc_status_name,
	c.company_kyb_status_name,
	c.user_fraud_flag,
	c.package_active_name,
	c.company_phone_verified_flag,
	c.company_email_verified_flag
FROM
	transaction_v2 t
JOIN
	comp_v2 c ON t.seller_id = c.company_id OR t.buyer_id = c.company_id  -- Memeriksa buyer_id dan seller_id
WHERE
	t.suspicious = "True"  -- Memfilter transaksi yang dicurigai
ORDER BY
	t.transaction_created_datetime DESC;