class Audit < ApplicationRecord
  belongs_to :user, required: false
  has_many :questions, :dependent => :destroy
  has_many :audit_submissions, :dependent => :destroy
end
