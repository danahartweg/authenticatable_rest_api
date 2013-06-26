class SwatchSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :thumb_link, :img_link
end
