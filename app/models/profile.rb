class Profile < ActiveRecord::Base
  belongs_to  :user
  has_many    :attachments, :as => :attachable

#  validates   , :presence => true
  
end
