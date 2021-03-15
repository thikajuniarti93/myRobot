require_relative "../readFile.rb"
require "test/unit"

class TestReadFile < Test::Unit::TestCase
    def test_readFile_should_return_array
        result = readFile("dummyData.txt")
        assert_kind_of( Array, result)
    end

    def test_readFile_with_wrong_parameter
        assert_equal("Invalid path", readFile("dummyData"))
        assert_equal("Invalid path", readFile(0))
    end
end