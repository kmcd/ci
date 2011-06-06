class Array
  def to_hist
    inject(Hash.new(0)) {|hist,element| hist[element] += 1; hist }
  end
  
  def sum
    inject(0) {|sum, element| sum += element }
  end
  
  def mean
    sum.to_f / length.to_f
  end
end
