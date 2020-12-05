class Ballers

  attr_accessor :first_name, :last_name, :team, :position, :full_name
  @@all = []

  def initialize(data)
    self.first_name = data["first_name"]
    self.last_name = data["last_name"]
    self.team = data["team"]["full_name"]
    self.position = data["position"]
    self.full_name = "#{self.first_name} #{self.last_name}"
    @@all << self
  end

  def self.find_player_by_name(name)
    @@all.find{|player| player.full_name.upcase == name.upcase}
  end

  def self.player(baller)
    @@all.find{|player| player == baller}
  end

  def self.multi_players(name)
    place = []
    @@all.select{|player| player.last_name.upcase == name.upcase ? place << player : nil}
    place
  end

  def self.all
    @@all
  end

end
