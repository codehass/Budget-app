class Group < ApplicationRecord
  belongs_to :user
  has_many :purchases, foreign_key: 'group_id', dependent: :delete_all

end
