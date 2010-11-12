require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

## As a beer brewing recipe application I would like to use the Zymurgy gem to
## perform zymurgical calculations so that I don't have to include complicated
## esoteric logic in my codebase.

describe "Zymurgy" do

  # When I instantiate a hop object for a hop with 10% alpha acid levels
  # Then I will get a hop object
  # And the hop object will have an alpha acid accessor
  describe "Hop" do
    describe "behavior" do
      it "should reveal the 'bigness' factor and the hop's alpha acid level it was instantiated with" do
        alpha_acid_percentage = 10
        bigness_factor = 2
        hop = Zymurgy::Hop.new(alpha_acid_percentage, bigness_factor)
        hop.alpha_acid_percentage.should == 10
        hop.bigness_factor.should == 2
      end

      it "should reveal a default 'bigness' factor of 1.65 if instantiated without a bigness factor" do
        alpha_acid_percentage = 10
        hop = Zymurgy::Hop.new(alpha_acid_percentage)
        hop.alpha_acid_percentage.should == 10
        hop.bigness_factor.should == 1.65
      end
    end
  end
end
