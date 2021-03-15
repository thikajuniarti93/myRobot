class Robot
    attr_accessor :name, :coordinateX, :coordinateY, :direction

    def initialize(name, coordinateX, coordinateY, direction)
        if name.class != String || 
            coordinateX.class != Integer || 
            coordinateY.class != Integer || 
            direction.class != String
                raise "Invalid parameter"
        elsif !["NORTH", "SOUTH", "WEST", "EAST"].include?(direction)
            raise "Parameter direction should be NORTH, SOUTH, WEST, EAST"
        end

        @name = name
        @coordinateX = coordinateX.to_i
        @coordinateY = coordinateY.to_i
        @direction = direction
    end

    def move 
        case @direction
            when "NORTH"
                @coordinateY += 1
            when "SOUTH"
                @coordinateY -= 1
            when "EAST"
                @coordinateX += 1
            when "WEST"
                @coordinateX -= 1
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