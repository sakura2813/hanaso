## テーブル設計

---

### ■ Users テーブル

| Column             | Type       | Options                        |
|--------------------|------------|--------------------------------|
| id                 | integer    | PRIMARY KEY                    |
| nickname           | string     | null: false                    |
| email              | string     | null: false, unique: true      |
| encrypted_password | string     | null: false, default: ""       |
| created_at         | datetime   | null: false                    |
| updated_at         | datetime   | null: false                    |

**Association**

- has_many :chats, dependent: :destroy
- has_many :messages, through: :chats

---

### ■ Chats テーブル

| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| id          | integer    | PRIMARY KEY                    |
| user_id     | integer    | null: false, foreign_key: true |
| category    | string     | null: false                    |
| symptom_id  | integer    | foreign_key: true, optional    |
| created_at  | datetime   | null: false                    |
| updated_at  | datetime   | null: false                    |

**Association**

- belongs_to :user
- belongs_to :symptom, optional: true
- has_many   :messages, dependent: :destroy

---

### ■ Messages テーブル

| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| id          | integer    | PRIMARY KEY                    |
| chat_id     | integer    | null: false, foreign_key: true |
| sender      | string     | null: false                    |
| content     | text       | null: false                    |
| created_at  | datetime   | null: false                    |
| updated_at  | datetime   | null: false                    |

**Association**

- belongs_to :chat

---

### ■ Symptoms テーブル

| Column          | Type       | Options     |
|-----------------|------------|-------------|
| id              | integer    | PRIMARY KEY |
| title           | string     | null: false |
| description     | text       |             |
| self_care       | text       |             |
| emergency_level | integer    |             |
| created_at      | datetime   | null: false |
| updated_at      | datetime   | null: false |

**Association**

- has_many :chats

---

### ■ Columns テーブル

| Column       | Type       | Options     |
|--------------|------------|-------------|
| id           | integer    | PRIMARY KEY |
| title        | string     | null: false |
| content      | text       |             |
| published_at | datetime   |             |
| created_at   | datetime   | null: false |
| updated_at   | datetime   | null: false |

**Association**

- (お気に入り機能追加時) has_many :favorites
- (お気に入り機能追加時) has_many :users, through: :favorites  

