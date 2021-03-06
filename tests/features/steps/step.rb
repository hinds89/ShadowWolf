require 'uri'
require 'json'
require 'cucumber'
require 'capybara'
require 'capybara/cucumber'
require 'capybara/poltergeist'

ENV['RAILS_ENV'] = 'test'
require '../server/config/environment' # load the rails app

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
OmniAuth.config.test_mode = true

def create_from_hash klass, hash
  if klass.eql? Person
    Person.create do |p|
      p.name = PersonName.new
      p.name.preferred_first = hash['first_name']
      p.name.preferred_last = hash['last_name']
      p.employee = Employee.new
      p.employee.login = hash['login']
      p.employee.contact = EmployeeContact.new
      p.employee.contact.studio = hash['studio']
    end
  elsif klass.eql? Project
    Project.create(project_number: hash['project_number']) do |p|
      p.building = Building.new
      phase = Phase.new
      phase.project_name = hash['project_name']
      p.building.phases << phase
    end
  else raise 'create_from_hash: no such class ' + klass.to_s
  end
end

Before do
  Person.destroy_all
  Project.destroy_all
end

Given /I am a logged in user/ do
  grunt_address = ENV['GRUNT_PORT'].gsub(/^tcp/,'http')
  grunt_address += '/#/callback?'
  rails_address = ENV['RAILS_PORT'].gsub(/^tcp/,'http')
  rails_address += '/people/auth/ldap?redirect_uri='
  rails_address += URI.encode grunt_address
  visit rails_address
  sleep 2
end

Given /the following (.*):/ do |model,objects|
  klass = model.singularize.classify.constantize
  objects.hashes.each do |object|
    create_from_hash klass, object
  end
end

Given /there are (\d+) (.*) in the database/ do |n,model|
  FactoryGirl.create_list model.singularize.to_sym, n.to_i
end

Given /there is 1 (.*) in the database with (\d+) (.*), with a tag/ do |model,n,object|
  n = n.to_i
  p = FactoryGirl.create model.to_sym
  test = Testimonial.new
  p.building.legacy.testimonials = [ test ]
  test.tags = [ 'Some tag' ]
  p.save
end
Given /there is 1 project in the database with project number (.*)/ do |project_number|
  p = FactoryGirl.create :project
  p.project_number = project_number
  p.save
end
Given /I have already visited project show page for (.*)/ do |project_number|
  service_address =
    ENV["GRUNT_PORT"].gsub(/^tcp/,'http')
  visit service_address + '/#/projects'
  sleep 2
  visit service_address + '/#/projects'
  sleep 2
  all( '.demo' ).first.all( 'a' ).last.click
  sleep 5
end
Given /there is 1 (.*) in the database with (\d+) ([^,]*)$/ do |model,n,object|
  n = n.to_i
  p = FactoryGirl.create model.to_sym
  if model == 'project'
    if object.singularize == 'testimonial'
      p.building.legacy.testimonials = [ ]
      n.times { p.building.legacy.testimonials << Testimonial.new }
    else
      attention = Attention.new body_text: 'stuff'
      press = BuildingPress.new
      press.attentions = [attention]
      p.building.presses = [ press ]
    end
  elsif model == 'person'
    condition = Condition.new
    p.conditions = [ condition ]
  end
  p.save
end

When /I visit the (.*) (.*) index/ do |service,path|
  service_address =
    ENV["#{service.upcase}_PORT"].gsub(/^tcp/,'http')
  visit service_address + path
  sleep 2
  visit service_address + path
  sleep 2
end

When /I click the '(.*)' (.*) tag/ do |text,element|
  find( element, text: text ).trigger 'click'
end

When /I click the remove testimonial button/ do
  button = all( "[ng-repeat*=\"testimonial\"]" ).first.find( 'button', text: '×' )
  button.click
  sleep 2
end

When /I type '(.*)' into the (.*)/ do |text,element|
  fill_in element, with: text
end

When /I click on the first (.*)'s display box/ do |model|
  all( '.demo' ).first.all( 'a' ).last.click
  sleep 5
end
When /I click on the (.*) (.*) tab/ do |model,tab|
  find( '.nav-tabs' ).find( 'a', text: tab.capitalize ).click
end

Then /there should be (\d+) display box/ do |n|
  sleep 2
  count = all('.info-box').count 
  if count != n.to_i 
    raise "Expected #{n} display boxes, found: #{count}"
  end
end

Then /the '(.*)' (.*) tag should( not)? be present/ do |text,element,negate|
  if negate
    assert_no_selector element, text: text
  else
    assert_selector element, text: text
  end
end

Then /there should be (\d+) json (.*)/ do |n,model|
  klass = model.singularize.classify.constantize
  object_ids = JSON.parse(find('pre').text).map do |p|
    p['id']['$oid'] 
  end
  objects_in_db = klass.find object_ids
  raise "#{n} #{model.pluralize} not found" unless objects_in_db.count == n.to_i
end

Then /the search bar should have focus/ do
  if evaluate_script('document.activeElement.id') != 'searchBar'
    raise 'Search bar should be focused'
  end
end

When /I click the add (.*) (.*) button/ do |model,objects|
  object = objects.singularize
  all( "[ng-repeat*=\"#{object} in #{model}.#{objects}\"]" )
    .last
    .find( 'a', text: 'Add' )
    .click
  sleep 2
end

When /I click on the (.*) editable$/ do |property|
  all( "[property=\"#{property}\"] .editable-output" ).first.click
  sleep 2
end

When /I submit "(.*)" to the (.*) input for the (.*) property/ do |text, name, prop|
  fill_in( name , with: text )
  all( "[property=\"#{prop}\"]" )
    .first
    .find( '.editable-input' )
    .find( '[title="save"]'  )
    .click
  sleep 2
end

When /I click on the cross for the first testimonial tags editable tag/ do
  all( '[property="tags"] .editable-output .tags li:first-child a' ).first.click
  sleep 2
end

Then /the (.*) editable should display "(.*)"/ do |property,text|
  x = find( "[property=\"#{property}\"]" )
  y = x.find( '.editable-output' )
  actual_text = y.find( '.editable-text-display' ).text
  unless actual_text == text
    raise "Expected #{property} editable's text to be: #{text}, found: #{actual_text}"
  end
end

Then /my suffix should equal "Jr."/ do
  suffix = Person.first.name.suffix
  unless suffix == 'Jr.'
    raise "Expected suffix to be 'Jr.', found : #{suffix}"
  end
end

Then /there should be 2 (.*) (.*) editable groups/ do |model, object|
  objects = object.pluralize
  count = all( "[ng-repeat*=\"#{object} in #{model}.#{objects}\"]" ).count
  raise "Expected 2 #{model} #{objects} editable groups, found: #{count.to_s}" if count != 2
end

Then /there should be 1 testimonial in the database/ do
  proj = Project.first
  count = proj.building.legacy.testimonials.count
  raise "Expected 1 testimonial found #{count}" if count != 1
end

Then /I should have 1 (.*) in the database with (.*)/ do |model,qualifier|
  sleep 2 
  if qualifier == '2 conditions'
    count = Person.count
    raise 'Expected 1 person found: ' + count if count != 1
    count = Person.first.conditions.count
    raise 'Expected 2 conditions found: ' + count if count != 2
  elsif qualifier == "tag 'New Tag' on its testimonial"
    unless Project.first.building.legacy.testimonials.first.tags.include? 'New Tag'
      raise 'Testimonial should have tag \'New Tag\''
    end
  elsif qualifier == 'no tags on its testimonial'
    if Project.first.building.legacy.testimonials.first.tags.length > 0
      raise 'Found tag on testimonial when there should be none.'
    end
  end
end

Then /on the Project Sheets tab there exists a tab for 'New Tag'/ do
  find( '.nav-tabs' ).find( 'a', text: 'Project Sheets' ).click
  newTagTab = all(  '.nav-tabs' )[1].find( 'a', text: 'New Tag' )
  raise '\'New Tag\' tab does not exist' if newTagTab.nil?
end
Then /the background image/ do
  info_box = find '.info-box'
  raise 'fail' if info_box[:style].include? 'kitten'
end
