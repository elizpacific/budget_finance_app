class Revenue < ApplicationRecord
  paginates_per 4

  def self.ransackable_attributes(auth_object = nil)
    %w[description sum data]
  end

  validates :sum, presence: true
  validates :data, presence: true
  validates :description, presence: true
end
