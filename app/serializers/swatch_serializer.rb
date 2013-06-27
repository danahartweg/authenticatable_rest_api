class SwatchSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :thumb_link, :img_link, :updated_at, :collection_id, :manufacturer_id
  attribute :updated_at, key: :last_updated
end
