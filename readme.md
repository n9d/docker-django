# poetry+djangoのdockerの作り方


## docker-compose.yml

```sh
services:
  srv:
    image: python:3.11
    volumes:
      - .:/src
    working_dir: /src
    tty: true
    ports:
      - 8000:8000
    command: >
      sh -c "pip install poetry &&
            poetry config virtualenvs.create false &&
            poetry config virtualenvs.in-project true &&
            if [ ! -f pyproject.toml ]; then poetry init -q; fi &&
            poetry install
            bash"
```

## django導入

```sh
$ docker-compose up -d
```

一番最初はpoetryのインストール等に時間がかかるので10秒ぐらい待つ（その後は速い）

```sh
$ docker-compose exec srv poetry add django
$ docker-compose exec srv django-admin startproject project .
$ docker-compose restart
```

http://localhost:8000/ で参照する

### 開発用の各種パッケージ導入

```sh
$ docker-compose exec srv poetry add --group dev pytest pytest-django flake8 black django_extensions ipython
```

## 本番サーバ用のDockerfile

- Dockerfile参照のこと
- 必要に応じ gnicornにすること（今回は面倒なのでパス)

