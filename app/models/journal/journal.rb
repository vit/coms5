class Journal::Journal < ActiveRecord::Base
  belongs_to :user
  has_many :submissions

  validates :title, :description, :slug, presence: true
  validates :slug, uniqueness: true

#  def create_submission data
#  end

end
