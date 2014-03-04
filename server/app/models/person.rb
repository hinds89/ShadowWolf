class Person
  include Mongoid::Document
  include Mongoid::Timestamps
  include ParamReader

  devise :omniauthable, :trackable, omniauth_providers: [:ldap]

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  embeds_one :applicant

  accepts_nested_attributes_for :applicant

  embeds_one :contact, class_name: 'PersonContact'

  accepts_nested_attributes_for :contact

  embeds_many :conditions

  accepts_nested_attributes_for :conditions

  embeds_one :employee

  accepts_nested_attributes_for :employee

  embeds_one :name, class_name: 'PersonName'

  accepts_nested_attributes_for :name

  def current_condition
    self.conditions.sort_by { |c| c.start_date }.last
  end

  def admin?
    false
  end
end
