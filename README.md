# E-Commerce Funnel Analysis Using SQL (BigQuery)

## Project Overview

This project analyzes customer behavior throughout an e-commerce purchase journey using SQL in Google BigQuery.
The objective is to understand how users move through the sales funnel, identify drop-off points, measure conversion rates, and evaluate the performance of different traffic sources.

## Business Problem

E-commerce businesses often struggle to understand where potential customers leave the purchasing process.

This analysis aims to answer the following questions:

  How many users reach each stage of the purchase funnel?
  What are the conversion rates between stages?
  Which traffic source generates the highest quality users?
  How many users abandon their carts?
  How many users abandon the checkout process?

  ## Dataset Information

The dataset contains user-level e-commerce event data.

<img width="314" height="237" alt="image" src="https://github.com/user-attachments/assets/d4978578-66bf-4fe1-be4c-31ddc0ef033c" />

## Tech Stack & Advanced SQL Techniques Used

Platform: Google BigQuery (SQL)

Advanced Features: Common Table Expressions (CTEs), Conditional Aggregations (CASE WHEN), Data Deduplication (DISTINCT), and Safe Division Handling

## Key Business Impact & Outcomes

Global Conversion Funnel: Analyzed the full 5-stage lifecycle (5,000 Views $\rightarrow$ 1,553 Carts $\rightarrow$ 1,103 Checkouts $\rightarrow$ 899 Payments $\rightarrow$ 826 Purchases) to establish a baseline overall conversion rate of 16.52%.

Critical Funnel Leakage: 46.81% of users who add items to their cart abandon them (727 out of 1,553 users), establishing the shopping cart stage as the single biggest revenue drop-off point in the user journey.

Checkout Friction: checkout abandonment rate is 25.11% (277 out of 1,103 users), indicating actionable friction points (such as payment processing or shipping costs) right before final transaction completion.

Channel Inefficiencies: Email campaigns bring in the highest initial intent traffic with an incredible 62.45% view-to-cart rate, whereas Social Media traffic brings volume but fails to convert efficiently, resulting in a low 13.59% view-to-cart rate.

## Detailed Analysis

1. Funnel Stage Count
This query establishes the baseline volumes across each core stage of the e-commerce customer lifecycle to understand overall user traffic scaling.

<img width="719" height="58" alt="image" src="https://github.com/user-attachments/assets/9ea79818-d2cb-4a1a-9469-b9acc8ac5d3c" />

Insight: Out of 5,000 top-of-funnel users who viewed a page, only 826 ultimately converted into buyers. The steepest absolute volume drop occurs between the initial page_view and add_to_cart stages, which is typical for digital retail but highlights an opportunity to improve initial product engagement.

2. Funnel Conversion Rates
To quantify the exact efficiency of our user experience, this query calculates the micro-conversion rates between consecutive steps alongside the holistic macro-conversion rate.

<img width="1443" height="63" alt="image" src="https://github.com/user-attachments/assets/6f4ed34a-946d-4f4f-b6fe-9797085ae3d8" />

Insight: Lower-funnel mechanics are highly optimized: 91.88% of users who submit payment info complete their purchase. However, the macro-conversion baseline sits at 16.52%, heavily dragged down by the initial discovery friction where only 31.06% of browsers ever add an item to their cart.

3. Funnel by Traffic Source
This multi-dimensional segmentation evaluates marketing channel effectiveness, exposing variations in user intent depending on how they landed on the site.

<img width="1525" height="157" alt="image" src="https://github.com/user-attachments/assets/0ff23e4f-b173-485c-9906-89424d576abb" />

Insight:

Email traffic achieved the highest View-to-Cart conversion rate (62.45%), significantly outperforming Organic (32.83%), Paid Ads (36.98%), and Social (13.59%).

4. Cart Abandonment
By defining customer flags based on behavioral extremes (carted vs. purchased), this analysis isolates the volume of high-intent buyers lost after adding inventory to their bags.

<img width="720" height="60" alt="image" src="https://github.com/user-attachments/assets/99152552-c155-4b6f-bfa1-7e73d20e5ca6" />

Insight: 46.81% of users who express immediate purchase intent by adding products to their carts leave without buying. This represents 727 lost customers and points directly to UX drop-offs before initiating formal checkout—such as comparing competitor pricing, saving items for later, or experiencing site friction.

5. Checkout Abandonment
This query isolates users who progressed into the active purchase tunnel but dropped out during data entry (shipping/billing), highlighting late-stage transaction friction.

<img width="837" height="65" alt="image" src="https://github.com/user-attachments/assets/79775ff3-7b7e-4902-82f1-6d264e379df3" />

Insight: Over a quarter (25.11%) of highly motivated shoppers drop out after clicking "Checkout". Because this drop occurs after the cart stage, it strongly signals sticker shock from newly calculated shipping fees/taxes, complex multi-step checkout forms, or a lack of preferred payment methods.

## Business Recommendations
Re-engage Cart Abandoners: Since 46.81% of users abandon their carts, implementing exit-intent popups offering minimal discounts or setting up automated cart reminder emails can re-capture high-intent traffic before they drop completely.

Double Down on High ROI Channels: Shift budget constraints away from broader social campaigns toward Paid Ads and targeted Email Sequences, as they yield significantly higher lower-funnel conversion rates (94.44% and 83.33% respectively).

Streamline the Checkout Process: Address the 25.11% drop-off at the checkout phase by checking for payment issues, hidden shipping fees, or forced account creation steps.

## Project Limitations

  Customer demographic information was unavailable.
  Marketing spend data was not included, preventing ROI analysis.
  Analysis is based on recorded user events only.








