require 'beryl/entity'

class MusicNote < Beryl::Entity
  property :first_name, String, :required
  property :user, User
  property :orders, [Order], :required
end