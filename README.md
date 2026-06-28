# Customer-Shopping-Behavior-Analysis
End-to-end Customer Shopping Behavior Analysis project using Python, MySQL, SQL, and Power BI. Includes data cleaning, feature engineering, business analysis, customer segmentation, and interactive dashboard development to generate actionable retail insights.

## 📌 Project Overview

Retail businesses generate large amounts of customer transaction data every day. This project aims to analyze customer shopping behavior, purchasing patterns, product performance, and customer demographics to support business decision-making.

The project follows a complete analytics workflow:

- Data Cleaning and Preprocessing
- Feature Engineering
- Database Integration
- SQL-Based Business Analysis
- Interactive Dashboard Development

---

## 🎯 Business Objectives

This project answers important business questions such as:

- Which gender contributes more revenue?
- Which product categories drive business growth?
- Do discounts increase customer spending?
- Which age groups contribute most to revenue?
- Does subscription membership increase sales?
- Which shipping methods generate higher revenue?
- Which products receive the highest customer ratings?

---

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| Python | Data Cleaning & Feature Engineering |
| Pandas | Data Manipulation |
| MySQL | Database Storage |
| SQL | Business Analysis |
| Power BI | Dashboard Development |
| Jupyter Notebook | Data Processing |
| VS Code | Development Environment |

---
## 🧹 Data Cleaning

The raw dataset was cleaned and standardized before analysis.

### Cleaning Steps

- Inspected dataset structure and data types.
- Handled missing values in `review_rating`.
- Filled missing ratings using category-wise median values.
- Standardized column names using snake_case.
- Renamed columns for readability.
- Removed redundant columns.
- Verified data quality and consistency.

### Example

```python
df['Review Rating'] = df.groupby('Category')['Review Rating']\
.transform(lambda x: x.fillna(x.median()))
```

---

## ⚙️ Feature Engineering

Additional features were created to improve analytical capabilities.

### 1. Age Group Segmentation

Customers were segmented into four age groups:

- Young Adult
- Adult
- Middle-aged
- Senior-Citizen

```python
labels=['Young Adult','Adult','Middle-aged','Senior-Citizen']

df['age_group'] = pd.qcut(
    df['age'],
    q=4,
    labels=labels
)
```

### 2. Purchase Frequency in Days

Purchase frequencies were converted into numerical values.

| Frequency | Days |
|----------|------|
| Weekly | 7 |
| Bi-Weekly | 14 |
| Monthly | 30 |
| Quarterly | 90 |
| Annually | 365 |

### 3. Removed Redundant Features

The `promo_code_used` column was removed after verifying it contained identical information to `discount_applied`.

---

## 🗄️ Database Integration

The cleaned dataset was imported into MySQL using SQLAlchemy.

```python
engine = create_engine(
    f"mysql+pymysql://{username}:{password}@{host}:{port}/{database}"
)

df.to_sql(
    name='customer_shopping',
    con=engine,
    if_exists='replace',
    index=False
)
```

---

## 📊 SQL Business Analysis

The project includes business-focused SQL analysis to answer strategic questions.

### Key Business Questions

Major Insights:

1.Revenue by Gender
2.Category Performance
3.Age Group Contribution
4.Subscription Analysis
5.Discount Effectiveness
6.Shipping Preferences

## 📈 Power BI Dashboard

An interactive Power BI dashboard was developed to visualize customer behavior and business performance.

### Dashboard KPIs

- **Total Customers:** 3.9K
- **Average Purchase Amount:** $59.76
- **Average Review Rating:** 3.75
- **Total Revenue:** $233.08K
- **Subscription Rate:** 27%

### Dashboard Features

- Revenue by Gender
- Revenue by Category
- Revenue by Age Group
- Customer Distribution by Age Group
- Subscription Analysis
- Seasonal Revenue Trends
- Shipping Performance Analysis
- Interactive Filters and Slicers

---

## 🔍 Key Insights

- Male customers generated a larger share of revenue.
- Clothing was the highest revenue-generating category.
- Young Adults and Middle-aged customers contributed the most revenue.
- Customers using discounts maintained competitive spending levels.
- Subscribers showed higher overall purchasing behavior.
- Seasonal trends influenced purchasing patterns significantly.

---

## 📷 Dashboard Preview

<img width="906" height="509" alt="image" src="https://github.com/user-attachments/assets/cf50d020-2e91-4254-80de-9e60cfb08800" />


