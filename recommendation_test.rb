class RecommendationTest < Test::Unit::TestCase
  def setup
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
    'Keith'=> {'Snakes on a Plane'=>1.5,'You, Me and Dupree'=>3.0,'Superman Returns'=>1.0}
    } unless defined?(Recommendation::DATASET)
  end
  
  def test_euclidean
  end
  
  def test_pearson
  end
  
  def test_critic_ranking
  end
  
  def test_movie_recommendation
  end
end
