-- Bussiness analysis using sql
use customer_behaviour;
select * from customer_shopping limit 15;

-- Q1. Which gender contributes more revenue?

SELECT gender,
       ROUND(SUM(purchase_amount),2) AS revenue
FROM customer_shopping
GROUP BY gender
ORDER BY revenue DESC;

-- Q2. Which customers used a discount but still spent more than the average purchase amount? 

select customer_id, purchase_amount
from customer_shopping
where discount_applied='Yes' and 
purchase_amount>=(select avg(purchase_amount) from customer_shopping);

-- Q3. Which are the top 5 products with the highest average review rating? 

select item_purchased, round(avg(review_rating),2) as average_product_rating
from customer_shopping
group by item_purchased
order by avg(review_rating) desc
limit 5;

-- Q4. Compare the average Purchase Amounts between Standard and Express Shipping.

select shipping_type, round(avg(purchase_amount),2)
from customer_shopping
where shipping_type in ('Standard','Express')
group by shipping_type;

-- Q5. Do discounts increase spending?

SELECT discount_applied,
       ROUND(AVG(purchase_amount),2) avg_purchase
FROM customer_shopping
GROUP BY discount_applied;

-- Q6. Which 5 products have the highest percentage of purchases with discounts applied? 

select item_purchased,
round(sum(case when discount_applied = 'Yes' then 1 else 0 end ) / count(*) * 100 ,2) as discount_rate
from customer_shopping
group by item_purchased
order by discount_rate desc
limit 5;

-- Q7. Segment customers into New, Returning, and Loyal based on their total number of previous purchases, and show the count of each segment.

with customer_type as (
select customer_id, previous_purchases,
case
    when previous_purchases = 1 then 'New'
    when previous_purchases between 2 and 10 then 'Returning'
    else 'Loyal'
    end as customer_segment
from customer_shopping)

select customer_segment,count(*) as "Number of Customers" 
from customer_type 
group by customer_segment;

-- Q8. What are the top 3 most purchased products within each category? 

WITH item_counts AS (
    SELECT category,
           item_purchased,
           COUNT(customer_id) AS total_orders,
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY COUNT(customer_id) DESC) AS item_rank
    FROM customer_shopping
    GROUP BY category, item_purchased
)
SELECT item_rank,category, item_purchased, total_orders
FROM item_counts
WHERE item_rank <=3;

-- Q9. Are customers who are repeat buyers (more than 5 previous purchases) also likely to subscribe? 

select subscription_status, count(customer_id) as repeat_buyers
from customer_shopping
where previous_purchases > 5
group by subscription_status;

-- Q10. What is the revenue contribution of each age group?

select age_group, sum(purchase_amount) as total_revenue
FROM customer_shopping
GROUP BY age_group
ORDER BY total_revenue desc;

-- Q11. Which category drives the business?

SELECT category,
       ROUND(SUM(purchase_amount),2) AS revenue
FROM customer_shopping
GROUP BY category
ORDER BY revenue DESC;

-- Q12.Do subscriptions increase revenue?

SELECT subscription_status,
       COUNT(*) total_customers,
       ROUND(AVG(purchase_amount),2) avg_spend,
       ROUND(SUM(purchase_amount),2) total_revenue
FROM customer_shopping
GROUP BY subscription_status;

-- Q13. Does shipping preference affect sales?

SELECT shipping_type,
       ROUND(SUM(purchase_amount),2) revenue
FROM customer_shopping
GROUP BY shipping_type
ORDER BY revenue DESC;