class Attachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  belongs_to :user

  has_attached_file :assets,
    styles: {
      thumb: "100x100>",
      small: "300x300>",
      large: "600x600>"
    }
end
