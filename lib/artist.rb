class Artist
    extend Concerns::Findable
    
    attr_accessor :name, :songs
   
  @@all = [ ]

  def initialize(name)
      @name = name
      @songs = [ ]
  end
  
  
  def save
      @@all << self
  end
  
  def self.all
      @@all
  end
  
  def self.destroy_all
      @@all.clear
  end
  
  def self.create(name)
      song = self.new(name)
      song.save
      song
  end
  
  def songs
      @songs
  end
  
  def add_song(song)
    song.artist = self unless song.artist
    songs.push(song) unless songs.include?(song)
  end
  
  def genres 
      songs.collect {|a| a.genre}.uniq
  end
  
  
end