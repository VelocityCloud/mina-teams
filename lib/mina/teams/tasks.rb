require 'json'
require 'net/http'
require 'mina'

namespace :teams do
  set :teams_url,       -> { ENV['TEAMS_URL'] }
  set :author,          -> { ENV['GIT_AUTHOR_NAME'] || `git config user.name`.chomp }
  set :commit, -> { ENV['GIT_COMMIT'] || `git rev-parse #{fetch(:branch)} | cut -c 1-7`.strip }
  set :environment, -> { ENV['to'] }

  task :starting do
    notification = "#{fetch(:author).call} is deploying branch #{branch_name} to #{fetch(:environment).call}"
    post_teams_channel(notification)
    set(:start_time, Time.now)
  end

  task :finished do
    end_time = Time.now
    start_time = fetch(:start_time)
    elapsed = end_time.to_i - start_time.to_i

    notification = "#{fetch(:author).call} successfully deployed branch #{branch_name} in #{elapsed} seconds."
    post_teams_channel(notification)
  end

  task :starting_restart do
    notification = "#{fetch(:author).call} is restarting #{fetch(:environment).call} servers"
    post_teams_channel(notification)
    set(:start_time, Time.now)
  end

  task :finished_restart do
    end_time = Time.now
    start_time = fetch(:start_time)
    elapsed = end_time.to_i - start_time.to_i

    notification = "#{fetch(:author).call} successfully restarted #{fetch(:environment).call} servers in #{elapsed} seconds."
    post_teams_channel(notification)
  end

  def branch_name
    "#{fetch(:branch)} (#{fetch(:commit).call})"
  end

  def post_teams_channel(message)
    uri = URI.parse(fetch(:teams_url))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    payload = {
      text: message
    }
    headers = {'Content-Type': 'application/json'}

    request = Net::HTTP::Post.new(uri.request_uri, headers)
    request.body = payload.to_json

    # Call Teams webhook
    http.request(request)
  rescue => e
    puts "Failed to notify Teams. Error #{e.inspect}"
  end
end
