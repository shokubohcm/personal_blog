# パッケージの読込（dplyr, readr, openxlsx, modelsummary）
library(dplyr)
library(readr)
library(openxlsx)
library(modelsummary)

# データをインポートする
data = read_csv("all_2024_num.csv")

# 非金融業に属する企業と時価総額がある企業に限定する
source("label_20240929.R")

data = data |>
  filter(!grepl("銀行|保険|証券|その他|金融|-", g31))

data = data |>
  filter(!is.na(mv))

# 分析に必要な6つの変数を作成する

data = data |>
  mutate(
    b8 = as.numeric(b8),
    b11 = as.numeric(b11),
    b45 = as.numeric(b45),
    a40 = as.numeric(a40),
    d1 = as.numeric(d1),
    a40 = as.numeric(a40),
    a12 = as.numeric(a12),
    a5 = as.numeric(a5),
  )

# ここでb8,b11,b45に欠損値がある→合計のため0に変換

data = data |>
  mutate(b8=case_when(is.na(b8)~ 0,
                      TRUE ~ b8),
         b11=case_when(is.na(b11)~ 0,
                       TRUE ~ b11),
         b45=case_when(is.na(b45)~ 0,
                       TRUE ~ b45)
  )

# d1, a12, a5について、各企業の平均値で埋める
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

# ５：産業： 年ダミー変数を作成する
data = data |>
  mutate(ind=as.factor(g31))

data = data |>
  mutate(year=NA_real_) 


for (i in 2000:2024) {
  data = data |>
    mutate(year=case_when(grepl(i, fy) ~ i,
                          TRUE ~ year)
    )
}


data = data |>
  mutate(year=as.factor(year))

# ６：売上高ボラティリティと有形固定資産の交差項を作成する
data <- data %>%
  mutate(RevVol_TFA = Sales_Vol * Tangibility)

# ７：回帰分析（観測値数は約 8 万）
est1 = lm(Debt ~ Sales_Vol + Sales + Size + MB + Cash, data=data)
est2 = lm(Debt ~ Tangibility + Sales + Size + MB + Cash, data=data)
est3 = lm(Debt ~ Sales_Vol + Tangibility + Sales + Size + MB + Cash, data=data)
est4 = lm(Debt ~ Sales_Vol + Tangibility + Sales + Size + MB + Cash + ind, data=data)
est5 = lm(Debt ~ Sales_Vol + Tangibility + Sales + Size + MB + Cash + year, data=data)
est6 = lm(Debt ~ Sales_Vol + Tangibility + Sales + Size + MB + Cash + ind + year, data=data)
est7 = lm(Debt ~ Sales_Vol + Tangibility + RevVol_TFA + Sales + Size + MB + Cash + ind + year, data=data)

est_inter = list(est1, est2, est3, est4, est5, est6, est7)

modelsummary(est_inter,                             
             fmt=3,                                     
             stars = c("*"=0.1, "**"=0.05, "***"=0.01), 
             output = "est_inter(1).xlsx") 