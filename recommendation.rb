# TODO: refactor rating hash to array of Rating objects/structs, eg
Rating = Struct.new :critic, :item, :score
Rating.new 'Keith', 'Superman Returns', 1.0
Rating.new 'Keith', 'Snakes on a Plane', 1.5
Rating.new 'Keith', 'You, Me and Dupree', 3.0

class Recommendation
  include Math
  attr_accessor :dataset
  
  def initialize(data=nil)
    @dataset = data
  end
  
  def euclidean_distance(person1, person2)
    p1,p2         = @dataset[person1], @dataset[person2]
    shared_movies = p1.keys.inject([]) {|r,m| r.push(m) if p2[m] }
    
    return 1 / (1 + shared_movies.inject(0.0) {|r,m| r += ((p1[m] - p2[m]) ** 2) } )
  end
  
  # Returns a value between -1 and 1
  def pearson_distance(person1, person2)
    p1,p2 = @dataset[person1], @dataset[person2]
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
  def similar_critics(person,results=3)
    critics = @dataset.keys.map do |critic|
      [critic, pearson_distance(person, critic)] unless person == critic
    end
    matches = critics.compact.sort_by {|m| m.last }.reverse
    matches[0...results]
  end
  
  # Recommendation using weighted average of all other user's ratings
  def movies_for(person)
    critic_sim = similar_critics(person,@dataset.keys.size).reject {|c| c.last <= 0 }
    
    # Only score movies person hasn't seen yet
    movies = @dataset.map {|h| h[1].keys }.flatten.uniq.reject do |movie|
      @dataset[person].keys.include? movie
    end
    
    # Weight each movie ranking according to how similar the critic is to person
    weighted_scores, sum_similarities = Hash.new(0), Hash.new(0)
      
    movies.each do |movie|
      critic_sim.each do |critic|
        if @dataset[critic.first][movie]
          weighted_scores[movie]  += @dataset[critic.first][movie] * critic.last
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
  
  def movies_like(title)
    invert_dataset { similar_critics(title,@dataset.keys.size) }
  end
  
  def critics_for(title)
    invert_dataset { movies_for(title) }
  end
  
  private
  
  # Inverts the dataset, yields to block then reverts dataset to original state
  def invert_dataset
    inverted_ratings = Hash.new {|hash, key| hash[key] = {} }
    
    @dataset.each do |person, ratings|
      ratings.each {|item, rating| inverted_ratings[item][person] = rating }
    end
    
    original_dataset, @dataset  = @dataset, inverted_ratings
    results, @dataset           = yield, original_dataset
    return results
  end
end