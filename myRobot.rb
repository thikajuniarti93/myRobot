def commandRobot(robot)
    # get the robot commands
    place = robot.split(/:/, 2).last.strip()
    
    if place.match(/\s/) ? true : false
        place[" "] = ","
    end
    
    data = place.split(",")
    return data
end

def checkPosition(name, data)
    # get position from the robot
    currentRobot = Hash.new
    currentRobot = {
        name: name,
        data: {
            action: data[0],
            x: data[1].to_i,
            y: data[2].to_i,
            position: data[3]
        }
    }

    return currentRobot
end

def checkAction(arrayRobot, name, arrayPrint)
    dataRobot = arrayRobot.select { |item| item[:name] == name }.first
    case dataRobot[:data][:action]
        when "PLACE"
            myRobot = gets.chomp
            name = myRobot.split(/:/, 2).first
            data = commandRobot(myRobot)
            
            if arrayRobot.any? {|item| item[:name] == name}
                dataRobot = arrayRobot.select { |item| item[:name] == name }.first
                dataRobot[:data][:action] = data[0]
            else
                newData = checkPosition(name, data)
                arrayRobot.push(newData)
            end 
            
            checkAction(arrayRobot, name, arrayPrint)

        when "MOVE"
            case dataRobot[:data][:position]
                when "NORTH"
                    dataRobot[:data][:y] += 1
                when "SOUTH"
                    dataRobot[:data][:y] -= 1
                when "EAST"
                    dataRobot[:data][:x] += 1
                when "WEST"
                    dataRobot[:data][:x] -= 1
            end
            
            myRobot = gets.chomp
            name = myRobot.split(/:/, 2).first
            data = commandRobot(myRobot)
            
            if arrayRobot.any? {|item| item[:name] == name}
                dataRobot = arrayRobot.select { |item| item[:name] == name }.first
                dataRobot[:data][:action] = data[0]
            else
                newData = checkPosition(name, data)
                arrayRobot.push(newData)
            end 

            checkAction(arrayRobot, name, arrayPrint)
        when "LEFT"            
            case dataRobot[:data][:position]
                when "NORTH"
                    dataRobot[:data][:position] = "WEST"
                when "SOUTH"
                    dataRobot[:data][:position] = "EAST"
                when "EAST"
                    dataRobot[:data][:position] = "NORTH"
                when "WEST"
                    dataRobot[:data][:position] = "SOUTH"
            end
            myRobot = gets.chomp
            name = myRobot.split(/:/, 2).first
            data = commandRobot(myRobot)
            
            if arrayRobot.any? {|item| item[:name] == name}
                dataRobot = arrayRobot.select { |item| item[:name] == name }.first
                dataRobot[:data][:action] = data[0]
            else
                newData = checkPosition(name, data)
                arrayRobot.push(newData)
            end 

            checkAction(arrayRobot, name, arrayPrint)
        when "RIGHT"
            case dataRobot[:data][:position]
                when "NORTH"
                    dataRobot[:data][:position] = "EAST"
                when "SOUTH"
                    dataRobot[:data][:position] = "WEST"
                when "EAST"
                    dataRobot[:data][:position] = "SOUTH"
                when "WEST"
                    dataRobot[:data][:position] = "NORTH"
            end

            myRobot = gets.chomp
            name = myRobot.split(/:/, 2).first
            data = commandRobot(myRobot)
            
            if arrayRobot.any? {|item| item[:name] == name}
                dataRobot = arrayRobot.select { |item| item[:name] == name }.first
                dataRobot[:data][:action] = data[0]
            else
                newData = checkPosition(name, data)
                arrayRobot.push(newData)
            end 

            checkAction(arrayRobot, name, arrayPrint)
        when "REPORT"
            arrayPrint.push("#{dataRobot[:name]}: #{dataRobot[:data][:x]},#{dataRobot[:data][:y]},#{dataRobot[:data][:position]}")
            
            if arrayPrint.length == arrayRobot.length
                puts arrayPrint
            else
                myRobot = gets.chomp
                name = myRobot.split(/:/, 2).first
                data = commandRobot(myRobot)
                
                if arrayRobot.any? {|item| item[:name] == name}
                    dataRobot = arrayRobot.select { |item| item[:name] == name }.first
                    dataRobot[:data][:action] = data[0]
                else
                    newData = checkPosition(name, data)
                    arrayRobot.push(newData)
                end 

                checkAction(arrayRobot, name, arrayPrint)
            end
    end
end

arrayRobot = []
arrayPrint = []
myRobot = gets.chomp

# get the name of robot
name = myRobot.split(/:/, 2).first
data = commandRobot(myRobot)

dataRobot = checkPosition(name, data)
arrayRobot.push(dataRobot)
checkAction(arrayRobot, name, arrayPrint)