LOG_LEVEL := INFO

.PHONY: init
init: ## リポジトリを clone したら最初に叩くコマンド
	curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | bash
	hasura update-cli --version v2.0.1
	@docker compose build --no-cache
	@make up
	@make apply

.PHONY: up
up: ## バックグラウンドで起動
	@docker compose up -d --build

.PHONY: upf
upf: ## フォアグラウンドで起動
	@docker compose up

.PHONY: console
console:
	@hasura console

.PHONY: drop
drop: ## DB を破棄する
	@docker compose down db
	@docker compose up -d db
	@docker compose exec db sh -c "PGPASSWORD=secret dropdb postgres -h db -U hasura"

.PHONY: create
create: ## DB を構築する
	@docker compose up -d db
	@docker compose exec db sh -c "PGPASSWORD=secret createdb postgres -h db -U hasura"

.PHONY: apply
apply: ## マイグレーションを適用する
	@docker compose up -d
	@until curl -s -o /dev/null http://127.0.0.1:8081/healthz; do sleep 1; done
	hasura metadata apply
	hasura migrate apply --database-name default
	hasura metadata reload

.PHONY: reset
reset: ## DB を再構築 -> マイグレーションを適用
	make drop
	make create
	make apply

.PHONY: bash
bash: ## コンテナに入る
	@docker compose exec hasura bash

.PHONY: schemaspy
schemaspy:
	@docker run --rm --net="host" -v $(PWD)/tmp/schemaspy:/output schemaspy/schemaspy:latest \
		-u hasura \
		-p secret \
		-db postgres \
		-t pgsql \
		-host localhost \
		-port 5432 && \
		open $(PWD)/tmp/schemaspy/index.html
