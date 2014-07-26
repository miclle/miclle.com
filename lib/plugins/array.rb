# encoding: utf-8
class Array

  # [1,2,3].belong? [1,2,3,4] => true
  # [1,2,3,5].belong? [1,2,3,4] => false
  def belong?(array)
    array - (array - self) == self
  end

  def sample_group(count_rand = [2,3,4,5])
    # group = []
    # self.chunk {|n| n % (rand(self.size) + 1) == 0 }.each {|_, ary| group << ary}
    # group

    _self, group = self.dup, []
    group << self.slice!(0, count_rand.blank? ? (rand(self.size) + 1) : count_rand.sample) while self.size > 0
    self.replace _self
    group
  end

  def sample_group!(count_rand = nil)
    group = []
    group << self.slice!(0, count_rand.blank? ? (rand(self.size) + 1) : count_rand.sample) while self.size > 0
    self.replace group
  end

end