# これはなに

- Hasura と PostgreSQL のローカル開発環境を提供するためのスターター
- `make init` コマンドにより以下を提供します
  - Hasura CLI
  - Hasura Server
  - PostgreSQL
    - dbname: postgres
    - username: hasura
    - password: secret

# Requirement

- docker

# Setup

```sh
# ツールとコンテナの準備
#   1. hasura-cli をホストマシンにインストール
#   2. hasura-cli を更新
#   3. docker compose build
#   4. docker compose up
#   5. hasura metadata apply
#   6. hasura migrate apply
$ make init
```

# Usage

## Hasura と PostgreSQL を起動する

```sh
# バックグラウンドで起動するなら
$ make up

# フォアグラウンドで起動するなら
$ make upf
```

## Hasura Console を起動する

```sh
$ make console
```

## DB を再構成 (DROP DB && マイグレーション適用) する

```sh
$ make reset
```

# CI について

- GitHub Actions で下記をテスト (詳細は `.github/workflows/test.yml` を参照)
  - `hasura metadata apply` が正常に完了すること
  - `hasura migrate apply` が正常に完了すること

# M1 Mac の場合

- hasura の イメージ (`hasura/graphql-engine:v2.0.10.cli-migrations-v3`) が使えない
- 代わりのイメージは[こちら](https://github.com/melehin/graphql-engine-arm64)
- `docker-compose.override.yaml` を作成して上書きする

```
$ touch docker-compose.override.yaml
```

- 例:

```yaml
version: '3.8'
services:
  hasura:
    image: fedormelexin/graphql-engine-arm64:v2.0.10.cli-migrations-v3
```
