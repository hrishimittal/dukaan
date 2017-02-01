require './basket.rb'

RSpec.describe Basket do
  let(:basket) { Basket.new }
  it "should calculate correct basket totals - S01, B01" do
    [:S01, :B01].each {|p|  basket.add(p) }
    expect(basket.total).to eq(37.85)
  end

  it "should calculate correct basket totals - J01, J01" do
    [:J01, :J01].each {|p|  basket.add(p) }
    expect(basket.total).to eq(54.37)
  end

  it "should calculate correct basket totals - J01, B01" do
    [:J01, :B01].each {|p|  basket.add(p) }
    expect(basket.total).to eq(60.85)
  end

  it "should calculate correct basket totals - S01, S01, J01, J01, J01" do
    [:S01, :S01, :J01, :J01, :J01].each {|p|  basket.add(p) }
    expect(basket.total).to eq(98.27)
  end
end
