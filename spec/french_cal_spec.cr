require "./spec_helper"

include FrenchCal
A = Time.new(2017, 2, 22) # 4 Ventôse 225
B = Time.new(2016, 9, 24) # 3 Vendémiaire 225
C = Time.new(2016, 2, 1) # 12 Pluviôse 224
D = Time.new(2017, 2, 24) # 6 Ventôse 225

T1  = Time.new(2016, 9, 22) # 1 Vendémiaire 225
T2  = Time.new(2016, 9, 23) # 2 Vendémiaire 225
T3  = Time.new(2016, 9, 24) # 3 Vendémiaire 225
TX5 = Time.new(2017, 9, 21) # Jour des récompenses (5) 225
TX6 = Time.new(2017, 9, 22) # 1 Vendémiaire 226

# TODO: check the 21, 22, 23

describe FrenchCal do
  it "fyear" do
    A.fyear.should eq 225
    B.fyear.should eq 225
    C.fyear.should eq 224
    T1.fyear.should eq 224
    T2.fyear.should eq 224
    T3.fyear.should eq 224
    TX5.fyear.should eq 224
    TX6.fyear.should eq 225
  end

  it "is_sextile?" do
    A.is_sextile?.should be_false
    B.is_sextile?.should be_false
    C.is_sextile?.should be_true
  end

  it "fday" do
    D.fday.should eq(A.fday + 2)
    # A.fday.should eq 4

    T1.fday.should eq 1
    T2.fday.should eq 2
    T3.fday.should eq 3
    TX5.fday.should eq 365
    TX6.fday.should eq 1
  end

  it "fmonth" do
    A.fmonth.should eq 6
    B.fmonth.should eq 1

    T1.fmonth.should eq 1
    T2.fmonth.should eq 1
    T3.fmonth.should eq 1
    TX5.fmonth.should eq 13
    TX6.fmonth.should eq 13
  end
end
