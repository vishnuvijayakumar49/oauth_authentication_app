class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :images, :first_name, :last_name, :date_of_birth, :email, :active
  has_many :widgets
end
