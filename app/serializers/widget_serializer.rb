class WidgetSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :user

  def attributes(*args)
    super
    
  end
end
