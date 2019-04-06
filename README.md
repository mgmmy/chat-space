# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# DB設計

## groupsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|member_id|integer|null: false, foreign_key: true|

### Association
- has_many :members
- has_many :users, through: :members


## usersテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|mail|text|null: false|
|member_id|integer|null: false, foreign_key: true|

### Association
- has_many :members
- has_many :groups, through: :members
- has_many :messages


## membersテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user


## messagesテーブル

|Column|Type|Options|
|------|----|-------|
|message|text|
|image|text|
|user_id|integer|null: false, foreign_key: true|
|created_at|timestamps|null: false|

### Association
- belongs_to :user
