---
title: What to do before publishing a project created with Django on GitHub
tags: Django Python GitHub Ubuntu gitignore
author: shokubohcm
slide: false
---
As a memorandum

Using wsl Ubuntu-22.04

***
①

```terminal
pip install python-dotenv
```

②

```setting.py
#Under the "Path"
from dotenv import load_dotenv
import os
load_dotenv()

```
<br/>

③
add .env file
<br/>

④
Copy the "SECRET_KEY" in settings.py
↓
paste in .env

```.env
SECRET_KEY = #paste#
DEBUG=false(deployment)
DATABASE_URL=sqlite:///db.sqlite3
# you don't need ''

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
create .gitignore file

（ reference(Japanese)：https://qiita.com/anqooqie/items/110957797b3d5280c44f ）
https://www.toptal.com/developers/gitignore

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
Feel free to handle it however works best.
***
Reference Videos (English)
https://www.youtube.com/watch?v=7tRLkZO6D3Y
https://www.youtube.com/watch?v=fVy9eJzloj8
