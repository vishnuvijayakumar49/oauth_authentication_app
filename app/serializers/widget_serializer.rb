class WidgetSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :kind, :owner
  has_one :user
end
