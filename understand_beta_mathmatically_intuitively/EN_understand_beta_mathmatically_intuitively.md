---
title: Try to Understand β in CAPM Mathematically and Intuitively Approach
tags: Finance, CAPM, β, Statistics
author: shokubohcm
slide: false
---

## Introduction

I’m Sho Kubota, a sophomore at university.
Recently, I attended a corporate finance lecture where I learned about CAPM and $\beta$.
Instead of simply memorizing the "covariance/variance" formula, I wanted to explore the mathematical and intuitive significance of $\beta$.
Here’s a summary of my findings.

---

## Table of Contents

- About CAPM
- Deriving the CAPM Linear Model and $\beta$ Formula
- Expressing $\beta$ Using Correlation Coefficients and Standard Deviation Ratios

---

### About CAPM

$$ R_i = R_f + \beta_i(R_m - R_f) \tag{1}$$

- $R_i$: Expected return of asset $i$
- $R_f$: Expected return of the risk-free asset
- $R_m$: Expected return of the market portfolio
- $\beta_i$: Market risk coefficient of asset $i$
- $(R_m - R_f)$: Risk premium

---

### Deriving the CAPM Linear Model and $\beta$ Formula

</br>

$ (1) \Leftrightarrow R_i - R_f = \beta_i(R_m - R_f) + \epsilon_i $

</br>

$ \Leftrightarrow y = \beta x + \epsilon $

Let:

- $y = R_i - R_f$
- $x = R_m - R_f$
- $\epsilon_i$: Factors affecting asset $i$ other than the risk premium

</br>

In this context, $\beta$ represents the slope of the linear model.
→ $\beta$ can be estimated using the Ordinary Least Squares (OLS) method.
$$ S=\sum_{i=1}^n((R_i-R_f)-\beta(R_m-R_f))^2 $$
→ Differentiate $S$ with respect to $\beta$ and solve for $\beta$ when the derivative equals $0$.

</br>

$$ \partial S/\partial \beta = -2 (R_m-R_f)((R_i-R_f)-\beta(R_m-R_f))=0 $$
$$ \Leftrightarrow \beta = \sum_{i=1}^n(R_i-R_f)(R_m-R_f)/\sum_{i=1}^n(R_m-R_f)^2 \tag{2}$$

Here:

- $$ \sum_{i=1}^n(R_i-R_f)(R_m-R_f) $$ represents the covariance between $R_m$ and $R_i$.
- $$ \sum_{i=1}^n(R_m-R_f)^2 $$ represents the variance of market returns.

</br>

→ Covariance: Indicates the co-movement between $R_i$ and $R_m$.

→ Variance: Indicates the fluctuation of $R_m$.

</br>

**By using $Cov/Var$, we can understand "how much $R_i$ is affected by a unit change in $R_m$" (sensitivity).**

---

### Expressing $\beta$ Using Correlation Coefficients and Standard Deviation Ratios

By rearranging equation (2) based on its definitions:
$$ \beta = \rho\times\sigma_i/\sigma_m $$

- $\rho$: Correlation coefficient between $R_i$ and $R_m$ ($-1 \leqq \rho \leqq 1$)
- $\sigma_i$: Standard deviation of $R_i$
- $\sigma_m$: Standard deviation of $R_m$

</br>

$\rho$: Indicates the "direction" and "strength" of the relationship between $R_m$ and $R_i$.

**→ This alone indicates the co-movement with $R_m$.**

</br>

$\sigma_i/\sigma_m$: **Standard deviation ratio**

- $\sigma_i/\sigma_m > 1$: $R_i$ fluctuates more than $R_m$.
- $\sigma_i/\sigma_m < 1$: $R_i$ fluctuates less than $R_m$.

</br>

**$\beta$ is the product of the correlation coefficient between $R_m$ and $R_i$ and their standard deviation ratio.**

---

Thank you for reading to the end.
If you notice any errors, I would greatly appreciate your feedback. 🙇‍♂️
[Linkedin](https://www.linkedin.com/in/shokubohcm/)
[LinkTree](https://linktr.ee/shokubohcm)
