require 'rails_helper'
require 'simplecov'
require 'simplecov-rcov'

describe Movie do
    describe 'Find_movies_with_same_director' do
        
    let!(:movie1) { Movie.create!(title: 'The Notebook', director: 'Nick Cassavetes') }
    let!(:movie2) { Movie.create!(title: 'Alpha Dog', director: 'Nick Cassavetes') }
    let!(:movie3) { Movie.create!(title: 'The Arrival', director: 'Denis Villeneuve') }
    let!(:movie4) { Movie.create!(title: 'Predestination', director: 'Peter Spierig') }
    let!(:movie5) { Movie.create!(title: 'Alien') }
    let!(:movie6) { Movie.create!(title: 'Life', director: 'Nick Cassavetes') }
        
        it 'find movies with same director' do
            similar_movies = []
            nick_cassavetes_movies = Movie.same_director(movie1.id)
         
            nick_cassavetes_movies.each do |i|
               similar_movies.append(i.title)
            end
            
            expect(similar_movies).to eql(['Alpha Dog', 'Life'])
        end
        
        it 'do not find movies with different director' do
            similar_movies = []
            nick_cassavetes_movies = Movie.same_director(movie1.id)
         
            nick_cassavetes_movies.each do |i|
               similar_movies.append(i.title)
            end
            
            expect(similar_movies).to_not include(['The Arrival', 'Predestination', 'Alien' ])
        end
        
    end
end