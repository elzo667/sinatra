require 'pry'
require 'csv'
class Gossip
  attr_reader :content, :author
  def initialize(author, content)
    @author = author
    @content = content
  end
    #Ici on sauvegarde les gossips dans un tableau avec 2 colonnes author et content en CSV
  def save
    CSV.open("/home/maddev/THP/W5/D1/Franck-Sinatra/db/gossip.csv", "a") do |csv|
      csv << [@author, @content]
      csv.close
    end
  end
  def self.all
    all_gossips = []
    CSV.foreach("/home/maddev/THP/W5/D1/Franck-Sinatra/db/gossip.csv", "r") do |csv_line|
        all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end


  def self.find(id)
    all_gossips = self.all
      return all_gossips[id-1]
    return Gossip.all[id.to_i - 1]
  end


  def self.update(id, author, content)
    all_gossips = Gossip.all
    all_gossips[id.to_i - 1] = Gossip.new(author, content)
    CSV.open("/home/maddev/THP/W5/D1/Franck-Sinatra/db/gossip.csv", "w") do |csv|
      all_gossips.each do |gossip|
        csv << [gossip.author, gossip.content]
      end
    end
  end 


end

  binding.pry 
  