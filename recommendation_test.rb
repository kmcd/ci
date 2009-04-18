require 'test/unit'
require 'recommendation'
require 'yaml'
require 'rubygems'
require 'redgreen'

# Results from Collective Intelligence, ch. 2, Segaran
class RecommendationTest < Test::Unit::TestCase
  def setup
    @recommendation = Recommendation.new
    @recommendation.dataset = open('movie_ratings.yml') {|f| YAML.load(f) }
  end

  def test_score_similarity_with_euclidean_distance
    assert_in_delta 0.1481,
      @recommendation.euclidean_distance('Lisa Rose', 'Gene Seymour'),
      0.0001
  end
  
  def test_score_similarity_with_pearson_distance
    assert_in_delta 0.3960,
      @recommendation.pearson_distance('Lisa Rose', 'Gene Seymour'),
      0.0001
  end
  
  def test_recommend_similar_critics
    assert_result_set(
      [["Lisa Rose", 0.9912], ["Mick LaSalle", 0.9244], ["Claudia Puig", 0.8934]],
      @recommendation.similar_critics('Toby') )
  end
  
  def test_recommend_movie_for_person
    assert_result_set( 
      [["The Night Listener", 3.3477], ["Lady in the Water", 2.8325], ["Just My Luck", 2.5309]],
      @recommendation.movies_for('Toby') )
  end
  
  def test_find_similar_movies
    assert_result_set(
      [["You, Me and Dupree", 0.6579], ["Lady in the Water", 0.4879], ["Snakes on a Plane", 0.1118], ["The Night Listener", -0.1798], ["Just My Luck", -0.4228]],
      @recommendation.movies_like("Superman Returns") )
  end
end

# Takes a nested array of movies and scores and tests movie title and score
# eg assert_result_set [["The Night Listener", 3.3477]], @recommendation.recommend('Foo')
def assert_result_set(expected, actual)
  expected.each_with_index do |expected,index|
    assert_equal expected.first, actual[index].first 
    assert_in_delta expected.last, actual[index].last, 0.001
  end
end
