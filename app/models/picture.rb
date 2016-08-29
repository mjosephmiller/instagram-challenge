class Picture < ApplicationRecord
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ActionController::Base.helpers.image_path("https://s9.postimg.org/4oq3qc9vz/pexels_photo_132464.jpg")
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :skills, :interests

end
