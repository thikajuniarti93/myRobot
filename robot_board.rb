$LOAD_PATH << '.'
require 'robot'

class RobotBoard
    attr_accessor :board

    def initialize
        @board = Hash.new
    end

    def read_command(item)
        if !item.instance_of?(String) ||
            !item.match(" ")
            raise "Invalid parameter"
        end

        # make item to be array
        array_item = item.split(" ")

        if !["PLACE", "MOVE", "LEFT", "RIGHT", "REPORT"].include?(array_item[1] != nil ? array_item[1].upcase : array_item[1]) ||
            array_item.length < 2
            raise "Parameter command should be PLACE, MOVE, LEFT, RIGHT, REPORT"
        end

        if array_item.length >= 2
            name = array_item[0]
            action = array_item[1].upcase

            # check when array_item more than 2, it's mean define coordinate (x,y,z)
            coordinate = array_item.length > 2 ? array_item[2] : nil

            command_hash = {
                name: name,
                action: action,
                coordinate: coordinate
            }
            return command_hash
        end
    end

    def check_action(command)
        if !command.instance_of?(Hash) ||
            command.keys != [:name, :action, :coordinate]
            raise "Invalid parameter"
        end

        # get the robot based on name, will be return class Robot
        robot = get_robot(command[:name]) 
        
        # check the action (place, move, left, right, report)
        if robot == nil && command[:action] == "PLACE"
            add_robot(command[:name], command[:coordinate])
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

    def get_robot(name)
        if !name.instance_of?(String)
            raise "Invalid parameter"
        end

        # find the robot in board
        robot = @board[name]
        if robot != nil
            return @board[name];
        else
            return nil
        end
    end

    def add_robot(name, coordinate)
        if !(name.instance_of?(String)) ||
            !(coordinate.instance_of?(String))
            raise "Invalid parameter"
        end

        coordinate_XYF = coordinate.split(",")

        if coordinate_XYF.length != 3
            raise "invalid coordinate, robot won't be created"
        end

        # check count value in array coordinate_XYF
        if coordinate_XYF.length == 3
            @board[name] = Robot.new(name, coordinate_XYF[0].to_i, coordinate_XYF[1].to_i, coordinate_XYF[2])
        end
    end
end