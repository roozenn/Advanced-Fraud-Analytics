SELECT 
    t.Albumid,
    COUNT(il.Trackid) AS TrackCount,
    SUM(il.UnitPrice * il.Quantity) AS TotalSales,
    SUM(il.UnitPrice * il.Quantity)/COUNT(il.Trackid) AS AVG
FROM 
    InvoiceLine il
JOIN 
    Track t ON il.Trackid = t.Trackid
GROUP BY 
    t.Albumid;
