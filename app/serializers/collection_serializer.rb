class CollectionSerializer < ActiveModel::Serializer
  embed :ids

  attributes :id, :name, :description
  has_many :swatches, key: :swatches
end
