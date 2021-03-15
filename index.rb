$LOAD_PATH << '.'
require 'read_file'
require 'robot_board'

# check count of argument when running application
if ARGV.length == 1
    # create instance of class CommandRobot
    command = RobotBoard.new()
    file = read_file(ARGV[0])

    # loop each data from file
    file.each { |item|
        cmd = command.read_command(item)
        command.check_action(cmd)
    }
else
    puts "Wrong argument"
end