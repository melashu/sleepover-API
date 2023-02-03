class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :name, :role
end
