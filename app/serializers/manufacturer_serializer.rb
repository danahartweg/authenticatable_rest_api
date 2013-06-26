class ManufacturerSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :web_address
end
