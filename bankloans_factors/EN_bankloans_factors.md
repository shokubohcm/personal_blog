---
title: Determinants of Bank Borrowing in Japanese Listed Companies
tags: Finance, Bank Loans, Determinants
author: shokubohcm
slide: false
---

## About This Article

Using analytical methods and some R code learned in a university course, this article examines and discusses the factors that determine bank borrowing among Japanese listed companies. The dataset and R scripts used in the analysis are available on [GitHub](https://github.com/shokubohcm/bankloans_factors).

## Premise

When companies apply for bank loans, two key considerations are often evaluated:

1. Repayment Capacity
   If a company has a weak repayment capacity, the risk of default is high, making it difficult to secure a loan.

2. Collateral
   Tangible fixed assets—such as buildings, land, and factories—can serve as collateral, so companies with more of these assets are generally able to borrow more from banks.

## Hypotheses

Hypothesis 1: Companies with higher sales volatility are perceived as having lower repayment ability, and therefore, they tend to secure fewer bank loans.
Hypothesis 2: Companies with a higher ratio of tangible fixed assets benefit from these assets acting as collateral, leading to higher levels of bank borrowing.

## Data

The analysis uses data from Japanese listed companies, which you can find on [GitHub](https://github.com/shokubohcm/bankloans_factors). (Note: The M&A data included in the dataset is dummy data.)

## Analysis

### Data Loading and Processing

```R
# Load necessary packages (dplyr, readr, openxlsx, modelsummary)
library(dplyr)
library(readr)
library(openxlsx)
library(modelsummary)

# Import the dataset
data = read_csv("all_2024_num.csv")

# Filter out financial institutions and keep only companies with market capitalization data
source("label_20240929.R")

data = data |>
  filter(!grepl("銀行|保険|証券|その他|金融|-", g31))

data = data |>
  filter(!is.na(mv))
```

### Variable Creation

1. Bank Borrowing Ratio
$$ Debt = (Short-term Borrowings + Current Portion of Long-term Debt + Long-term Borrowings)/Total Assets $$

2. Sales Ratio
$$ Sales = Sales/Total Assets $$

3. Sales Volatility
$$ Sales_Vol = Std (Sales) $$

4. Tangibility
$$ Tangibility = Tangible Fixed Assets/Total Assets $$

5. Company Size
$$ Size = log(Total Assets) $$

6. Market-to-Book Ratio
$$ MB = Market Value/Total Assets $$

7. Cash Holdings
$$ Cash = Cash Holdings/Total Assets $$

```R
data = data |>
  mutate(
    b8 = as.numeric(b8),
    b11 = as.numeric(b11),
    b45 = as.numeric(b45),
    a40 = as.numeric(a40),
    d1 = as.numeric(d1),
    a12 = as.numeric(a12),
    a5 = as.numeric(a5)
  )

# Replace missing values in b8, b11, and b45 with 0 for summation purposes

data = data |>
  mutate(b8 = if_else(is.na(b8), 0, b8),
         b11 = if_else(is.na(b11), 0, b11),
         b45 = if_else(is.na(b45), 0, b45)
  )

# For d1, a12, and a5, fill missing values with the company-specific mean

data = data |>
  group_by(fcode) |>
  mutate(
    d1 = coalesce(d1, mean(d1, na.rm = TRUE)),
    a12 = coalesce(a12, mean(a12, na.rm = TRUE)),
    a5 = coalesce(a5, mean(a5, na.rm = TRUE))
  ) |>
  ungroup()

data = data |>
  mutate(
    Debt = (b8 + b11 + b45) / a40,
    Sales = d1 / a40,
    Tangibility = a12 / a40,
    Size = log(a40),
    MB = mv / a40,
    Cash = a5 / a40
  )

data = data |>
  group_by(fcode) |>
  mutate(Sales_Vol=sd(Sales, na.rm = TRUE),
         Sales_Vol=round(Sales_Vol, digits = 3),) |>
  ungroup()
```

### Creating Year Dummy Variables

```R
data = data |>
  mutate(ind = as.factor(g31))
data = data |>
  mutate(year = NA_real_)

for (i in 2000:2024) {
  data = data |>
    mutate(year=case_when(grepl(i, fy) ~ i,
                          TRUE ~ year)
    )
}

data = data |>
  mutate(year = as.factor(year))
```

### Interaction Term for Sales Volatility and Tangibility

```R
data <- data %>%
  mutate(RevVol_TFA = Sales_Vol * Tangibility)
```

### Regression Analysis

Model 1:
Key variable: Sales_Vol
Controls: Sales, Size, MB, Cash

Model 2:
Key variable: Tangibility
Controls: Sales, Size, MB, Cash

Model 3:
Key variables: Sales_Vol and Tangibility
Controls: Sales, Size, MB, Cash

Model 4:
Key variables: Sales_Vol and Tangibility
Controls: Sales, Size, MB, Cash, plus industry dummy variables

Model 5:
Key variables: Sales_Vol and Tangibility
Controls: Sales, Size, MB, Cash, plus year dummy variables

Model 6:
Key variables: Sales_Vol and Tangibility
Controls: Sales, Size, MB, Cash, plus both industry and year dummy variables

Model 7:
Key variables: Sales_Vol, Tangibility, and their interaction (RevVol_TFA)
Controls: All of the above control variables

```R
est1 = lm(Debt ~ Sales_Vol + Sales + Size + MB + Cash, data = data)
est2 = lm(Debt ~ Tangibility + Sales + Size + MB + Cash, data = data)
est3 = lm(Debt ~ Sales_Vol + Tangibility + Sales + Size + MB + Cash, data = data)
est4 = lm(Debt ~ Sales_Vol + Tangibility + Sales + Size + MB + Cash + ind, data = data)
est5 = lm(Debt ~ Sales_Vol + Tangibility + Sales + Size + MB + Cash + year, data = data)
est6 = lm(Debt ~ Sales_Vol + Tangibility + Sales + Size + MB + Cash + ind + year, data = data)
est7 = lm(Debt ~ Sales_Vol + Tangibility + RevVol_TFA + Sales + Size + MB + Cash + ind + year, data = data)

est_inter = list(est1, est2, est3, est4, est5, est6, est7)

modelsummary(est_inter,
             fmt = 3,
             stars = c("*" = 0.1, "**" = 0.05, "***" = 0.01),
             output = "est_inter(1).xlsx")
```

## Results and Discussion

![alt text](EN_bankloans_factors_results.png)

The dependent variable in these models is the bank debt ratio (Debt). The main explanatory variables include Sales_Vol, Tangibility, and, in Model 7, their interaction term (RevVol_TFA), while the control variables are Sales, Size, MB, and Cash. Standard errors are shown in parentheses, and the symbols *, **, and *** denote significance at the 10%, 5%, and 1% levels, respectively.

### Hypothesis 1

The first hypothesis posits that companies with higher sales volatility are perceived as having lower repayment capacity, leading to reduced bank borrowing. In models (1) through (6), the coefficient for Sales_Vol is consistently negative and statistically significant. Although Model (7) shows a positive coefficient, it is not statistically significant. This pattern suggests that higher sales volatility is associated with a lower bank debt ratio, thereby largely supporting Hypothesis 1.

### Hypothesis 2

The second hypothesis asserts that companies with a higher proportion of tangible fixed assets can leverage them as collateral to secure more bank loans. Most models display a positive coefficient for Tangibility—ranging from approximately 1.526 to 1.527—and this effect is statistically significant at the 1% or 5% levels. Even in Model (7), Tangibility remains positive (with a coefficient of 4.323**). These findings confirm that a higher tangibility is linked with increased bank borrowing, supporting Hypothesis 2.

## Conclusion

This analysis investigated the determinants of bank borrowing among Japanese listed companies, focusing on the effects of sales volatility and tangible fixed assets. The results indicate that companies with volatile sales tend to exhibit lower bank debt ratios, while those with a higher proportion of tangible assets tend to borrow more. These findings underscore the roles of repayment capacity and collateral in shaping bank lending decisions.

For further discussion or feedback, feel free to connect on [Linkedin](https://www.linkedin.com/in/shokubohcm/).
