$LOAD_PATH << '.'
require 'readFile'
require 'CommandRobot'

# check count of argument when running application
if ARGV.length == 1
    # create instance of class CommandRobot
    command = CommandRobot.new()
    file = readFile(ARGV[0])

    # loop each data from file
    file.each { |item|
        cmd = command.readCommand(item)
        command.checkAction(cmd)
    }
else
    puts "Wrong argument"
end