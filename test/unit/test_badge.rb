require "badge"
require "test/unit"

class TestBadge < Test::Unit::TestCase
  def test_new
    badge = Badge.new
    assert_equal Badge, badge.class
  end

  def test_name
    badge = Badge.new

    # test name
    badge.name = "test name"
    assert_equal badge.name, "test name"
  end

  def test_description
    badge = Badge.new
    
    badge.description = "test description"
    assert_equal badge.description, "test description"

    long_description = (1..181).map { "a" }.join
    assert_raise( BadgeError ){ badge.description = long_description } 
  end

  def test_shortname
    badge = Badge.new

    badge.shortname = "shortname"
    assert_equal badge.shortname, "shortname"
  end

  def test_add_user
    badge = Badge.new
    user = User.new

    badge.shortname = "cheddar"
    user.shortname = "cheese"
    user.fullname = "Cheesey Fries"

    assert_equal badge.users.include?( user ), false
    assert_equal user.badges.include?( badge ), false

    badge.add_user! user
    
    assert_equal badge.users.include?( user ), true
    assert_equal user.badges.include?( badge ), true

    assert_equal badge.users[0].shortname, "cheese"
    assert_equal user.badges[0].shortname, "cheddar"

    badge2 = Badge.new
    badge2.shortname = "yellar"

    user.add_badge! badge2
    assert_equal badge2.users.include?( user ), true
    assert_equal user.badges.include?( badge ), true
    assert_equal user.badges.include?( badge2 ), true

    badge3 = Badge.new
    assert_equal user.badges.include?( badge3 ), false
  end
end

class TestUser < Test::Unit::TestCase
  def test_new
    user = User.new

    assert_equal user.class, User
  end

  def test_shortname
    user = User.new

    user.shortname = "shortname"
    assert_equal user.shortname, "shortname"
  end

  def test_fullname
    user = User.new

    user.fullname = "Full Name"
    assert_equal user.fullname, "Full Name"
  end
end

