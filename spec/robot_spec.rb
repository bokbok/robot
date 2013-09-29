require 'spec_helper'

describe Robot do
  subject { robot }
  let(:robot) { Robot.new(table) }
  let(:table) { double('table') }
  let(:position) { double('position', x: 1, y: 2) }

  before :each do
    table.stub(:position).with(anything, anything).and_return(position)
  end

  describe "#place" do
    before :each do
      table.should_receive(:position).with(1, 2).and_return(position)
    end

    it "should place itself at the desired position" do
      robot.place(1, 2, 'north')
      robot.position.should == position
    end

    it "should place itself in the desired orientation" do
      robot.place(1, 2, 'north')
      robot.orientation.to_s.should == 'north'
    end

    it "should use an orientation" do
      robot.place(1, 2, 'north')
      robot.orientation.should be_a(Orientation)
    end
  end

  describe "#move" do
    describe "when in position" do
      %w{north south east west}.each do |orientation|
        describe "when facing #{orientation}" do
          let(:new_position) { double('position') }

          before :each do
            robot.place(1, 2, orientation)
            position.stub(:advance).with(Orientation.new(orientation)).and_return(new_position)
          end

          it "should ask the position for the new position" do
            robot.move
            robot.position.should == new_position
          end
        end
      end
    end

    describe "when NOT in position" do
      it "should raise an error" do
        -> { robot.move }.should raise_error("Robot is not currently on the table")
      end
    end
  end

  describe "#left" do
    describe "when in position" do
      {north: :west, west: :south, south: :east, east: :north}.each do |original, rotated|
        describe "when facing #{original}" do
          before :each do
            robot.place(1, 2, original)
          end

          it "should orient it self #{rotated}" do
            robot.left

            robot.orientation.to_s.should == rotated.to_s
          end
        end
      end
    end

    describe "when NOT in position" do
      it "should raise an error" do
        -> { robot.left }.should raise_error("Robot is not currently on the table")
      end
    end
  end

  describe "#right" do
    describe "when in position" do
      {north: :east, east: :south, south: :west, west: :north}.each do |original, rotated|
        describe "when facing #{original}" do
          before :each do
            robot.place(1, 2, original)
          end

          it "should orient it self #{rotated}" do
            robot.right

            robot.orientation.to_s.should == rotated.to_s
          end
        end
      end
    end

    describe "when NOT in position" do
      it "should raise an error" do
        -> { robot.right }.should raise_error("Robot is not currently on the table")
      end
    end
  end

  describe "#report" do
    describe "when in position" do
      before :each do
        robot.place(1, 2, 'north')
      end

      it "should give its position and orientation" do
        robot.report.should == "Currently at 1,2 Facing NORTH"
      end
    end

    describe "when NOT in position" do
      it "should give no report" do
        robot.report.should == ""
      end
    end
  end
end