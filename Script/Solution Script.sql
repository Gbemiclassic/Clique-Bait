-- 2. Digital Analysis

/* 1. How many users are there? */

SELECT COUNT(DISTINCT user_id)
FROM users;

-- There are 500 users

/* 2. How many cookies does each user have on average? */

SELECT 
	ROUND(COUNT(DISTINCT cookie_id) / COUNT(DISTINCT user_id), 0) Avg_cookies_per_user
FROM users;

-- There are 4 cookies per user on the average.

/* 3. What is the unique number of visits by all users per month? */

SELECT 
	 MONTH(event_time) month
	,COUNT(DISTINCT visit_id)
FROM events
GROUP BY 1
ORDER BY 1;



/* 4. What is the number of events for each event type? */

SELECT 
	 event_type
	,COUNT(*)
FROM events
GROUP BY 1
ORDER BY 1;

/* 5. What is the percentage of visits which have a purchase event? */

SELECT 
	CONCAT(ROUND(100 * COUNT(DISTINCT CASE WHEN ei.event_name = 'Purchase' THEN visit_id ELSE NULL END) 
		/ COUNT(DISTINCT visit_id), 2), '%') pct_purchase
FROM events e
	LEFT JOIN event_identifier ei
		ON e.event_type = ei.event_type;
        
-- 49.86 of the visits had a purchase event.

/* 6. What is the percentage of visits which view the checkout page but do not have a purchase event? */

WITH cte AS(
SELECT
	 COUNT(CASE WHEN event_type = 1 AND page_id = 12 THEN visit_id ELSE NULL END) checkouts
    ,COUNT(CASE WHEN event_type = 3 THEN visit_id ELSE NULL END) purchases
FROM events
)
 SELECT CONCAT(ROUND(100 * (checkouts - purchases)/ checkouts, 2), '%') pct
 FROM cte;
        
-- 15.5% of the visits that viewed the checkout page did not make a purchase

/* 7. What are the top 3 pages by number of views? */

SELECT
	 p.page_name
     ,COUNT(visit_id)
FROM events e
	LEFT JOIN page_hierarchy p 
		ON e.page_id = p.page_id
WHERE event_type = 1 -- to include Page View only
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;
        
-- All Products, Checkout and Home Page are the top 3 most viewed pages.

/* 8. What is the number of views and cart adds for each product category? */

SELECT
	 p.product_category
	,COUNT(CASE WHEN event_type = 1 THEN visit_id ELSE NULL END) views
	,COUNT(CASE WHEN event_type = 2 THEN visit_id ELSE NULL END) cart_adds
FROM events e
	LEFT JOIN page_hierarchy p 
		ON e.page_id = p.page_id
WHERE p.product_category IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC;
        
/* 9. What are the top 3 products by purchases? */

SELECT
	p.page_name AS product_name
	,COUNT(*) purchases
FROM events e
	LEFT JOIN page_hierarchy p 
		ON e.page_id = p.page_id
WHERE visit_id IN (
					SELECT DISTINCT visit_id
					FROM events
					WHERE event_type = 3
					)
AND event_type = 2
AND p.product_id IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;



-- 3. Product Funnel Analysis
/*
Using a single SQL query - create a new output table which has the following details:

How many times was each product viewed?
How many times was each product added to cart?
How many times was each product added to a cart but not purchased (abandoned)?
How many times was each product purchased?
Additionally, create another table which further aggregates the data for the above points but this time for each product category instead of individual products.
*/

CREATE TABLE product_details AS
SELECT
	 page_name product_name
	,product_category
	,COUNT(CASE WHEN event_type = 1 THEN visit_id ELSE NULL END) views
	,COUNT(CASE WHEN event_type = 2 THEN visit_id ELSE NULL END) cart_adds
	,COUNT(CASE WHEN event_type = 2 AND visit_id NOT IN (SELECT visit_id FROM events WHERE event_type = 3) THEN visit_id ELSE NULL END) abandoned
	,COUNT(CASE WHEN event_type = 2 AND visit_id IN (SELECT DISTINCT visit_id FROM events WHERE event_type = 3) THEN visit_id ELSE NULL END) purchases
FROM events e
	LEFT JOIN page_hierarchy p
		ON e.page_id = p.page_id
WHERE product_id IS NOT NULL
GROUP BY 1, 2;


CREATE TABLE prod_cat_details AS
SELECT
	 product_category
	,SUM(views)
    ,SUM(cart_adds)
    ,SUM(abandoned)
    ,SUM(purchases)
FROM product_details
GROUP BY 1
;

-- Use your 2 new output tables - answer the following questions:

-- 1. Which product had the most views, cart adds and purchases?
-- 2. Which product was most likely to be abandoned?

SELECT *
FROM product_details;

-- Oyster has the most views.
-- Lobster has the most cart adds and purchases.
-- Russian Caviar is most likely to be abandoned.



-- 3. Which product had the highest view to purchase percentage?

SELECT
	 product_name
	,ROUND(100 * purchases/views, 2) pct_view_to_purchase
FROM product_details
ORDER BY 2 DESC
LIMIT 1;

-- 4. What is the average conversion rate from view to cart add? What is the average conversion rate from cart add to purchase?

SELECT
	 CONCAT(ROUND(100 * SUM(cart_adds)/SUM(views), 2), '%') view_to_cart_conv_rt
    ,CONCAT(ROUND(100 * SUM(purchases)/SUM(cart_adds), 2), '%') cart_to_purchases_conv_rt
FROM product_details;

-- Average views to cart adds rate is 60.95% and average cart adds to purchases rate is 75.93%.
-- Although the cart add rate is lower, but the conversion of potential customer to the sales funnel is at least 15% higher.

-- 3. Campaigns Analysis

SELECT 
	 user_id
	,e.visit_id
	,MIN(e.event_time) AS visit_start_time
	,SUM(CASE WHEN e.event_type = 1 THEN 1 ELSE 0 END) AS page_views
	,SUM(CASE WHEN e.event_type = 2 THEN 1 ELSE 0 END) AS cart_adds
	,SUM(CASE WHEN e.event_type = 3 THEN 1 ELSE 0 END) AS purchase
	,campaign_name
	,SUM(CASE WHEN e.event_type = 4 THEN 1 ELSE 0 END) AS impression 
	,SUM(CASE WHEN e.event_type = 5 THEN 1 ELSE 0 END) AS click 
	,GROUP_CONCAT(CASE 
					WHEN p.product_id IS NOT NULL 
                    AND e.event_type = 2 -- for products added to cart only
                    THEN p.page_name ELSE NULL 
                    END 
					ORDER BY e.sequence_number SEPARATOR ', '
				) AS cart_products
FROM events e
	INNER JOIN users u
		ON e.cookie_id = u.cookie_id
	LEFT JOIN campaign_identifier c
		ON e.event_time BETWEEN c.start_date AND c.end_date
	LEFT JOIN page_hierarchy p
		ON e.page_id = p.page_id
GROUP BY 1, 2, 7;
