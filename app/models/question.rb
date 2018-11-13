class Question < ApplicationRecord
  belongs_to :audit
  has_many :responses, :dependent => :destroy
end
