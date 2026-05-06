# What Do We Buy at Night? — Instacart Behavioral Analysis

A SQL-based behavioral analysis of 3M+ grocery orders, exploring **when** people shop, **what** they buy at night, and **which categories are driven by habit vs. impulse**.

Inspired by my background in ethnographic research, this project applies data analysis to uncover cultural patterns in everyday consumer behavior.

---

# Research Questions

1. At what hours do people place grocery orders?
2. Which product categories are overrepresented in late-night orders (00:00–04:00)?
3. Which categories have the highest reorder rates and signaling habitual behavior?

---

# Key Findings

| Finding |                                               | Insight |

| 90%+ of orders placed between 07:00–21:00               | Grocery shopping is a planned, daytime behavior |
| Beauty, first aid & skin care peak at night             | Late-night orders signal emotional/immediate need, not routine |
| Milk (78%), fresh fruits (72%), eggs (71%) reorder rate | Core staples are purchased on autopilot — no decision-making involved |

---

# Dataset

[Instacart Market Basket Analysis](https://www.kaggle.com/datasets/psparks/instacart-market-basket-analysis) — 3M+ orders, public domain (CC0)

**Tables used:** `orders`, `order_products_prior`, `products`, `aisles`, `departments`

---

#  Tools

- **SQL** (SQLite via DB Browser for SQLite)
- Analysis: `instacart_analysis.sql`

---

#  Author

Bahadir Köksal 
[LinkedIn](https://www.linkedin.com/in/bahad%C4%B1r-k%C3%B6ksal5806642a9/)
