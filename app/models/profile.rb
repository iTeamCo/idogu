class Profile < ActiveRecord::Base
  belongs_to  :user
  has_many    :attachments, :as => :attachable

  GENDER = ['Male', 'Female']

  def name
    [first_name, last_name].join(' ')
  end

end
