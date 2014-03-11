def index_and_row_to_location index, row, building
  lo = Location.new building: building
  geo = GeoJson.new location: lo
  geo.lat = row[index+4].split(',')[0].tr('(','')
  geo.long = row[index+4].split(',')[1].tr(')','')
  ad = Address.new location: lo
  ad.building_name = row[index]
  ad.postcode = row[index+1]
  ad.state_county = row[index+2] + ' ' + row[index+3] # TODO check
  ad.county = row[index+3]
  ad.street = row[index+5]
  ad.suburb_area = row[index+5]
  lo
end

def row_to_project row
  p = Project.new
  p.project_number = row[0]
  p.project_categories = row[16]

  b = Building.new project: p
  b.description = row[10]

  ph = Phase.new building: b
  ph.studio = row[1]
  ph.project_name = row[2]
  ph.client = row[4]
  ph.dirty_date = row[5]
  ph.services_scope = row[13]
  ph.delivery_contract = row[14]
  ph.dirty_members = row[17]

  ph.dirty_budget = row[6]
  ph.comments = row[7]
  ph.initial_phase_value_total = row[9]

  dims = DimensionGroup.new building: b
  dims.dirty_size = row[15]

  ps = ProjectSource.new building: b
  ps.competition_win = row[8]

  rfb = ReferredBy.new project_source: ps
  rfb.contact_name = row[11]
  rfb.BVN_staff_login = row[2]

  l = Location.new building: b
  a = Address.new location: l
  a.state_country = row[18]

  le = Legacy.new building: b
  aw = Award.new legacy: le
  aw.award = row[19]

  b.locations << index_and_row_to_location 21, row, b
  b.locations << index_and_row_to_location 30, row, b
  b.locations << index_and_row_to_location 39, row, b

  p
end