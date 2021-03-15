require_relative "../CommandRobot.rb"
require "test/unit"

class TestCommandRobot < Test::Unit::TestCase
    def test_readCommand_should_return_hash
        command = CommandRobot.new()
        result = command.readCommand("ALICE: PLACE 0,1,EAST")
        assert_kind_of( Hash, result)
        assert_equal( {action: "PLACE", name: "ALICE:", coordinate: "0,1,EAST"}, result)
    end

    def test_readCommand_with_wrong_parameter
        command = CommandRobot.new()
        assert_raise_message( "Invalid parameter" ) { command.readCommand(10) }
        assert_raise_message( "Invalid parameter" ) { command.readCommand("ALICE:PLACE0,1,EAST") }
        assert_raise_message( "Parameter direction should be PLACE, MOVE, LEFT, RIGHT, REPORT" ) { command.readCommand("aaa bbb") }
        assert_raise_message( "Parameter direction should be PLACE, MOVE, LEFT, RIGHT, REPORT" ) { command.readCommand("aaa ") }  
    end

    def test_checkAction_with_wrong_parameter
        command = CommandRobot.new()
        assert_raise_message( "Invalid parameter" ) { command.checkAction(10) }
        assert_raise_message( "Invalid parameter" ) { command.checkAction({name: "ALICE:", coordinate: "0,1,EAST"}) }
    end

    def test_checkAction_if_name_not_already_exist_and_action_not_place_should_return_nil
        command = CommandRobot.new()
        result = command.checkAction({name: "ALICE:", action: "MOVE", coordinate: ""})
        assert_equal( nil, result)
    end

    def test_checkAction_if_name_not_already_exist_and_action_place_should_add_to_list_robot
        command = CommandRobot.new()
        command.checkAction({name: "ALICE:", action: "PLACE", coordinate: "0,1,EAST"})
        assert_equal( 1, command.board.length)
    end

    def test_checkAction_if_robot_move_should_change_coordinate_or_move_foward
        command = CommandRobot.new()
        command.addRobot("ALICE:", "0,1,EAST")
        command.checkAction({name: "ALICE:", action: "MOVE", coordinate: ""})
        robot = command.getRobot("ALICE:")
        assert_equal( 1, robot.coordinateX)
        assert_equal( 1, robot.coordinateY)
        assert_equal( "EAST", robot.direction)
    end

    def test_checkAction_if_robot_left_should_change_direction
        command = CommandRobot.new()
        command.addRobot("ALICE:", "0,1,EAST")
        command.checkAction({name: "ALICE:", action: "LEFT", coordinate: ""})
        robot = command.getRobot("ALICE:")
        assert_equal( 0, robot.coordinateX)
        assert_equal( 1, robot.coordinateY)
        assert_equal( "NORTH", robot.direction)
    end

    def test_checkAction_if_robot_right_should_change_direction
        command = CommandRobot.new()
        command.addRobot("ALICE:", "0,1,EAST")
        command.checkAction({name: "ALICE:", action: "RIGHT", coordinate: ""})
        robot = command.getRobot("ALICE:")
        assert_equal( 0, robot.coordinateX)
        assert_equal( 1, robot.coordinateY)
        assert_equal( "SOUTH", robot.direction)
    end

    def test_checkAction_if_robot_report_action_should_return_current_position
        command = CommandRobot.new()
        command.addRobot("ALICE:", "0,1,EAST")
        command.checkAction({name: "ALICE:", action: "MOVE", coordinate: ""})
        command.checkAction({name: "ALICE:", action: "REPORT", coordinate: ""})
        robot = command.getRobot("ALICE:")
        assert_equal( "ALICE: 1,1,EAST", robot.report())
    end

    def test_getRobot_should_return_robot_class
        command = CommandRobot.new()
        command.addRobot("ALICE:", "0,1,EAST")
        result = command.getRobot("ALICE:")
        assert_equal("ALICE:", result.name)
        assert_equal(1, result.coordinateY)
        assert_equal(0, result.coordinateX)
        assert_equal("EAST", result.direction)
    end

    def test_getRobot_with_wrong_parameter_should_return_raise_error
        command = CommandRobot.new()
        assert_raise_message( "Invalid parameter" ) { command.getRobot(1) }
    end

    def test_addRobot_should_add_in_board
        command = CommandRobot.new()
        command.addRobot("ALICE:", "0,1,EAST")
        assert_equal(1, command.board.length)
    end

    def test_addRobot_with_wrong_parameter_should_rise_error
        command = CommandRobot.new()
        assert_raise_message( "Invalid parameter" ) { command.addRobot(0, "0,1,EAST") }
        assert_raise_message( "Invalid parameter" ) { command.addRobot("ALICE:", 0) }
        assert_raise_message( "invalid coordinate, robot won't be created" ) { command.addRobot("ALICE:", "0,1") }
    end
end