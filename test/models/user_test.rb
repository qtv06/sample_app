require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Nguyen Van A", email: "anguyen@gmail.com",
      password: "abc11222", password_confirmation: "abc11222")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should bo too long" do
    @user.email = "a" * 246 + "@gmail.com"
    assert_not @user.valid?
  end

  test "email validation should be accept valid addresses" do
    email_addresses = %w(anv@gmailc.om A_N_V@gmail.com a.n.v@gmail.com)
    email_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w(f@gmailc,om __@gmailcom daa@gm++ail.com)
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be valid"
    end
  end

  test "email valid should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert @user.valid?
  end

  test "password should be long than 5" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
