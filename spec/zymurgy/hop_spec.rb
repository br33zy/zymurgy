require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Zymurgy" do
  describe "Hop" do
    before do
      alpha_acid_percentage = 10
      bigness_factor = 2
      @hop = Zymurgy::Hop.new(alpha_acid_percentage, bigness_factor)
    end

    describe "attributes and accessors" do
      it "should have an instance variable @alpha_acid_percentage" do
        @hop.instance_variable_get(:@alpha_acid_percentage).should_not be_nil
      end
    end
  end
end
