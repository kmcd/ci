require 'test/unit'
require 'recommendation'

Recommendation::DATASET = {'Lisa Rose'=> {'Lady in the Water'=> 2.5, 'Snakes on a Plane'=> 3.5,
 'Just My Luck'=> 3.0, 'Superman Returns'=> 3.5, 'You, Me and Dupree'=> 2.5,
 'The Night Listener'=> 3.0},
'Gene Seymour'=> {'Lady in the Water'=> 3.0, 'Snakes on a Plane'=> 3.5,
 'Just My Luck'=> 1.5, 'Superman Returns'=> 5.0, 'The Night Listener'=> 3.0,
 'You, Me and Dupree'=> 3.5},
'Michael Phillips'=> {'Lady in the Water'=> 2.5, 'Snakes on a Plane'=> 3.0,
 'Superman Returns'=> 3.5, 'The Night Listener'=> 4.0},
'Claudia Puig'=> {'Snakes on a Plane'=> 3.5, 'Just My Luck'=> 3.0,
 'The Night Listener'=> 4.5, 'Superman Returns'=> 4.0,
 'You, Me and Dupree'=> 2.5},
'Mick LaSalle'=> {'Lady in the Water'=> 3.0, 'Snakes on a Plane'=> 4.0,
 'Just My Luck'=> 2.0, 'Superman Returns'=> 3.0, 'The Night Listener'=> 3.0,
 'You, Me and Dupree'=> 2.0},
'Jack Matthews'=> {'Lady in the Water'=> 3.0, 'Snakes on a Plane'=> 4.0,
 'The Night Listener'=> 3.0, 'Superman Returns'=> 5.0, 'You, Me and Dupree'=> 3.5},
 'Toby'=> {'Snakes on a Plane'=>4.5,'You, Me and Dupree'=>1.0,'Superman Returns'=>4.0},
'Keith'=> {'Snakes on a Plane'=>1.5,'You, Me and Dupree'=>3.0,'Superman Returns'=>1.0}
}

# Results from Collective Intelligence, ch. 2, Segaran
class RecommendationTest < Test::Unit::TestCase
  def test_euclidean
    assert_in_delta 0.1481,
      Recommendation.euclidean_distance('Lisa Rose', 'Gene Seymour'),
      0.0001
  end
  
  def test_pearson
    assert_in_delta 0.3960,
      Recommendation.pearson_distance('Lisa Rose', 'Gene Seymour'),
      0.0001
  end
  
  def test_critic_ranking
    assert_result_set(
      [["Lisa Rose", 0.9912], ["Mick LaSalle", 0.9244], ["Claudia Puig", 0.8934]],
      Recommendation.top_matches('Toby') )
  end
  
  def test_movie_recommendation
    assert_result_set( 
      [["The Night Listener", 3.3477], ["Lady in the Water", 2.8325], ["Just My Luck", 2.5309]],
      Recommendation.recommend('Toby') )
  end
end

def assert_result_set(expected, actual)
  expected.each_with_index do |expected,index|
    assert_equal expected.first, actual[index].first 
    assert_in_delta expected.last, actual[index].last, 0.0001
  end
end
