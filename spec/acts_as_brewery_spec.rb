require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Confirm test schema is loaded correctly" do
  before do
    load_schema
  end

  class Brewery < ActiveRecord::Base
  end

  it "should load test schema correctly" do
    Brewery.all.should eql []
  end
end

describe "Can act_as_brewery" do
  before do
    load_schema
  end

  class Brewery < ActiveRecord::Base
    acts_as_brewery
  end

  # Token test to prove the acts_as mechanism is working
  it "can increase kettle_tax_litres" do
    brewery = Brewery.new()
    brewery.kettle_tax_litres=(2.0)
    brewery.add_litres_to_kettle_tax(2)
    brewery.kettle_tax_litres.should == 4.0
  end
end