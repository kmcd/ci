DATASET = {'Lisa Rose'=> {'Lady in the Water'=> 2.5, 'Snakes on a Plane'=> 3.5,
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
 } unless defined?(DATASET)

class Recommendation
  include Math
  
  def self.euclidean_distance(person1, person2)
    p1,p2         = DATASET[person1], DATASET[person2]
    shared_movies = p1.keys.inject([]) {|r,m| r.push(m) if p2[m] }
    
    # Euclidean distance
    return 1 / (1 + shared_movies.inject(0.0) {|r,m| r += ((p1[m] - p2[m]) ** 2) } )
  end
  
  def self.pearson_distance(person1, person2)
    p1,p2 = DATASET[person1], DATASET[person2]
    shared_movies = p1.keys.inject([]) {|r,m| r.push(m) if p2[m] }
    
  end
  
  # Takes 2 x,y points as as 2 arrays, eg sim_euclidean([3,6],[4,1])
  def self.sim_euclidean(p1,p2)
    1 / (1 + Math.sqrt( ((p1.first - p2.first) ** 2) + ((p2.last - p2.last) ** 2) ) )
  end
end