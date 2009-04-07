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

class RecommendationTest < Test::Unit::TestCase
  def test_euclidean
    assert_in_delta 0.148148148148148,
      Recommendation.euclidean_distance('Lisa Rose', 'Gene Seymour'),
      0.0001
  end
  
  def test_pearson
    assert_in_delta 0.39605901719067,
      Recommendation.pearson_distance('Lisa Rose', 'Gene Seymour'),
      0.0001
  end
  
  def test_critic_ranking
    expected_results = [["Lisa Rose", 0.99124070716193], ["Mick LaSalle", 0.924473451641905], ["Claudia Puig", 0.893405147441565]]
    
    expected_results.each_with_index do |expected,index|
      results = Recommendation.top_matches('Toby')
      assert_equal expected.first, results[index].first 
      assert_in_delta expected.last, results[index].last, 0.0001
    end
  end
  
  def test_movie_recommendation
  end
end
