json.array!(@followers) do |follower|
  json.extract! follower, :id, :name, :email
  json.url follower_url(follower, format: :json)
end
