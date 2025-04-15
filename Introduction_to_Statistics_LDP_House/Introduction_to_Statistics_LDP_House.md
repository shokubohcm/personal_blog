---
title: 基礎統計学Ⅰ 統計学入門 第3章 3.1, 第12章 12.10（1984年自民党得票率と持ち家比率データ）
tags: 統計学 統計学入門 基礎統計学 統計検定準1級 CSV
author: shokubohcm
slide: false
---
# この記事について
東京大学出版会 統計学入門 (基礎統計学Ⅰ)
https://www.utp.or.jp/book/b300857.html
の練習問題、第3章 3.1と第12章 12.10についての記事です。

# データ
自分自身ネット上にデータが見つからず苦労したので、以下からぜひダウンロードしてください。
**1984年自民党得票率と持ち家比率データ :**
https://github.com/shokubohcm/Introduction_to_Statistics/tree/main/Chapter3/3.1
（LDP=Liberal Democratic Party of Japan, 自民党）

# 解答例（3.1）
おまけに3.1の回答例を載せます。自分はJupyter環境で行いました。
このipynbファイルも上記URLにありますのでよければご利用ください。
## ライブラリ
```
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
```
## データ読み込み
```
df = pd.read_csv(r"...任意のパス\1983_LDP_Homeownership.csv")
df.head()
```
![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3563908/ae98ffb6-7e42-192a-b20a-46d197145082.png)
## データ成形
```
d = df.iloc[0:47,[1,2]]
d.head()
```
![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3563908/b3b849bd-91da-1d74-1c6c-a163ecd237ea.png)
## 散布図作成
```
plt.xlabel(d.columns[0])
plt.ylabel(d.columns[1])
plt.scatter(d.iloc[:, 0], d.iloc[:, 1])
plt.show()
```
![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3563908/73179e78-07d5-b7d8-6685-09339b7b8290.png)
## 各項目に都道府県名を付け加える
```
fig, ax = plt.subplots(figsize=(15,15))
df.plot(df.columns[1], df.columns[2], kind='scatter', ax=ax)
for k, v in df.iterrows():
    ax.annotate(v.iloc[0], xy=(v.iloc[1], v.iloc[2]), size=12)
plt.show()
```
![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3563908/4a1a6254-a7ec-c7fb-ae3e-466f9300c5fb.png)
## 相関係数を求める
```
d.corr()
```
![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3563908/33c8e4a4-1b7b-7097-b4f8-b8252a748dec.png)

ご清覧いただきありがとうございました！
統計の勉強引き続き頑張ります！💪
X: https://x.com/shokubohcm
<br>

参考にさせていただいた記事：https://qiita.com/koplec78/items/9f76cf6a803a1b590049
