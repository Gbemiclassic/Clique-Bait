# Case Study #6: Clique Bait

<p align="center" style="margin-bottom: 0px !important;">
<img src="https://github.com/Gbemiclassic/Clique-Bait/blob/main/Images/Clique%20bait.png" alt="Image" width="500" height="520">

## 📚 Table of Contents
- [Business Task](#business-task)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Case Study Solution](#case-study-solution)
  - [1. Digital Analysis](https://github.com/Gbemiclassic/Clique-Bait/blob/main/1.%20Digital%20Analysis.md)
  - [2. Product Funnel Analysis](https://github.com/Gbemiclassic/Clique-Bait/blob/main/2.%20Product%20Funnel%20Analysis.md)
  - [3. Campaigns Analysis](https://github.com/Gbemiclassic/Clique-Bait/blob/main/3.%20Campaigns%20Analysis.md)

***

## Business Task
Clique Bait is an online seafood store. 

In this case study - you are required to support the founder and CEO Danny’s vision and analyse his dataset and come up with creative solutions to calculate funnel fallout rates for the Clique Bait online store.

## Entity Relationship Diagram

<p align="center" style="margin-bottom: 0px !important;">
<img width="825" alt="image" src="https://github.com/Gbemiclassic/Clique-Bait/blob/main/Images/Entity%20Relationship%20Diagram.png">

***

## Case Study Solution

### 1. Digital Analysis

View my solution [here](https://github.com/Gbemiclassic/Clique-Bait/blob/main/1.%20Digital%20Analysis.md).

1. How many users are there?
2. How many cookies does each user have on average?
3. What is the unique number of visits by all users per month?
4. What is the number of events for each event type?
5. What is the percentage of visits which have a purchase event?
6. What is the percentage of visits which view the checkout page but do not have a purchase event?
7. What are the top 3 pages by number of views?
8. What is the number of views and cart adds for each product category?
9. What are the top 3 products by purchases?

***

### 2. Product Funnel Analysis

View my solution [here](https://github.com/Gbemiclassic/Clique-Bait/blob/main/2.%20Product%20Funnel%20Analysis.md).

Using a single SQL query - create a new output table which has the following details:

1. How many times was each product viewed?
2. How many times was each product added to cart?
3. How many times was each product added to a cart but not purchased (abandoned)?
4. How many times was each product purchased?

Additionally, create another table which further aggregates the data for the above points but this time for each product category instead of individual products.

Use your 2 new output tables - answer the following questions:

1. Which product had the most views, cart adds and purchases?
2. Which product was most likely to be abandoned?
3. Which product had the highest view to purchase percentage?
4. What is the average conversion rate from view to cart add?
5. What is the average conversion rate from cart add to purchase?

***

### 3. Campaigns Analysis

View my solution [here](https://github.com/Gbemiclassic/Clique-Bait/blob/main/3.%20Campaigns%20Analysis.md).

Generate a table that has 1 single row for every unique visit_id record and has the following columns:
- user_id
- visit_id
- visit_start_time: the earliest event_time for each visit
- page_views: count of page views for each visit
- cart_adds: count of product cart add events for each visit
- purchase: 1/0 flag if a purchase event exists for each visit
- campaign_name: map the visit to a campaign if the visit_start_time falls between the start_date and end_date
- impression: count of ad impressions for each visit
- click: count of ad clicks for each visit
- (Optional column) cart_products: a comma separated text value with products added to the cart sorted by the order they were added to the cart (hint: use the sequence_number)
  
Use the subsequent dataset to generate at least 5 insights for the Clique Bait team - bonus: prepare a single A4 infographic that the team can use for their management reporting sessions, be sure to emphasise the most important points from your findings.

Some ideas you might want to investigate further include:

- Identifying users who have received impressions during each campaign period and comparing each metric with other users who did not have an impression event
- Does clicking on an impression lead to higher purchase rates?
- What is the uplift in purchase rate when comparing users who click on a campaign impression versus users who do not receive an impression? What if we compare them with users who just an impression but do not click?
- What metrics can you use to quantify the success or failure of each campaign compared to each other?

***

 # <p align="center" style="margin-top: 0px;">Thank you 😎