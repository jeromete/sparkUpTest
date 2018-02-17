class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  def add_error(error)
    if self.error_message != ''
      self.error_message = self.error_message + ', '
    end
    self.error_message = self.error_message + ' ' + error
  end
end
