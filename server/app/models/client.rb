class Client
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :building

  field :main, type: String
  field :second_contracting_party, type: String
  field :direct, type: String
  field :end_user, type: String
end
