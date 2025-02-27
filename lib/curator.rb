require 'csv'
require_relative './photograph'

class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(artist_id)
    @artists.find { |artist| artist.id == artist_id }
  end

  def find_photograph_by_id(photo_id)
    @photographs.find { |photo| photo.id == photo_id }
  end

  def find_photographs_by_artist(artist)
  # takes Artist object and returns array of all
  # of the Artist's photos
  # photos are linked to an artist by artist_id
    @photographs.find_all { |photo| photo.artist_id == artist.id }
  end

  def artists_with_multiple_photographs
    @artists.find_all do |artist|
      find_photographs_by_artist(artist).length > 1
    end
  end

  def photographs_taken_by_artists_from(country)
    artist_ids_from_country = artists_from_country(country).map { |artist| artist.id }

    photos_from_country = artist_ids_from_country.flat_map do |artist_id|
      @photographs.find_all {|photo| photo.artist_id == artist_id }
    end
  end

  def artists_from_country(country)
    @artists.find_all { |artist| artist.country == country }
  end

  def load_photographs(file_path)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)
    x = csv.each do |row|
      add_photograph(Photograph.new(row))
    end
  end

  def load_artists(file_path)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)
    x = csv.each do |row|
      add_artist(Artist.new(row))
    end
  end

  def photographs_taken_between(range)
    @photographs.find_all { |photo| photo.year.to_i > range.min && photo.year.to_i < range.max }
  end

  def artists_photographs_by_age(artist)
    artist_photos = find_photographs_by_artist(artist)

    artist_photos.reduce({}) do |by_age, photo|
      age = photo.year.to_i - artist.born.to_i
      name = photo.name
      by_age[age] = name
      by_age
    end
  end

end
