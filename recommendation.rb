class Recommendation
  include Math
  
  def self.euclidean_distance(person1, person2)
    p1,p2         = DATASET[person1], DATASET[person2]
    shared_movies = p1.keys.inject([]) {|r,m| r.push(m) if p2[m] }
    
    return 1 / (1 + shared_movies.inject(0.0) {|r,m| r += ((p1[m] - p2[m]) ** 2) } )
  end
  
  # Returns a value between -1 and 1
  def self.pearson_distance(person1, person2)
    p1,p2 = DATASET[person1], DATASET[person2]
    shared_movies = p1.keys.inject([]) {|r,m| p2[m] ? r.push(m) : r }
    
    if shared_movies.size == 0
      return 0
    else
      # Sum shared ratings
      p1_prefs = shared_movies.inject(0.0) {|r,m| r += p1[m] }
      p2_prefs = shared_movies.inject(0.0) {|r,m| r += p2[m] }
      
      # Sum square of shared ratings
      p1_sq = shared_movies.inject(0.0) {|r,m| r += p1[m] ** 2 }
      p2_sq = shared_movies.inject(0.0) {|r,m| r += p2[m] ** 2 }
      
      # Sum up the products
      products = shared_movies.inject(0.0) {|r,m| r += p1[m] * p2[m] }

      # Calculate Pearson score
      num = products - ( (p1_prefs * p2_prefs)/ shared_movies.size )
      den = Math.sqrt( (p1_sq - (p1_prefs ** 2) / shared_movies.size) * ( p2_sq - (p2_prefs ** 2) / shared_movies.size ) )
      den == 0 ? 0 : num/den
    end
  end
  
  # Returns an ordered list of people with similar tastes to the specified person:
  def self.top_matches(person,results=3)
    critics = DATASET.keys.map do |critic|
      [critic, pearson_distance(person, critic)] unless person == critic
    end
    matches = critics.compact.sort_by {|m| m.last }.reverse
    matches[0...results]
  end
  
  # Recommendation using weighted average of all other user's ratings
  def self.recommend(person)
    critic_sim = top_matches(person,DATASET.keys.size).reject {|c| c.last <= 0 }
    
    # Only score movies person hasn't seen yet
    movies = DATASET.map {|h| h[1].keys }.flatten.uniq.reject do |movie|
      DATASET[person].keys.include? movie
    end
    
    # Weight each movie ranking according to how similar the critic is to person
    weighted_scores, sum_similarities = Hash.new(0), Hash.new(0)
      
    movies.each do |movie|
      critic_sim.each do |critic|
        if DATASET[critic.first][movie]
          weighted_scores[movie]  += DATASET[critic.first][movie] * critic.last
          sum_similarities[movie] += critic.last
        end
      end
    end
    
    # Rank the results
    results = weighted_scores.map do |movie,score| 
      [movie, score / sum_similarities[movie] ]
    end
    results.sort_by {|m| m.last }.reverse
  end
  
  # Takes 2 x,y points as as 2 arrays, eg sim_euclidean([3,6],[4,1])
  def self.sim_euclidean(p1,p2)
    1 / (1 + Math.sqrt( ((p1.first - p2.first) ** 2) + ((p2.last - p2.last) ** 2) ) )
  end
end