require 'spec_helper'

describe Position do
  let(:table) { double('table') }
  let(:position) { Position.new(2, 2, table) }
  let(:new_position) { Position.new(20, 20, table) }

  describe "#advance" do
    {north: [2, 3], south: [2, 1], east: [3, 2], west: [1, 2]}.each do |dir, new_coord|
      describe "when advancing in a #{dir} direction" do

        let(:orientation) { Orientation.new(dir) }

        it "should give the advanced position" do
          table.should_receive(:position).with(*new_coord).and_return(new_position)

          position.advance(orientation).should == new_position
        end
      end
    end
  end

  describe "#to_s" do
    it "should report its x and y" do
      position.to_s.should == "2,2"
    end
  end
end