class Contact
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_one :mobile

  accepts_nested_attributes_for :mobile

  embedded_in :employee

end
