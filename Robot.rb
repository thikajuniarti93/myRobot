class Robot
    attr_accessor :name, :coordinateX, :coordinateY, :direction

    def initialize(name, coordinateX, coordinateY, direction)
        if !(name.instance_of?(String)) || 
            !(coordinateX.instance_of?(Integer)) || 
            !(coordinateY.instance_of?(Integer)) || 
            !(direction.instance_of?(String))
                raise "Invalid parameter"
        elsif !["NORTH", "SOUTH", "WEST", "EAST"].include?(direction.upcase)
            raise "Parameter command should be NORTH, SOUTH, WEST, EAST"
        end

        @name = name
        @coordinateX = coordinateX
        @coordinateY = coordinateY
        @direction = direction.upcase
    end

    def move        
        case @direction
            when "NORTH"
                @coordinateY += @coordinateY > 5 ? 0 : 1
            when "SOUTH"
                @coordinateY -= @coordinateY == 0 ? 0 : 1
            when "EAST"
                @coordinateX += @coordinateX > 5 ? 0 : 1
            when "WEST"
                @coordinateX -= @coordinateX == 0 ? 0 : 1
        end
    end

    def left 
        case @direction
            when "NORTH"
                @direction = "WEST"
            when "SOUTH"
                @direction = "EAST"
            when "EAST"
                @direction = "NORTH"
            when "WEST"
                @direction = "SOUTH"
        end
    end

    def right 
        case @direction
            when "NORTH"
                @direction = "EAST"
            when "SOUTH"
                @direction = "WEST"
            when "EAST"
                @direction = "SOUTH"
            when "WEST"
                @direction = "NORTH"
        end
    end

    def report
        puts "#{@name} #{@coordinateX},#{@coordinateY},#{@direction}"
        return "#{@name} #{@coordinateX},#{@coordinateY},#{@direction}"
    end
end