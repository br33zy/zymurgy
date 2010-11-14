require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

## A fermentable is anything you put into a brew recipe to provide
## the sugars which the yeast can eat (to produce CO2 and of course alcohol).
## Fermentables include:
##      Grains (malted or otherwise) such as barley and wheat.
##      Goop cans such as you buy at home brew shops.
##      Fruit
##      Honey  (mead anyone?)
##      Sugar itself
##
##      Most grains need to be mashed (soaked in hot water) before fermenting to
##      release their sugars. Fruit, honey, sugars obviously don't need to be.
##
##      Efficiency or Mash Efficiency represents the proportion of the total sugars
##      in the grain that are made available by the mashing process. Efficiency is
##      unique to each brewhouse.
##
##      The sugars contained in fermentables are measured in terms of Specific Gravity.
##      The starting or original gravity of a beer represents the amount of sugar
##      present at the start of the fermentation. Each fermentable contributes
##      'gravity points' or points towards the total Original Gravity.
##
##      The amount of sugar available in a particular fermentable is represented
##      by specific gravity points per weight unit. E.g. Points per kg; or points per pound.
##      For the brew itself, the sugars contributed are measured in terms of points
##      per kg (or pound) per litre (or gallon) of fermenter volume.
##
##      E.g 5.24kg of pilsner malt (which yields 300 points per kg per litre at 100%
##          efficiency) in a 27l fermenter, gives up 35.52 gravity points after mashing
##          with an efficiency of 61%. This provides an original gravity
##          of 1.03552 for the brew.
##

# TODO: Is mashable? Can that be a mixin?
describe "Zymurgy" do
  before do
    @brewery = mock('A Brewery')
    @brewery.stub!('efficiency_percentage').and_return(61)    
    @brew = mock('A Brew Recipe')
    @brew.stub!('class').and_return('Zymurgy::Brew')
    @brew.stub!('brewery').and_return(@brewery)
    @brew.stub!('original_gravity').and_return(1045)
    @brew.stub!('fermentation_volume_litres').and_return(25.0)
    @brew.stub!('post_boil_volume_litres').and_return(27.0)
    @brew.stub!('mash_out_volume_litres').and_return(38)

    @params = {
        'mash' => true,
        'points_per_kg_per_litre' => 300.0,
        'weight_in_kg' => 5.24,
    }
  end
  describe "Fermentable" do
    describe "instantiating a Brew" do
      it "should provide readers for the Brew and parameters it is instantiated with" do
        fermentable = Zymurgy::Fermentable.new(@brew, @params)
        fermentable.brew.original_gravity.should == 1045
        fermentable.mash.should == true
        fermentable.points_per_kg_per_litre.should == 300
        fermentable.weight_in_kg.should == 5.24
      end

      it "should provide writers for the parameters it is instantiated with, but not the Brew" do
        fermentable = Zymurgy::Fermentable.new(@brew, @params)
        fermentable.should_not respond_to(:brew=)
        fermentable.should respond_to(:mash=)
        fermentable.should respond_to(:points_per_kg_per_litre=)
        fermentable.should respond_to(:weight_in_kg=)
      end

      it "should complain if not provided with a valid Zymurgy::Brew object" do
        lambda {Zymurgy::Fermentable.new('a coffee', @params)}.should raise_error()
      end

      it "should set default values when parameters aren't provided" do
        fermentable = Zymurgy::Fermentable.new(@brew)
        fermentable.mash.should == false
        fermentable.points_per_kg_per_litre.should == 300
        fermentable.weight_in_kg.should == 1.7
      end
    end

    # TODO: Only include efficiency when mash == true.
    describe "Performing fermentable calculations" do
      it "should calculate the gravity points contributed towards the post boil volume" do
        fermentable = Zymurgy::Fermentable.new(@brew, @params)
        fermentable.post_boil_volume_gravity_points.round_dp(2).should == 35.52
      end

      it "should calculate the gravity points contributed towards the mash out/pre boil volume" do
        fermentable = Zymurgy::Fermentable.new(@brew, @params)
        fermentable.pre_boil_volume_gravity_points.round_dp(2).should == 25.23
      end

      it "should calculate the gravity points contributed towards a given volume" do
        fermentable = Zymurgy::Fermentable.new(@brew, @params)
        fermentable.volume_gravity_points(38).round_dp(2).should == 25.23
      end
    end
  end
end