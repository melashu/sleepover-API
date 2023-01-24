class RoomSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :room_no, :number_of_bed, :photo

  belongs_to :hotel

  def photo
    return unless object.photo.attached?

    {
      url: rails_blob_url(object.photo)
    }
  end
end
