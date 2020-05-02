class Song
    attr_accessor :name, :artist, :genre
   
    @@all = [ ]

    def initialize(name,artist = nil, genre = nil)       
        @name = name
        self.artist = artist unless artist.nil?
        self.genre = genre unless genre.nil?
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

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def self.create(name)
       song = self.new(name)
       song.save
       song
    end

    def genre=(genre)
        @genre = genre
        self.genre
        genre.songs << self unless genre.songs.include?(self)
    end
    
    def self.find_by_name(name)
        self.all.find do |song|
            song.name == name
        end
    
    end

    def self.find_or_create_by_name(name)
      self.find_by_name(name) || self.create(name)
    end

    def self.new_from_filename(filename)
        sections = filename.split(' - ')
        whatever_artist = sections[0]
        whatever_song = sections[1]
        whatever_genre = sections[2].gsub(".mp3","")
        artist = Artist.find_or_create_by_name(whatever_artist)
        genre = Genre.find_or_create_by_name(whatever_genre)
        new(whatever_song,artist,genre)
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).save
    end


    
    
end