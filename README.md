# Case Study #5: Data Mart

<img src="https://github.com/Gbemiclassic/SQL-Challenge-Case-Study-5---Data-Mart/blob/main/Images/Case%20Study%20Pics.png" alt="Image" width="500" height="520">

## 🧾 Table of Contents
- [Business Task](#business-task)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Case Study Solution](#case-study-solution)
  - [1. Data Cleansing Steps](#a-data-cleansing-steps)
  - [2. Data Exploration](#b-data-exploration)
  - [3. Before & After Analysis](#c-before--after-analysis)
  - [4. Bonus Question](#d-bonus-question)
***

## Business Task
Data Mart is an Internayional online supermarket that specialises in fresh produce.

In June 2020 - large scale supply changes were made at Data Mart. All Data Mart products now use sustainable packaging methods in every single step from the farm all the way to the customer.

Danny needs your help to analyse and quantify the impact of this change on the sales performance for Data Mart and it’s separate business areas.

The key business question to answer are the following:
- What was the quantifiable impact of the changes introduced in June 2020?
- Which platform, region, segment and customer types were the most impacted by this change?
- What can we do about future introduction of similar sustainability updates to the business to minimise impact on sales?

## Entity Relationship Diagram

For this case study there is only a single table: data_mart.weekly_sales

<img width="287" alt="image" src="https://github.com/Gbemiclassic/SQL-Challenge-Case-Study-5---Data-Mart/blob/main/Images/Entity%20Relationship%20Diagram.png">


Column Dictionary

1. Data Mart has international operations using a multi-`region` strategy.
2. Data Mart has both, a retail and online `platform` in the form of a Shopify store front to serve their customers.
3. Customer `segment` and `customer_type` data relates to personal age and demographics information that is shared with Data Mart.
4. `transactions` is the count of unique purchases made through Data Mart and `sales` is the actual dollar amount of purchases.

Each record in the dataset is related to a specific aggregated slice of the underlying sales data rolled up into a week_date value which represents the start of the sales week.

10 random rows are shown in the table output below from `data_mart.weekly_sales`.

<img width="649" alt="image" src="https://github.com/Gbemiclassic/SQL-Challenge-Case-Study-5---Data-Mart/blob/main/Images/Table.jpg">

***

## Case Study Solution

  - [1. Data Cleansing Steps](https://github.com/Gbemiclassic/SQL-Challenge-Case-Study-5---Data-Mart/blob/main/1.%20Data%20Cleansing%20Steps.md)
  - [2. Data Exploration](https://github.com/Gbemiclassic/SQL-Challenge-Case-Study-5---Data-Mart/blob/main/2.%20Data%20Exploration.md)
  - [3. Before & After Analysis](https://github.com/Gbemiclassic/SQL-Challenge-Case-Study-5---Data-Mart/blob/main/3.%20Before%20%26%20After%20Analysis.md)
  - [4. Bonus Question](https://github.com/Gbemiclassic/SQL-Challenge-Case-Study-5---Data-Mart/blob/main/4.%20Bonus%20Questions.md)
***

 # <p align="center" style="margin-top: 0px;">Thank you 😎