class Legacy
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :quotes

  accepts_nested_attributes_for :quotes

  embeds_many :testimonials

  accepts_nested_attributes_for :testimonials

  embeds_many :awards

  accepts_nested_attributes_for :awards

  embeds_one :photography

  accepts_nested_attributes_for :photography

  embeds_one :esd, class_name: 'EnvironmentalSustainableDesign'

  accepts_nested_attributes_for :esd

  embedded_in :building

  field :one_line_grab, type: String
  field :description_project_sheet, type: String
  field :description_200_500_words, type: String
  field :description_awards_style, type: String
  field :innovation_client_style, type: String
  field :interesting_things, type: String
  field :brief_elements, type: String
  field :security_level, type: String
end
