class Movie < ActiveRecord::Base
    def self.same_director id
        @movie_same_director = Movie.where(id: id).all[0]
        if !@movie_same_director.director.nil? and !@movie_same_director.director.empty?
            return Movie.where(director: @movie_same_director.director).where.not(id: @movie_same_director.id).all
        else
            return nil
        end
    end
end
