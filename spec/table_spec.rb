require "spec_helper"

describe Table do
  WIDTH = 5
  HEIGHT = 2

  let(:table) { Table.new(WIDTH, HEIGHT) }

  describe "#position" do
    describe "when on the table" do
      describe "when in x range" do
        0.upto(WIDTH - 1) do |x|
          it "should give a position corresponding to #{x}, #{HEIGHT - 1}" do
            position = table.position(x, HEIGHT - 1)

            position.x.should == x
            position.y.should == HEIGHT - 1
          end

          it "should give a position corresponding to #{x}, #{HEIGHT - 1}, when arguments are strings" do
            position = table.position(x.to_s, (HEIGHT - 1).to_s)

            position.x.should == x
            position.y.should == HEIGHT - 1
          end
        end

        0.upto(HEIGHT - 1) do |y|
          it "should give a position corresponding to #{WIDTH - 1}, #{y}" do
            position = table.position(WIDTH - 1, y)

            position.x.should == WIDTH - 1
            position.y.should == y
          end

          it "should give a position corresponding to #{WIDTH - 1}, #{y}, when arguments are strings" do
            position = table.position((WIDTH - 1).to_s, y.to_s)

            position.x.should == WIDTH - 1
            position.y.should == y
          end
        end
      end
    end

    describe "when OFF the table" do
      describe "when out of x range" do
        [-1, WIDTH].each do |x|
          it "should raise an error when requested position is #{x}, 1" do
            -> {table.position(x, HEIGHT - 1)}.should raise_error("Position #{x}, #{HEIGHT - 1} is off the table")
          end
        end
      end
      describe "when out of y range" do
        [-1, HEIGHT].each do |y|
          it "should raise an error when requested position is 1, #{y}" do
            -> {table.position(WIDTH - 1, y)}.should raise_error("Position #{WIDTH - 1}, #{y} is off the table")
          end
        end
      end
    end
  end
end