require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

## Zymurgy is a module containing some generic zymurgical calculation methods and classes
##

describe "Zymurgy" do
  describe "Utils" do

    describe "Performing various metric <=> imperial calculations" do
      it "should convert litres to US gallons" do
        litres_2_us_gallons(26.5).round_dp(2).should == 7.00
      end

      it "should convert US gallons to litres" do
        us_gallons_2_litres(11).round_dp(1).should == 41.6
      end

      it "should convert kilograms to pounds" do
        kilograms_2_pounds(2.73).round_dp(1).should == 6.0
      end

      it "should convert pounds to kilograms" do
        pounds_2_kilograms(17).round_dp(2).should == 7.73
      end

      it "should convert kilograms to ounces" do
        kilograms_2_ounces(1).round_dp(1).should == 35.3
      end

      it "should convert ounces to kilograms" do
        ounces_2_kilograms(10).round_dp(2).should == 0.28
      end

      it "should convert celsius to fahrenheit" do
        celsius_2_fahrenheit(10).round_dp(1).should == 50.0
      end

      it "should convert fahrenheit to celsius" do
        fahrenheit_2_celsius(120.0).round_dp(2).should == 48.89
      end

      it "should convert gravity points per kilogram per litre (pkgl) to gravity points per pound per gallon (ppg)" do
        pkgl_2_ppg(291.45).round_dp(1).should == 35.0
      end

      it "should convert gravity points per pound per gallon (ppg) to gravity points per kilogram per litre (pkgl)" do
        ppg_2_pkgl(35.0).round_dp(2).should == 291.48
      end
    end
  end
end
