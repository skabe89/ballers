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

  def self.list_players
    @@all.each.with_index(1) do |player, index|
      puts "#{index}. #{player.last_name}, #{player.first_name}"
      puts "    Position: #{player.position}"
      puts "----------"
    end
  end

  def self.find_player_by_name(name)
    # place = []
    # @@all.each.with_index {|player| player.full_name.upcase == name.upcase ? place << player : nil}
    #   if place != nil
    #     place[0]
    #   else
    #     puts "Could not find the player you're looking for"
    #   end
    place = nil
    @@all.find{|player| player.full_name.upcase == name.upcase ? place = player : nil}
    if place != nil
      place
    else
      nil
    end 
  end


  def self.player(baller)
    place = nil
    @@all.find{|player| player == baller ? place = player : nil}
  end

  def self.all
    @@all
  end

end

