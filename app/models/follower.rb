class Follower < ActiveRecord::Base
   validates_uniqueness_of :email
   validates_presence_of :name,:email
end
