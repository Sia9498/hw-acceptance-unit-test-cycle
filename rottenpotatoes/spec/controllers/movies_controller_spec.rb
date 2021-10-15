require 'rails_helper'
require 'simplecov'
require 'simplecov-rcov'

describe MoviesController do
    
    describe 'show' do
        let!(:movie1) { Movie.create!(title: 'The Notebook', director: 'Nick Cassavetes') }
        let!(:movie2) { Movie.create!(title: 'Alpha Dog', director: 'Nick Cassavetes') }
        
        it 'should display the show template' do
            get :show, id: movie1.id
            expect(response).to render_template('show')
        end
        it 'should populate The Notebook movie information' do
            get :show, id: movie1.id
            expect(assigns(:movie).title).to eql(movie1.title)
        end
        it 'should populate Alpha Dog movie information' do
            get :show, id: movie2.id
            expect(assigns(:movie).title).to eql(movie2.title)
        end
    end
    
    describe 'index' do
        let!(:movie1) { Movie.create!(title: 'The Notebook', director: 'Nick Cassavetes') }
        let!(:movie2) { Movie.create!(title: 'Alpha Dog', director: 'Nick Cassavetes') }

        it 'should display the index template' do
            get :index
            expect(response).to render_template('index')
        end
        it 'should display all movies' do
            get :index
            all_movies = []
            @controller.instance_variable_get(:@movies).each do |i|
                 all_movies.append(i.title)
            end
            expect(all_movies[0]).to eql(movie1.title)
            expect(all_movies[1]).to eql(movie2.title)
        
        end
    end
    
    describe 'create' do
        let!(:movie1) { Movie.create!(title: 'The Notebook', director: 'Nick Cassavetes') }
        
        it 'redirect to the index template page' do
            post :create, movie: movie1.attributes
            expect(response).to redirect_to(movies_path)
        end
        it 'creates a new movie' do
           expect {post :create, movie: movie1.attributes}.to change { Movie.count }.by(1)
        end
        
    end
    
        describe 'edit' do
        let!(:movie1) { Movie.create!(title: 'The Notebook', director: 'Nick Cassavetes') }
        
        it 'should display the edit template' do
            get :edit, id: movie1.id
            expect(response).to render_template('edit')
        end
        it 'should find the movie to be editted' do
            get :edit, id: movie1.id
            expect(assigns(:movie).title).to eql(movie1.title)
        end
        
    end
    
        describe 'update' do
        let!(:movie1) { Movie.create!(title: 'The Notebook', director: 'Nick Cassavetes') }
        
         it 'redirect to the index template page' do
            attrbs = movie1.attributes
            attrbs[:title] = 'Avengers'
            put :update, id: movie1.id, movie: attrbs
            expect(response).to redirect_to(movie_path(movie1))
        end
        it 'updates an existing movie information' do
            attrbs = movie1.attributes
            attrbs[:title] = 'Avengers'
            put :update, id: movie1.id, movie: attrbs
            movie1.reload
            expect(movie1.title).to eql('Avengers')
        end
    end
    
    
    describe 'destroy' do
       let!(:movie1) { Movie.create!(title: 'The Notebook', director: 'Nick Cassavetes') }
        
        it 'redirect to the index template page after deletion' do
            delete :destroy, id: movie1.id
            expect(response).to redirect_to(movies_path)
        end
        it 'deletes the movie from the database' do
            expect {delete :destroy, id: movie1.id}.to change { Movie.count }.by(-1)
        end
        
    end
       
    
    describe 'same_director' do
    let!(:movie1) { Movie.create!(title: 'The Notebook', director: 'Nick Cassavetes') }
    let!(:movie2) { Movie.create!(title: 'Alpha Dog', director: 'Nick Cassavetes') }
    let!(:movie3) { Movie.create!(title: 'The Arrival', director: 'Denis Villeneuve') }
    let!(:movie4) { Movie.create!(title: 'Predestination', director: 'Peter Spierig') }
    let!(:movie5) { Movie.create!(title: 'Alien') }
    let!(:movie6) { Movie.create!(title: 'Life', director: 'Nick Cassavetes') }
        
        it 'should display the same_director template' do
            get :same_director, id: movie1.id
            expect(response).to render_template('same_director')
        end
        it 'find movies with the same director Nick Cassavetes' do
            get :same_director, id: movie1.id
            similar_movies = []
            @controller.instance_variable_get(:@movies).each do |i|
                similar_movies.append(i.title)
            end
            expect(similar_movies).to eql(['Alpha Dog', 'Life'])
        end
        
        it 'redirect to the index template page if there is no director info' do
            get :same_director, id: movie5.id
            expect(response).to redirect_to(movies_path)
        end
    end
    
end