---
title: CAPMにおけるβを数学的に・直感的に理解しようとする
tags: Finance, CAPM, β, Statistics
author: shokubohcm
slide: false
---

## 自己紹介

大学二回の久保田です。最近コーポレートファイナンスの講義でCAPMと$\beta$について学びました。
その際に、単純に共分散/分散と覚えるのは少し気持ち悪く、$\beta$の数学的な意味と直感的な意味を理解しようと思い、まとめてみました。

---

## 目次

- CAPMについて
- CAPMと線形モデル、$β$の公式を導く
- $β$を相関係数と標準分散比で表す

---

### CAPMについて

$$ R_i = R_f + \beta_i(R_m - R_f) \tag{1}$$

- $R_i$ : 資産iの期待収益率
- $R_f$ : 無リスク資産の期待収益率
- $R_m$ : 市場ポートフォリオの期待収益率
- $\beta_i$ : 資産iの市場リスク係数
- $(R_m - R_f)$ : リスクプレミアム

---

### CAPMと線形モデル、βの公式を導く

</br>

$ (1)⇔ R_i - R_f = \beta_i(R_m - R_f) + \epsilon_i $

</br>

$ ⇔ y = \beta x + \epsilon $

とおく。

- $y = R_i - R_f$
- $x = R_m - R_f$
- $\epsilon_i$ : 資産iのリスクプレミアム以外の要因

</br>

ここで、$\beta$は線形モデルの傾きである。
→$β$を最小二乗法(OLS)によって推定することができる。
$$ S=\sum_{i=1}^n((R_i-R_f)-\beta(R_m-R_f))^2 $$
→$β$で微分して$0$になるように求める

</br>

$$ \partial S/\partial \beta = -2 (R_m-R_f)((R_i-R_f)-\beta(R_m-R_f))=0 $$
$$ ⇔\beta = \sum_{i=1}^n(R_i-R_f)(R_m-R_f)/\sum_{i=1}^n(R_m-R_f)^2 \tag{2}$$
ここで、
$$  \sum_{i=1}^n(R_i-R_f)(R_m-R_f) $$は$R_m$と$R_i$の共分散を表し、
$$ \sum_{i=1}^n(R_m-R_f)^2 $$ はマーケットリターンの分散を表すことがわかる。

</br>

→共分散: $R_i$と$R_m$の連動性を示す

→分散: $R_m$の変動を示す

</br>

**$Cov/Var$で、「$R_m$1単位の変動に対して$R_i$がどのくらい影響を受けるか」を知ることが出来る（どれだけ敏感か）**

---

### $β$を相関係数と標準分散比で表す

(2)式を定義に従って変形すると、
$$ \beta = \rho\times\sigma_i/\sigma_m $$
となる。

- $\rho$ : $R_i$と$R_m$の相関係数 ($-1 \leqq \rho \leqq 1$)
- $\sigma_i$ : $R_i$の標準偏差
- $\sigma_m$ : $R_m$の標準偏差

</br>

$\rho$: $R_m$と$R_i$の動きの"動き"と"強さ"を示す

**→これだけで$R_m$との連動性を示すことが出来る**

</br>

$\sigma_i/\sigma_m$: **標準偏差比**

- $\sigma_i/\sigma_m > 1$ : $R_i$は$R_m$より大きく変動
- $\sigma_i/\sigma_m <br 1$ : $R_i$は$R_m$より小さく変動

</br>

**$β$は、$R_m$と$R_i$の相関係数と標準偏差比を掛け合わせたものである。**

---
最後まで読んでいただき、ありがとうございました。
間違いなどあればご指摘いただけると幸いです🙇‍♂️
[Linkedin](https://www.linkedin.com/in/shokubohcm/)
[LinkTree](https://linktr.ee/shokubohcm)
