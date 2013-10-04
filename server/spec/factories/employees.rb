# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee do
    contact { FactoryGirl.build( :contact ) }
    after(:create) do |employee|
      if rand > 0.1
        FactoryGirl.create(:condition, employee: employee, end_date: nil)
      else
        FactoryGirl.create(:condition, employee: employee)
      end
    end
    photo { FactoryGirl.build( :photo ) }
    photo { FactoryGirl.build( :contact ) }
  end
end
