# MySQLのデータ移行

## 概要

今回は、RDSにおけるMySQLのデータ移行を実施してみたいと思います。
同一アカウントの別のVPCにあるRDSのデータをエクスポートして、別のVPCのRDSにインポートするという移行です。

## 手順

- ソースRDSインスタンスの情報を確認

```sh
# endpoint
aws rds describe-db-instances --db-instance-identifier <ソースRDSインスタンス識別子> --query 'DBInstances[0].Endpoint.Address'
# port number
aws rds describe-db-instances --db-instance-identifier <ソースRDSインスタンス識別子> --query 'DBInstances[0].Endpoint.Port'
# db name
aws rds describe-db-instances --db-instance-identifier <ソースRDSインスタンス識別子> --query 'DBInstances[0].DBName'
```

- ターゲットRDSインスタンスの情報を確認
  - 手順1と同様に、ターゲットRDSインスタンスのエンドポイント、ポート番号、DB名を確認します。
- ソースRDSインスタンスからデータをエクスポート
  - mysqldumpコマンドを使用して、ソースRDSインスタンスからデータをエクスポートします。

```sh
mysqldump -h <ソースRDSエンドポイント> -P <ポート番号> -u <ユーザー名> -p <DB名> > dump.sql
mysqldump -h iti2-disblogiti2-prd-awsstudyadmin-db-20240322.cx408wcx1k7o.ap-northeast-1.rds.amazonaws.com -P 3306 -u admin -p wordpress > dump.sql
```

- パスワードを求められたら、ソースRDSインスタンスのパスワードを入力します。
- ターゲットRDSインスタンスにデータをインポート
  - mysqlコマンドを使用して、ターゲットRDSインスタンスにデータをインポートします。

```sh
mysql -h <ターゲットRDSエンドポイント> -P <ポート番号> -u <ユーザー名> -p <DB名> < dump.sql
```

- パスワードを求められたら、ターゲットRDSインスタンスのパスワードを入力します。
- データの検証
- ターゲットRDSインスタンスに接続し、データが正しく移行されたことを確認します。

```sh
mysql -h <ターゲットRDSエンドポイント> -P <ポート番号> -u <ユーザー名> -p
```

- パスワードを入力後、以下のコマンドでデータベースを選択し、テーブル一覧を表示します。

```sql
mysql -h iti2-disblogiti2-prd-awsstudyadmin-db-20240322.cx408wcx1k7o.ap-northeast-1.rds.amazonaws.com -u admin -p
[pw:rootroot]
USE <DB名>;
USE wordpress;
SHOW TABLES;
```

- 各テーブルのデータを確認し、移行が成功したことを検証します。

```sql
SELECT * FROM <テーブル名>;
SELECT * FROM wp_posts;
SELECT * FROM wp_users;
```

- 注意点
  - データ移行の前に、ソースRDSインスタンスとターゲットRDSインスタンスのバージョンが互換性があることを確認してください。
  - 移行中はソースRDSインスタンスへの書き込みを停止するか、移行後の差分データを同期する必要があります。
  - 大容量のデータを移行する場合は、ネットワーク帯域幅とストレージのパフォーマンスに注意してください。
  - 本番環境でデータ移行を行う前に、テスト環境で移行手順を検証することを推奨します。