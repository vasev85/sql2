show grants for sys_temp@localhost;
select user,host,plugin from mysql.user;
REVOKE ALL PRIVILEGES ON *.* FROM `sys_temp`@`localhost`;
GRANT SELECT, USAGE  ON sakila.* TO `sys_temp`@`localhost`;
GRANT SELECT, INSERT, UPDATE, DELETE ON mysql.* TO `sys_temp`@`localhost`;
REVOKE SELECT  ON *.*  FROM  `sys_temp`@`localhost`;

select DISTINCT a.district, a.address  ,UPPER (LEFT (a.district ,1)) as pr,
(right (a.district ,1)) as pr2 
from address a 
WHERE UPPER (LEFT (a.district ,1)) = 'K' and LOWER(right (a.district ,1)) = 'a' and a.district NOT  LIKE '% %'
order by district;

SELECT  DISTINCT a.district, SUBSTRING_INDEX(SUBSTRING_INDEX(a.address, ' ', -2) , ' ' ,1) as pro,  
UPPER( LEFT (SUBSTRING_INDEX(SUBSTRING_INDEX(a.address, ' ', -2) , ' ' ,1)  ,1)) as pr1,
LOWER( right (SUBSTRING_INDEX(SUBSTRING_INDEX(a.address, ' ', -2) , ' ' ,1)  ,1)) as pr2
from address a 
WHERE UPPER( LEFT (SUBSTRING_INDEX(SUBSTRING_INDEX(a.address, ' ', -2) , ' ' ,1)  ,1)) = 'K'  AND 
      LOWER( right (SUBSTRING_INDEX(SUBSTRING_INDEX(a.address, ' ', -2) , ' ' ,1)  ,1)) = 'a' AND
      LENGTH (SUBSTRING_INDEX(SUBSTRING_INDEX(a.address, ' ', -2) , ' ' ,1)) = 
      LENGTH (replace( SUBSTRING_INDEX(SUBSTRING_INDEX(a.address, ' ', -2) , ' ' ,1), ' ', ''))
order by district; 


SELECT PARSENAME(REPLACE(a.address, ' ', '.'), 2) 
from address a ;

SELECT  (SUBSTRING_INDEX(a.address, ' ',-2) ) as pos, Left (pos,1)
from address a ;

SELECT  DISTINCT a.district, a.address  ,UPPER (LEFT (a.district ,1)) as pr,
(right (a.district ,1)) as pr2 
from address a 
WHERE UPPER (LEFT (a.district ,1)) = 'K' and LOWER(right (a.district ,1)) = 'a' and length(a.district) = length(replace(a.district , ' ', ''))
order by district;

SELECT p.amount , p.payment_date 
FROM payment p 
WHERE p.payment_date BETWEEN '2005-06-15' AND '2005-06-18'
      AND p.amount  >10
ORDER BY   p.amount DESC;



SELECT  f.title, p.amount, p.payment_date p_date1
FROM payment p 
JOIN rental r  ON r.rental_id  = p.rental_id 
JOIN inventory i   ON r.inventory_id  = i.inventory_id  
JOIN film f  ON f.film_id  = i.film_id  
ORDER BY    p_date1 DESC 
LIMIT 5;

SELECT REPLACE (LOWER( c.first_name),'ll','pp') nam,  REPLACE(LOWER ( c.last_name), 'll', 'pp') , c.active 
FROM customer c 
WHERE (c.first_name = 'Kelly' or c.first_name = 'Willie') AND c.active = 1 
ORDER BY nam
;  


SELECT c.email,SUBSTRING_INDEX(c.email, '@', 1),
CONCAT(  LEFT (UPPER (SUBSTRING_INDEX(c.email, '@', 1)),1) , LOWER( SUBSTR((SUBSTRING_INDEX(c.email, '@', 1)),2)) ) as first_e,
SUBSTRING_INDEX(c.email , '@', -1),
CONCAT(  LEFT (UPPER (SUBSTRING_INDEX(c.email, '@', -1)),1) , LOWER( SUBSTR((SUBSTRING_INDEX(c.email, '@', -1)),2))) as second_e
FROM customer c 
;



SELECT  CONCAT(s.first_name, ' ' ,s.last_name) AS  ??????, c.city, COUNT( c2.customer_id)  AS ??????????_??????????????????????  
FROM staff s 
JOIN address a ON s.address_id  = a.address_id 
JOIN city c ON a.city_id = c.city_id 
JOIN store s2  ON s2.store_id = s.store_id 
JOIN customer c2 ON s2.store_id = c2.store_id  
GROUP BY s.first_name, s.last_name, c.city 
HAVING ??????????_?????????????????????? > 300
;



SELECT  COUNT(f.`length`) AS ??????????_??????????????
FROM film f 
WHERE    f.length  >  (SELECT AVG( f2.`length`)  FROM film f2) 
;


SELECT CAST( EXTRACT(YEAR_MONTH  FROM p.payment_date) AS CHAR) AS ??????????,
(SUM(p.amount)) AS ??????????_??_??????????, COUNT((p.rental_id)) AS ?????????? 
FROM payment p 
group by ??????????
ORDER BY ??????????_??_??????????   DESC  
LIMIT 1;




SELECT CONCAT(s.first_name, ' ' ,s.last_name) AS  ??????,
 COUNT(p.amount) as ?????????????? ,
CASE
	WHEN COUNT(p.amount) > 8000 THEN '????'
	WHEN COUNT(p.amount) < 8000 THEN '??????'
END AS ????????????
FROM payment p 
JOIN staff s ON s.staff_id = p.staff_id 
WHERE p.amount > 0
GROUP BY ??????
ORDER BY ?????????????? DESC
;


SELECT CONCAT(s.first_name, ' ' ,s.last_name) AS  ??????,
 COUNT(p.amount) as ?????????????? ,
CASE
	WHEN COUNT(p.amount) > 8000 THEN '????'
	WHEN COUNT(p.amount) < 8000 THEN '??????'
END AS ????????????,
SUM(p.amount) AS ?????????????? 
FROM payment p 
JOIN staff s ON s.staff_id = p.staff_id 
WHERE p.amount > 0
GROUP BY ??????
ORDER BY ?????????????? DESC
;

SELECT f.title, f.release_year,  p.amount, p.payment_date, r.return_date
from payment p 
JOIN rental r ON r.rental_id = p.rental_id 
JOIN inventory i ON i.inventory_id = r.inventory_id 
JOIN film f ON f.film_id = i.film_id 
WHERE p.amount = 0
ORDER BY f.title 
;









