class Group < ApplicationRecord
  belongs_to :user, foreign_key: "user_id"
  has_many :purchases, foreign_key: 'group_id', dependent: :delete_all
end
