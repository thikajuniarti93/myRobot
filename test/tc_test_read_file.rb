require_relative "../read_file.rb"
require "test/unit"

class TestReadFile < Test::Unit::TestCase
    def test_read_file_should_return_array
        result = read_file("dummy_data.txt")
        assert_kind_of( Array, result)
    end

    def test_read_file_with_wrong_parameter
        assert_equal("Invalid path", read_file("dummyData"))
        assert_equal("Invalid path", read_file(0))
    end
end