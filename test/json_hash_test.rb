require "byebug"
require "test/unit"
require "json_hash"

class JSONHashTest < Test::Unit::TestCase

  test "the class should be defined" do
    assert_kind_of Class, JSONHash
  end

  test "how it works" do

    json = {
      name:    { first: "John", "last" => "Smith" },
      age:     246,
      "job" => "Unknown",
      lucky:   [1, 3, 5, 7, 9]
    }

    # JSONHash performs its operation in place; that is, by modifying the hash that is
    # passed in.  But since we want to verify its work, we use a clone instead so as to
    # preserve the original content to veriy against.

    jh = JSONHash.parse(json.clone)

    assert_equal json[:name][:first], jh.name.first
    assert_equal json[:name]["last"], jh.name.last
    assert_equal json[:age], jh.age
    assert_equal json["job"], jh.job
    assert_equal json[:lucky], jh.lucky
    assert_equal json[:lucky][0], jh.lucky[0]
    assert_equal json[:lucky][-1], jh.lucky[-1]

  end

end

