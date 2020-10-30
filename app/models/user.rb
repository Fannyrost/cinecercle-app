class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_one_attached :photo

  def self.from_omniauth(auth)
   self.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.email = auth.info.email
     user.pseudo = auth.info.name
     # dowloaded_image = auth.info.image
     # cloudinary_image = Cloudinary::Uploader.upload(dowloaded_image, public_id: auth.uid)
     # cloudinary_url = cl_image_tag(auth.uid)
     # user.photo.attach(io: cloudinary_url, filename: auth.uid)
     user.provider = auth.provider
     user.uid = auth.uid
     user.password = Devise.friendly_token[0,20]
   end
  end
end
