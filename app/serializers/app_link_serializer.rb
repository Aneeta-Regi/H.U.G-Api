class AppLinkSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :link, :sort_order, :icon
end
