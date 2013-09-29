require 'spec_helper'

describe Orientation do

  describe "validity" do
    describe "for a valid direction" do
      %w{north east south west}.each do |dir|
        it "should accept #{dir}" do
          orientation = Orientation.new(dir)
          orientation.to_s.should == dir
        end

        it "should accept #{dir.upcase}" do
          orientation = Orientation.new(dir.upcase)
          orientation.to_s.should == dir
        end
      end
    end

    describe "for an INVALID direction" do
      it "should raise an error" do
        -> { Orientation.new("up") }.should raise_error("Invalid orientation 'up'")
      end
    end
  end

  describe "#==" do
    let(:north) { Orientation.new(:north) }

    it "should be equal when direction is the same" do
      north.should == Orientation.new(:north)
    end

    it "should not be equal when directions differ" do
      north.should_not == Orientation.new(:south)
    end

    it "tolerate nil" do
      north.should_not == nil
    end

    it "tolerate other types" do
      north.should_not == "north"
    end
  end

  describe "#rotate" do
    describe "left" do
      {north: :west, south: :east, east: :north, west: :south}.each do |orig, dir|
        describe "when pointing #{orig}" do
          let(:orientation) { Orientation.new(orig) }
          it "should move from #{orig} to #{dir}" do
            rotated = orientation.rotate(-1)
            rotated.to_s.should == dir.to_s
          end
        end
      end
    end

    describe "right" do
      {north: :east, south: :west, east: :south, west: :north}.each do |orig, dir|
        describe "when pointing #{orig}" do
          let(:orientation) { Orientation.new(orig) }
          it "should move from #{orig} to #{dir}" do
            rotated = orientation.rotate(1)
            rotated.to_s.should == dir.to_s
          end
        end
      end
    end
  end

  describe "#advance" do
    let(:orientation) { Orientation.new(orig) }

    {north: [2,3], south: [2,1], east: [3,2], west: [1,2]}.each do |dir, loc|
      describe "facing #{dir}" do
        let(:orientation) { Orientation.new(dir) }

        it "should move from 2,2 to #{loc.join(',')}" do
          orientation.advance(2, 2).should == loc
        end
      end
    end
  end


  describe "#to_s" do
    let(:orientation) { Orientation.new(:north) }

    it "should report its orientation" do
      orientation.to_s.should == "north"
    end
  end
end