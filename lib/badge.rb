class Badge
  attr_accessor :shortname, :name, :description
  attr_reader :users

  def initialize()
    super()

    @users = []
  end

  def description=( v )
    if v.size > 180
     raise BadgeError, "Description must be less than 180 characters"
    end

    @description = v
  end

  # updates the user by default
  # note that when we call add_badge, we tell user not to update badge
  def add_user!( user, update_user = true )
    puts "add_user"
    unless @users.include?( user )
      @users << user
      user.add_badge!( self, false ) if update_user
    end
    return @users
  end
end

class User 
  attr_accessor :shortname, :fullname
  attr_reader :badges

  def initialize()
    super()

    @badges = []
  end

  # updates the badge by default
  # note that when we call add_user, we tell badge not to update user 
  def add_badge!( badge, update_badge = true )
    unless @badges.include?( badge )
      @badges << badge
      badge.add_user!( self, false) if update_badge
    end
    return @badges
  end
end

class BadgeError < StandardError
end
