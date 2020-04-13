class User < ApplicationRecord
  has_many :widgets
  has_secure_password
end
