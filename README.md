Installing
==========

This test was written in ruby (1.9.3) using bundler

You must install the bundle before running
i.e.

% bundle install

Running
=======

There are two ways to run the robot test:

1. With commands in a file
2. Interactively via the console

Running from a file is done by issuing a command such as

% bundle exec ruby robot_test.rb example_files/commands.robot
Where the command file is specified on the command line.

When there is no command file specified the test runs in interactive mode, accepting commands from standard input. Press control-D to quit when in this mode.

Running Automated Tests
=======================
To run specs
------------

issue the following command from the root directory:

% bundle exec rspec spec/

To run features
---------------

issue the following command from the root directory:

% bundle exec cucumber features/

