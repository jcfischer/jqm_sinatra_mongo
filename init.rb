require 'rubygems'
require 'sinatra/base'
require 'haml'

require 'mongo_mapper'
require './models/event'


class EventApp < Sinatra::Base

  set :views, File.join(File.dirname(__FILE__), 'views')
  set :public, File.join(File.dirname(__FILE__), 'public')

  configure do
    MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
    MongoMapper.database = 'jqm_events'
    Event.ensure_index :name
  end

  not_found { haml :'404' }


  # show list of all events
  # GET /events
  get '/events' do
    @events = Event.all
    haml :index
  end

  # show a single event
  # GET /events/123456
  get '/events/:id' do
    @event = Event.find_by_id(params[:id])
    if @event
      haml :show
    else
      raise Sinatra::NotFound
    end
  end

  # create a new event
  # POST /events
  post '/events' do
    puts "Creating Event with #{params.inspect}"
    name = params[:event][:name]
    location = params[:event][:location]
    url = params[:event][:url]
    event = Event.where(:name => name).first
    if event
      [400, 'Event already registerd']
    else
      event = Event.create(:name => name, :location => location, :url => url)
      [201, 'Created']
    end
  end

end


# now run the Sinatra server
EventApp.run!