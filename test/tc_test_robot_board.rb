require_relative "../robot_board.rb"
require "test/unit"

class TestRobotBoard < Test::Unit::TestCase
    def test_read_command_should_return_hash
        command = RobotBoard.new()
        result = command.read_command("ALICE: PLACE 0,1,EAST")
        assert_kind_of( Hash, result)
        assert_equal( {action: "PLACE", name: "ALICE:", coordinate: "0,1,EAST"}, result)
    end

    def test_read_command_handle_action_lowercase_should_return_upcase
        command = RobotBoard.new()
        result = command.read_command("ALICE: place 0,1,EAST")
        assert_equal( {action: "PLACE", name: "ALICE:", coordinate: "0,1,EAST"}, result)
    end

    def test_read_command_with_wrong_parameter
        command = RobotBoard.new()
        assert_raise_message( "Invalid parameter" ) { command.read_command(10) }
        assert_raise_message( "Invalid parameter" ) { command.read_command("ALICE:PLACE0,1,EAST") }
        assert_raise_message( "Parameter command should be PLACE, MOVE, LEFT, RIGHT, REPORT" ) { command.read_command("aaa bbb") }
        assert_raise_message( "Parameter command should be PLACE, MOVE, LEFT, RIGHT, REPORT" ) { command.read_command("aaa ") }  
    end

    def test_check_action_with_wrong_parameter
        command = RobotBoard.new()
        assert_raise_message( "Invalid parameter" ) { command.check_action(10) }
        assert_raise_message( "Invalid parameter" ) { command.check_action({name: "ALICE:", coordinate: "0,1,EAST"}) }
    end

    def test_check_action_if_name_not_already_exist_and_action_not_place_should_return_nil
        command = RobotBoard.new()
        result = command.check_action({name: "ALICE:", action: "MOVE", coordinate: ""})
        assert_equal( nil, result)
    end

    def test_check_action_if_name_not_already_exist_and_action_place_should_add_to_list_robot
        command = RobotBoard.new()
        command.check_action({name: "ALICE:", action: "PLACE", coordinate: "0,1,EAST"})
        assert_equal( 1, command.board.length)
    end

    def test_check_action_if_robot_move_should_change_coordinate_or_move_foward
        command = RobotBoard.new()
        command.add_robot("ALICE:", "0,1,EAST")
        command.check_action({name: "ALICE:", action: "MOVE", coordinate: ""})
        robot = command.get_robot("ALICE:")
        assert_equal( 1, robot.coordinateX)
        assert_equal( 1, robot.coordinateY)
        assert_equal( "EAST", robot.direction)
    end

    def test_check_action_if_robot_left_should_change_direction
        command = RobotBoard.new()
        command.add_robot("ALICE:", "0,1,EAST")
        command.check_action({name: "ALICE:", action: "LEFT", coordinate: ""})
        robot = command.get_robot("ALICE:")
        assert_equal( 0, robot.coordinateX)
        assert_equal( 1, robot.coordinateY)
        assert_equal( "NORTH", robot.direction)
    end

    def test_check_action_if_robot_right_should_change_direction
        command = RobotBoard.new()
        command.add_robot("ALICE:", "0,1,EAST")
        command.check_action({name: "ALICE:", action: "RIGHT", coordinate: ""})
        robot = command.get_robot("ALICE:")
        assert_equal( 0, robot.coordinateX)
        assert_equal( 1, robot.coordinateY)
        assert_equal( "SOUTH", robot.direction)
    end

    def test_check_action_if_robot_report_action_should_return_current_position
        command = RobotBoard.new()
        command.add_robot("ALICE:", "0,1,EAST")
        command.check_action({name: "ALICE:", action: "MOVE", coordinate: ""})
        command.check_action({name: "ALICE:", action: "REPORT", coordinate: ""})
        robot = command.get_robot("ALICE:")
        assert_equal( "ALICE: 1,1,EAST", robot.report())
    end

    def test_get_robot_should_return_robot_class
        command = RobotBoard.new()
        command.add_robot("ALICE:", "0,1,EAST")
        result = command.get_robot("ALICE:")
        assert_equal("ALICE:", result.name)
        assert_equal(1, result.coordinateY)
        assert_equal(0, result.coordinateX)
        assert_equal("EAST", result.direction)
    end

    def test_get_robot_with_wrong_parameter_should_return_raise_error
        command = RobotBoard.new()
        assert_raise_message( "Invalid parameter" ) { command.get_robot(1) }
    end

    def test_add_robot_should_add_in_board
        command = RobotBoard.new()
        command.add_robot("ALICE:", "0,1,EAST")
        assert_equal(1, command.board.length)
    end

    def test_add_robot_with_wrong_parameter_should_rise_error
        command = RobotBoard.new()
        assert_raise_message( "Invalid parameter" ) { command.add_robot(0, "0,1,EAST") }
        assert_raise_message( "Invalid parameter" ) { command.add_robot("ALICE:", 0) }
        assert_raise_message( "invalid coordinate, robot won't be created" ) { command.add_robot("ALICE:", "0,1") }
    end
end