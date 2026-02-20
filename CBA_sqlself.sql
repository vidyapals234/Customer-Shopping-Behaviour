show databases;
use customer_behavior;
show tables;

select * from customer;

select age
from customer;

select gender, SUM(purchase_amount) as revenue
from customer
group by gender;

select customer_id,purchase_amount
from customer
where discount_applied = 'Yes' and purchase_amount >= (select AVG(purchase_amount) from customer);

select item_purchased, round(avg(review_rating),2) as "Average Product Rating"
from customer
group by item_purchased
order by avg(review_rating) desc
limit 5;

select shipping_type, round(avg(Purchase_amount),2) as Average_Purchase_Amount
from customer
where shipping_type in('Express','Standard')
group by shipping_type;

select subscription_status,
count(customer_id) as Total_customers,
round(avg(Purchase_amount),2) as 'Avg_spend',
round(sum(Purchase_amount),2) as 'Total_Revenue'
from customer
group by subscription_status
order by Total_Revenue, Avg_spend desc;

select item_purchased,
round(100 * sum(case when discount_applied = 'Yes' then 1 else 0 end)/ count(*),2) as 'Discount_rate'
from customer
group by item_purchased
order by discount_rate desc
limit 5;


with customer_type as (
select customer_id, previous_purchases,
case 
	when previous_purchases = 1 then 'New'
    when previous_purchases = 2 AND 10 then 'Returning'
    else 'Loyal'
    end as customer_segment
 from Customer 
 )
 select customer_segment, count(*) as 'Number of Customers'
 from customer_type
 group by customer_segment ;
 
 
 with item_counts as (
select category, item_purchased,
count(customer_id) as 'Total_orders',
row_number() over(partition by category order by count(customer_id) desc) as 'item_rank'
from Customer 
group by category, item_purchased
)
select item_rank, category, item_purchased, Total_orders
from item_counts
where item_rank <= 3;


select subscription_status,
count(customer_id) as 'repeat_buyers'
from Customer 
where previous_purchases > 5
group by subscription_status;

 
 select age_group,
 sum(purchase_amount) as total_revenue
 from Customer
 group by age_group
 order by total_revenue desc;
 

















