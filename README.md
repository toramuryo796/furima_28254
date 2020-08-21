
# テーブル設計

## users テーブル
| Column                | type    |   Options    |
|-----------------------|---------|--------------|
| nickname              | string  | null: false  |
| email                 | string  | null: false  |
| password              | string  | null: false  |
| password_confirmation | string  | null: false  |
| first_name            | string  | null: false  |
| family_name           | string  | null: false  |
| first_name_reading    | string  | null: false  |
| family_name_reading   | string  | null: false  |
| birth_date            | date    | null: false  |

### Association

- has_many :items
- has_many :purchases

## Items テーブル
| Column         | type       |   Options                      |
|----------------|------------|--------------------------------|
| title          | string     | null: false                    |
| text           | text       | null: false                    |
| price          | integer    | null: false                    |
| category_id    | integer    | null: false                    |
| status_id      | integer    | null: false                    |
| fee_id         | integer    | null: false                    |
| origin_area_id | integer    | null: false                    |
| take_day_id   | integer    | null: false                    |
| user           | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase
- has_one_attached :image
- belongs_to_active_hash :category
- belongs_to_active_hash :status
- belongs_to_active_hash :fee
- belongs_to_active_hash :origin_area
- belongs_to_active_hash :take_day

## purchases テーブル
| Column | type       |   Options                       |
|--------|------------|---------------------------------|
| user   | references | null: false, foreign_key: true  |
| item   | references | null: false, foreign_key: true  |

### Association 
- belongs_to :user
- belongs_to :item
- has_one :destination

## destinations テーブル
| Column       | type       |   Options                       |
|--------------|------------|---------------------------------|
| postal_code  | string     | null: false                     |
| origin_area  | integer    | null: false                     |
| city         | string     | null: false                     |
| house_number | string     | null: false                     |
| building_name| string     | null: false                     |
| phone_number | string     | null: false                     | 
| purchase     | references | null: false, foreign_key: true  |

### Association
- belongs_to :purchase