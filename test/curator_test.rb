require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/curator'
require_relative '../lib/photograph'
require_relative '../lib/artist'

class CuratorTest < Minitest::Test
  def setup
    @curator = Curator.new
    @photo_1 = Photograph.new({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
      })
    @photo_2 = photo_2 = Photograph.new({
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
      })
    @artist_1 = Artist.new({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
      })
    @artist_2 = Artist.new({
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
      })
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_has_attributes
    assert_equal [], @curator.photographs
    assert_equal [], @curator.artists
  end

  def test_it_can_add_photograph
    assert_equal [], @curator.photographs

    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal [@photo_1, @photo_2], @curator.photographs
  end

  def test_it_can_add_artist
    assert_equal [], @curator.artists

    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal [@artist_1, @artist_2], @curator.artists
  end

  def test_it_can_find_artist_by_id
    assert_nil @curator.find_artist_by_id("1")

    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal @artist_1, @curator.find_artist_by_id("1")
    assert_equal @artist_2, @curator.find_artist_by_id("2")
  end

  def test_it_can_find_photograph_by_id
    assert_nil @curator.find_photograph_by_id("2")

    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal @photo_2, @curator.find_photograph_by_id("2")
    assert_equal @photo_1, @curator.find_photograph_by_id("1")

  end

end
