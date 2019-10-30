require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/photograph'

class PhotographTest < Minitest::Test
  def setup
    attributes = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "4",
      year: "1954"
    }

    @photograph = Photograph.new(attributes)
  end

  def test_it_exists
    assert_instance_of Photograph, @photograph
  end

  def test_it_has_attributes
    assert_equal "1", @photograph.id
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", @photograph.name
    assert_equal "4", @photograph.artist_id
    assert_equal "1954", @photograph.year
  end
end
