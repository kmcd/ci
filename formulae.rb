require 'extensions'

def weighted_mean(observations, weights)
  raise ArgumentError if observations.length != observations.length
  
  sum_weighted_observations = 0.0
  observations.each_with_index do |observation,index|
    sum_weighted_observations += observation[index] * weights[index]
  end
  
  sum_weighted_observations / weights.inject(0.0) {|sum,weight| sum += weight }
end

def tanimoto_coefficient(set_a,set_b)
  intersection = ( set_a & set_b ).size.to_f
  intersection / ( (set_a.size.to_f + set_b.size.to_f) - intersection )
end

# Measure of how 'impure' a list is, ie the probability that you would be wrong
# if you picked one item & guessed its label.
def gini_impurity(list)
  purity = 0.0
  histogram = list.to_hist
  length = list.length.to_f 
  
  # sigma( f(i,j) * f(i,k) where j != k )
  list.each do |item_j|
    list.each do |item_k|
      unless item_j == item_k
        purity += ( histogram[item_j].to_f/length  * histogram[item_k].to_f/length )
      end
    end
  end
  purity
end

# How 'surprising' a randomly selected item from the list is
def entropy(list)
  entropy = 0.0
  histogram = list.to_hist
  length = list.length.to_f
  
  histogram.keys.each do |key|
    p1 = histogram[key].to_f / length
    p2 = Math.log(p1) / Math.log(2)
    entropy -= ( p1 * p2 )
  end
  entropy
end

# How much a list of numbers vary from the mean.
def variance(list)
  mean = list.mean
  mean_diff = list.inject(0) {|sum,element| sum += ( (element - mean) ** 2 ) }
  mean_diff / list.length
end

def dot_product(vector)
end

def gaussian(dist,sigma=10.0)
end

# TODO: this would be nicer as Pr(A) = 1.25, Pr(A|B)
def conditional_probability
end
