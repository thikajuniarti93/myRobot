$LOAD_PATH << '.'
require 'Robot'

class CommandRobot
    attr_accessor :board

    def initialize
       @board = Array.new
    end

    def readCommand(item)
        if item.class != String ||
            !item.match(" ")
            raise "Invalid parameter"
        end

        # make item to be array
        arrayItem = item.split(" ")

        if !["PLACE", "MOVE", "LEFT", "RIGHT", "REPORT"].include?(arrayItem[1]) ||
            arrayItem.length < 2
            raise "Parameter direction should be PLACE, MOVE, LEFT, RIGHT, REPORT"
        end

        if arrayItem.length >= 2
            name = arrayItem[0]
            action = arrayItem[1]
            # check when arrayItem more than 2, it's mean define coordinate (x,y,z)
            coordinate = arrayItem.length > 2 ? arrayItem[2] : nil

            commandHash = {
                name: name,
                action: action,
                coordinate: coordinate
            }
            return commandHash
        end
    end

    def checkAction(command)
        if command.class != Hash ||
            command.keys != [:name, :action, :coordinate]
            raise "Invalid parameter"
        end

        # get the robot based on name, will be return class Robot
        robot = getRobot(command[:name]) 
        
        # check the action (place, move, left, right, report)
        if robot == nil && command[:action] == "PLACE"
            addRobot(command[:name], command[:coordinate])
        elsif robot != nil && command[:action] != "PLACE"
            case command[:action]
                when "MOVE"
                    robot.move()
                
                when "LEFT"            
                    robot.left()
                
                when "RIGHT"            
                    robot.right()
                
                when "REPORT"         
                    robot.report()
            end
        else
            puts "invalid command"
            return nil
        end
    end

    def getRobot(name)
        if name.class != String
            raise "Invalid parameter"
        end

        # find the robot in board array
        robotIndex = @board.index { |item| item.name == name }
        if robotIndex != nil
            return @board[robotIndex];
        else
            return nil
        end
    end

    def addRobot(name, coordinate)
        if name.class != String ||
            coordinate.class != String
            raise "Invalid parameter"
        end

        coordinateXYZ = coordinate.split(",")

        if coordinateXYZ.length != 3
            raise "invalid coordinate, robot won't be created"
        end

        # check count value in array coordinateXYZ
        if coordinateXYZ.length == 3
            @board.push(Robot.new(name, coordinateXYZ[0].to_i, coordinateXYZ[1].to_i, coordinateXYZ[2]))
        end
    end
end