require_relative "../Robot.rb"
require "test/unit"

class TestRobot < Test::Unit::TestCase
    def test_initialize_robot_should_print_true
        robot = Robot.new('BOB',2,1,'NORTH')
        assert_equal("BOB", robot.name)
        assert_equal(2, robot.coordinateX)
        assert_equal(1, robot.coordinateY)
        assert_equal("NORTH", robot.direction)
    end

    def test_initialize_with_wrong_number_argument_should_throw_argumenerror
        assert_raise( ArgumentError ) { Robot.new(2,1,'NORTH') }
    end

    def test_initialize_with_invalid_datatype_should_raise_error
        assert_raise_message( "Invalid parameter" ) { Robot.new(0,2,1,'NORTH') }
        assert_raise_message( "Invalid parameter" ) { Robot.new("BOB","satu",1,'NORTH') }
        assert_raise_message( "Invalid parameter" ) { Robot.new("BOB",1,"satu",'NORTH') }
        assert_raise_message( "Invalid parameter" ) { Robot.new("BOB",1,1,0) }
        assert_raise_message( "Parameter direction should be NORTH, SOUTH, WEST, EAST" ) { Robot.new("BOB",1,1,"BOB") }
    end

    def test_move_from_north_should_add_coordinateY_byone
        robot = Robot.new('BOB',0,0,'NORTH')
        robot.move()
        assert_equal(1, robot.coordinateY)
    end

    def test_move_from_west_should_deduct_coordinateX_byone
        robot = Robot.new('BOB',2,0,'WEST')
        robot.move()
        assert_equal(1, robot.coordinateX)
    end

    def test_left_from_west_should_change_direction_to_south
        robot = Robot.new('BOB',2,0,'WEST')
        robot.left()
        assert_equal("SOUTH", robot.direction)
    end

    def test_right_from_north_should_change_direction_to_east
        robot = Robot.new('BOB',2,0,'NORTH')
        robot.right()
        assert_equal("EAST", robot.direction)
    end
end