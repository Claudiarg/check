class Checker < ApplicationRecord
  acts_as_paranoid

  validates :user_id, presence: true

  belongs_to :user
end
