require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Zymurgy" do
  describe "Hop" do
    before do
      @brew = mock('A Brew')
      @brew.stub!('bigness_factor').and_return(1.1)
      @brew.stub!('post_boil_volume').and_return(27)
      @brew.stub!('boil_time_minutes').and_return(45)
      alpha_acid_percentage = 7
      weight_grams = 30
      boil_time_minutes = 45
      @hop_addition = Zymurgy::HopAddition.new(@brew, alpha_acid_percentage, weight_grams, boil_time_minutes)
    end

    describe "attributes and accessors" do
      it "should have an instance variable @alpha_acid_percentage" do
        @hop_addition.instance_variable_get(:@alpha_acid_percentage).should_not be_nil
      end
    end
  end
end
