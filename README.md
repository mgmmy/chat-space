# README

# DB 設計

## groups テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |

### Association

- has_many :members
- has_many :users, through: :members
- has_many :messages

## users テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |
| mail   | text   | null: false |

### Association

- has_many :members
- has_many :groups, through: :members
- has_many :messages

## members テーブル

| Column   | Type       | Options           |
| -------- | ---------- | ----------------- |
| user_id  | references | foreign_key: true |
| group_id | references | foreign_key: true |

### Association

- belongs_to :group
- belongs_to :user

## messages テーブル

| Column   | Type       | Options           |
| -------- | ---------- | ----------------- |
| message  | text       |
| image    | text       |
| user_id  | references | foreign_key: true |
| group_id | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :group

### docker-compose

mkdir docker-data/mysql <br/>
でデータベースのディレクトリを作成しておく <br/>
docker-compose up <br/>
でインスタンスを立ち上げ <br/>
docker-compose exec rails bundle exec rake db:setup
でデータベースを作成 <br/>
http://localhost:3001/ <br/>
でブラウザからアクセスできるようになる <br/>

ローカル環境に mysql クライアントがあれば、 <br/>
mysql -u root -h 127.0.0.1 -P3307 -p <br/>
で データベースにアクセスできる
