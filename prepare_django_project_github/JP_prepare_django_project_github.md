---
title: Djangoで作成したプロジェクトをGitHubに公開する前の諸々
tags: Django Python GitHub Ubuntu gitignore
author: shokubohcm
slide: false
---
備忘録として

wsl Ubuntu-22.04使用

***
①

```terminal
pip install python-dotenv
```

②

```setting.py
#Pathの下に
from dotenv import load_dotenv
import os
load_dotenv()

```
<br/>

③
.envファイル作成
<br/>

④
settings.pyの"SECRET_KEY"をコピー
↓
.envに貼り付け

```.env
SECRET_KEY = #貼り付け#
DEBUG=false(デプロイ時)
DATABASE_URL=sqlite:///db.sqlite3
# '' は不要

```
⑤

```settings.py
SECRET_KEY = os.environ.get('SECRET_KEY')
```

⑥

```terminal
pip freeze > requirements.txt
```

⑦
.gitignoreファイル作成
（ 参考：https://qiita.com/anqooqie/items/110957797b3d5280c44f ）
https://www.toptal.com/developers/gitignore
←こんなのあるんだ

⑧

```.gitignore
#example
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
*.log
local_settings.py
db.sqlite3
db.sqlite3-journal
instance/
.webassets-cache
.scrapy
docs/_build/
target/
.ipynb_checkpoints
venv/
ENV/
.spyderproject
.spyproject
.idea/
*.iml
.vscode/
node_modules/
.env
.DS_Store
Thumbs.db
```

⑨
よしなに
***
参考動画
https://www.youtube.com/watch?v=7tRLkZO6D3Y
https://www.youtube.com/watch?v=fVy9eJzloj8
