require 'rails_helper'

RSpec.describe User, type: :model do

  let!(:user) {
    FactoryBot.build(:user)
  }

  let!(:post_attributes) {
    FactoryBot.attributes_for(:post)
  }

  let!(:comment_attributes) {
    FactoryBot.attributes_for(:comment)
  }

  it "is valid with name, email and age" do
    expect(user).to be_valid
  end

  it "name is blank" do
    user.name = ''
    expect(user).to be_invalid
  end

  it "email is blank" do
    user.email = ''
    expect(user).to be_invalid
  end

  it "email should be uniqueness" do
    duplicate_user = user.dup
    user.save!
    expect(duplicate_user).to be_invalid
  end

  it "intro is blank" do
    user.intro = ''
    expect(user).to be_invalid
  end

  it "password is blank" do
    user.password = user.password_confirmation = ''
    expect(user).to be_invalid
  end

  it "the first letter of password is downcase" do
    user.password = 'baseball713'
    expect(user).to be_invalid
  end

  it "the length of password is less than eight character" do
    user.password = 'Basebal'
    expect(user).to be_invalid
  end

  it "can save" do
    expect(user).to be_truthy
  end

  it "is deleted related post when user is deleted" do
    user.save
    user.posts.create(post_attributes)
    expect{ user.destroy }.to change{ Post.count }.by(-1)
  end

  it "is deleted related comment when user is deleted" do
    @admin_user = FactoryBot.create(:admin_user)
    @post = @admin_user.posts.create(post_attributes)
    @comment = user.comments.build(comment_attributes)
    @comment.post = @post
    @comment.save
    expect{ user.destroy }.to change{ Comment.count}.by(-1)
  end
end
