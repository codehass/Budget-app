class Entity < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :groups, foreign_key: 'entity_id', dependent: :delete_all
end
