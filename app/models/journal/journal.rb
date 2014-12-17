class Journal::Journal < ActiveRecord::Base
  belongs_to :user
  validates :title, :description, :slug, presence: true
  validates :slug, uniqueness: true
end
