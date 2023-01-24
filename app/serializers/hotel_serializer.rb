class HotelSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :city, :phone, :country, :image

  has_many :rooms

  belongs_to :user

  def image
    return unless object.image.attached?

    {
      url: rails_blob_url(object.image)
    }
  end
end
