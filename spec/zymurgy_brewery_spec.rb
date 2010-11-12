require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

## A Brewery encapsulates the properties of a particular brewery setup. Every home brewery is
## unique in terms of equipment, efficiency and local conditions. Parameters include
##   Mash Efficiency
##   Boil Evaporation Rate
##   Water Lost To Mash per kilo of grain
##   Kettle Tax - the volume of liquid left in the kettle once it has been drained
##                as much as possible to the fermenter after the boil.
##

describe "Zymurgy" do

  describe "Brewery" do
    describe "instantiating a Brewery" do
      it "should reveal the Efficiency, Evaporation Rate, Volume Lost To Mash, Kettle Tax it was instantiated with" do
        efficiency_percentage = 61
        evaporation_rate_litres_per_hour = 11
        volume_lost_to_mash_litres_per_kg = 0.82
        kettle_tax_litres = 2
        brewery = Zymurgy::Brewery.new(efficiency_percentage, evaporation_rate_litres_per_hour, volume_lost_to_mash_litres_per_kg, kettle_tax_litres)
        brewery.efficiency_percentage.should == 61
        brewery.evaporation_rate_litres_per_hour.should == 11
        brewery.volume_lost_to_mash_litres_per_kg.should == 0.82
        brewery.kettle_tax_litres.should == 2
      end
    end
  end
end
