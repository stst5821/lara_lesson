参考サイト：
https://qiita.com/ucan-lab/items/56c9dc3cf2e6762672f4

コンテナ  
nginx 1.18  
php 7.4.16  
composer 導入済み
npm 導入済み

npm 導入参考サイト：  
https://tsyama.hatenablog.com/entry/docker-not-found-npm

## コンテナの名前を変更する

このテンプレを使ってすでに他のコンテナを作っていた場合、
コンテナ名がかぶって起動できなくなるので、コンテナ名を変更する必要がある。

[変更箇所]

- docker-compose.yml

```
services:
サービス名（app,web,db）を変更する。

※container_name: db　が書かれていると、こちらの名前が優先されてしまうので、
記述そのものを消すか、名前を変更する。
```

- default.conf

```
location ~ \.php$ {
        fastcgi_pass app:9000; // ←ここの「app」をdocker-compose.ymlで変更したappのコンテナ名と同じにする。（app→testAppに変更したなら、こちらもtestAppに変える。）
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }
```

## コンテナ起動方法

docker-compose up -d

## laravel 導入

コンテナに入る

```
docker-compose exec [コンテナ名] bash
```

Laravel インストール

- 最新の Laravel をインストールする場合

```
composer create-project laravel/laravel .
```

※　 laravel/laravel のあとの「.」は、現在のディレクトリにインストールするという意味。
作るプロジェクトの名前と勘違いして名前をつけると、その名前のディレクトリにインストールされてしまい、URL にアクセスしても 404 になってしまうので注意する。

- バージョンを選択してインストールする場合

```
composer create-project --prefer-dist "laravel/laravel=７.*" .
```

php artisan -V // バージョン確認

composer create-project --prefer-dist "laravel/laravel=７.\*" .  
を実行後、エラーになる場合

app コンテナに入り、
`ls -a`
を実行する  
.DS_store というファイルがあった場合は、  
`find -name ".DS_Store" -delete`  
で削除してから、再度実行すると、インストールできる。

以下のサイトを開き、laravel のトップ画面が開けば OK
http://localhost:8080/

## PgAdmin4

### 使い方

- ログイン方法

以下にアクセス
http://localhost:81/

mailaddress と password は docker-compose.yml を見る

あとは以下を見ながら進める。

docker compose を使って PostgreSQL を構築する  
https://mebee.info/2020/12/04/post-24686/

Hostname/address を調べる方法  
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' [コンテナ名]

テーブルの確認方法  
https://postgresweb.com/post-3926
