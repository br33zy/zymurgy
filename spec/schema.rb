ActiveRecord::Schema.define(:version => 0) do

  create_table "breweries", :force => true do |t|
    t.string   "name"
    t.string   "head_brewer"
    t.float    "mash_efficiency_percentage"
    t.float    "evaporation_rate_litres_per_hour"
    t.float    "volume_lost_to_mash_litres_per_kg"
    t.float    "kettle_tax_litres"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brews", :force => true do |t|
    t.string   "name"
    t.string   "brewer"
    t.float    "original_gravity"
    t.float    "final_gravity"
    t.float    "fermentation_volume_litres"
    t.integer  "boil_time_minutes"
    t.integer  "brewery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fermentables", :force => true do |t|
    t.string   "name"
    t.boolean  "mash"
    t.float    "points_per_kg_per_litre"
    t.float    "weight_in_kg"
    t.integer  "brew_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

#  create_table "hop_additions", :force => true do |t|
#    t.string   "name"
#    t.float    "alpha_acid_percentage"
#    t.float    "weight_grams"
#    t.float    "boil_time_minutes"
#    t.integer  "brew_id"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end

end
