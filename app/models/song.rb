class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def artist_name=(name)
    new_artist = Artist.find_or_create_by(name: name)
    self.artist = new_artist
  end

  def genre_id
    self.genre ? self.genre.id : nil
  end

  def genre_id=(id)
    new_genre = Genre.find_or_create_by(id: id)
    self.genre = new_genre
  end

  def note_contents
    self.notes.collect {|note| note.content}
  end

  def note_contents=(notes)
    notes.each do |note| 
      if !note.empty?
        self.notes << Note.create(content: note)
      end
    end
  end
end
