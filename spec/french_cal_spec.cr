require "./spec_helper"

include FrenchCal
A = Time.new(2017, 2, 22)
B = Time.new(2016, 9, 24)
C = Time.new(2016, 2, 1)
D = Time.new(2017, 2, 24)
# TODO: check the 21, 22, 23

describe FrenchCal do
  it "fyear" do
    A.fyear.should eq 225
    B.fyear.should eq 225
    C.fyear.should eq 224
  end

  it "is_sextile?" do
    A.is_sextile?.should be_false
    B.is_sextile?.should be_false
    C.is_sextile?.should be_true
  end

  it "fday" do
    D.fday.should eq(A.fday + 2)
    # A.fday.should eq 4
  end

  it "fmonth" do
    A.fmonth.should eq 6
    B.fmonth.should eq 1
  end
end
