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

# Hasura Console を起動
$ make console
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
  - `hasura migrate apply` が正常に完了すること
  - `hasura metadata apply` が正常に完了すること

# TODO

- csv ファイルで Seed データを投入できるようにする