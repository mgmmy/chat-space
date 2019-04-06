# README

# DB設計

## groupsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|user_id|integer|through: :members|
|member_id|integer|

### Association
- has_many :members
- has_many :users
- has_many :messages


## usersテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|mail|text|null: false|
|group_id|integer|through: :members|
|member_id|integer|

### Association
- has_many :members
- has_many :groups
- has_many :messages


## membersテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|group_id|references|foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user


## messagesテーブル

|Column|Type|Options|
|------|----|-------|
|message|text|
|image|text|
|user_id|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :group
