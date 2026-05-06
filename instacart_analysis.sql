
--veri seti inceleme
SELECT 
*
FROM orders 
LIMIT 10;

--hangi saatte kaç sipariş verilmiş?
SELECT 
order_hour_of_day,
COUNT(*) siparis_sayisi
FROM orders 
GROUP BY order_hour_of_day 
ORDER BY order_hour_of_day;

--gece siparişlerindeki hangi kategoriler öne çıkıyor?
--gece 00:00 / 04:00 arasında verilen siparişlerde en çok hangi reyon öne çıkmış?
SELECT 
  a.aisle,
  COUNT(*) as siparis_sayisi
FROM orders o
JOIN order_products__prior op ON o.order_id = op.order_id
JOIN products p ON op.product_id = p.product_id
JOIN aisles a ON p.aisle_id = a.aisle_id
WHERE o.order_hour_of_day BETWEEN 0 AND 4
GROUP BY a.aisle
ORDER BY siparis_sayisi DESC
LIMIT 15;

--Bulgu: gece alışverişerleri bir sonraki güne hazırlık:fresh vegetables
--Ya da taze ürünler her saat diliminde en çok olduğu için gece de öne çıktı.
--test edelim: gece ile gündüz kıyaslaması!

SELECT 
a.aisle,
COUNT(*) AS siparis_sayisi,
CASE
WHEN o.order_hour_of_day BETWEEN 0 AND 4 THEN "gece"
ELSE "gunduz"
END AS "siparis_zamani"
FROM orders AS o
JOIN order_products__prior AS op ON o.order_id = op.order_id
JOIN products AS p ON p.product_id = op.product_id 
JOIN aisles AS a ON p.aisle_id = a.aisle_id 
GROUP BY a.aisle_id, siparis_zamani
ORDER BY a.aisle_id, siparis_zamani
--okuması zor bir veri her kagetori için sipariş+zamanı cıkmıs. oran yok.gecenin oranının gösterildiği okunabilir bir format lazım
SELECT 
  aisle,
  gece,
  gunduz,
  ROUND(CAST(gece AS FLOAT) / (gece + gunduz) * 100, 2) as gece_yuzdesi
FROM (
  SELECT 
    a.aisle,
    SUM(CASE WHEN o.order_hour_of_day BETWEEN 0 AND 4 THEN 1 ELSE 0 END) as gece,
    SUM(CASE WHEN o.order_hour_of_day NOT BETWEEN 0 AND 4 THEN 1 ELSE 0 END) as gunduz
  FROM orders o
  JOIN order_products__prior op ON o.order_id = op.order_id
  JOIN products p ON op.product_id = p.product_id
  JOIN aisles a ON p.aisle_id = a.aisle_id
  GROUP BY a.aisle
)
ORDER BY gece_yuzdesi DESC
LIMIT 20;

--tekrar satın alma oranı:alışkanlık vs. anlık karar döngüsü
SELECT 
  a.aisle,
  ROUND(AVG(op.reordered) * 100, 2) as tekrar_satin_alma_yuzdesi,
  COUNT(*) as toplam_satin_alma
FROM order_products__prior op
JOIN products p ON op.product_id = p.product_id
JOIN aisles a ON p.aisle_id = a.aisle_id
GROUP BY a.aisle
ORDER BY tekrar_satin_alma_yuzdesi DESC
LIMIT 20;






