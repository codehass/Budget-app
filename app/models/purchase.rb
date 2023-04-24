class Purchase < ApplicationRecord
  belongs_to :group, class_name: 'Group'
  belongs_to :entity, class_name: 'Entity'
end