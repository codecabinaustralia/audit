class AuditSubmission < ApplicationRecord
  belongs_to :audit
  belongs_to :user
  has_many :responses, :dependent => :destroy
end
