class Task < ActiveRecord::Base
  validates :name, :presence => true
  validates :name, :length => {:in => 3..100}
  validates :name, :uniqueness => {:case_sensitive => false}
  validates :name, :uniqueness => true
  before_save :downcase_name
  belongs_to :list

  scope :not_done, where(:done => false)
  scope :done, where(:done => true)

  private

  def downcase_name
    self.name = self.name.downcase
  end

end