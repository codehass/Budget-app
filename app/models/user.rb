class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  has_many :groups, foreign_key: 'author_id', dependent: :delete_all
  has_many :entities, foreign_key: 'author_id', dependent: :delete_all
end
