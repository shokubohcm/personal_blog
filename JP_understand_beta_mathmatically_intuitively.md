# CAPMにおけるβを数学的に・直感的に理解しようとする
### 自己紹介
### 目次
- [CAPM](#CAPM)
- [CAPMと線形モデル](#CAPMと線形モデル)
- [βを相関係数と標準分散比で表す](#βを相関係数と標準分散比で表す)

### CAPM
$$ R_i = R_f + \beta_i(R_m - R_f) $$
- $R_i$ : 資産iの期待収益率
- $R_f$ : 無リスク資産の期待収益率
- $R_m$ : 市場ポートフォリオの期待収益率
- $\beta_i$ : 資産iの市場リスク係数
- $(R_m - R_f)$ : リスクプレミアム

### CAPMと線形モデル
$$ ⇔ R_i - R_f = \beta_i(R_m - R_f) + \epsilon_i $$
$$ ⇔ y = \beta x + \epsilon $$
とおく。
- $y = R_i - R_f$
- $x = R_m - R_f$
- $\epsilon_i$ : 資産iのリスクプレミアム以外の要因
ここで、$\beta$は線形モデルの傾きである。
→βをOLSによって推定することができる。















$$ \beta = \rho\times\sigma_i/\sigma_m $$