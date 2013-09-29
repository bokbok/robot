@robot
Feature: Robot moves in response to issued commands
  Scenario: Robot moves from initial point
    Given The robot executes the following commands in a file:
      | command         |
      | PLACE 0,0,NORTH |
      | MOVE            |
      | REPORT          |
    Then the robot should have reported its end location and orientation are "Currently at 0,1 Facing NORTH"

  Scenario: Robot rotates at the initial point
    Given The robot executes the following commands in a file:
      | command         |
      | PLACE 0,0,NORTH |
      | LEFT            |
      | REPORT          |
    Then the robot should have reported its end location and orientation are "Currently at 0,0 Facing WEST"

  Scenario: Robot moves and rotates
    Given The robot executes the following commands in a file:
      | command         |
      | PLACE 1,2,EAST  |
      | MOVE            |
      | MOVE            |
      | LEFT            |
      | MOVE            |
      | REPORT          |
    Then the robot should have reported its end location and orientation are "Currently at 3,3 Facing NORTH"
