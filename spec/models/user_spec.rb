require 'rails_helper'

##edit these files before pushing

RSpec.describe User, type: :model do
  
  describe 'User Validations' do

    it 'password and password_confirmation fields should match' do
      @user = User.new(name: 'Casey', last_name: 'Bassaragh', email: 'Casey@gmail.com', password: 'AAABBBCCC', password_confirmation: 'AAABBBCCC' )

      expect(@user.password).to eq(@user.password_confirmation)
    end

    it "cannot register if email is already registered" do
      @user_1 = User.new(name: 'Casey', last_name: 'Bassaragh', email: 'Casey@gmail.com', password: 'AAABBBCCC', password_confirmation: 'AAABBBCCC' )
      @user_1.save
      
      @user_2 = User.new(name: 'Casey', last_name: 'Bassaragh', email: 'Casey@gmail.com', password: 'AAABBBCCC', password_confirmation: 'AAABBBCCC' )
      @user_2.save
      expect(User.where(email: 'Casey@gmail.com').count) == 1
    end
    
    it "cannot register if first name is blank" do
      @user = User.new(name: nil, last_name: 'Bassaragh', email: 'Casey@gmail.com', password: 'AAABBBCCC', password_confirmation: 'AAABBBCCC' )
      @user.save
      
      expect(User.where(email: 'Casey@gmail.com').count) == 0
    end
    
    it "cannot register if last name is blank" do
      @user = User.new(name: 'Casey', last_name: nil, email: 'Casey@gmail.com', password: 'AAABBBCCC', password_confirmation: 'AAABBBCCC' )
      @user.save
      
      expect(User.where(email: 'Casey@gmail.com').count) == 0
    end
    
    it "cannot register if email is blank" do
      @user = User.new(name: nil, last_name: 'Bassaragh', email: nil, password: 'AAABBBCCC', password_confirmation: nil )
      @user.save
      
      expect(User.where(email: 'Casey@gmail.com').count) == 0
    end

    it "cannot register if password is less than 7 characters" do
      @user = User.new(name: nil, last_name: 'Bassaragh', email: nil, password: '1234', password_confirmation: '1234' )
      @user.save
      
      expect(User.where(email: 'Casey@gmail.com').count) == 0
    end

    it "can register if password is 5 characters" do
      @user = User.new(name: nil, last_name: 'Bassaragh', email: nil, password: '12345', password_confirmation: '12345' )
      @user.save
      
      expect(User.where(email: 'Casey@gmail.com').count) == 1
    end


  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'should authenticate users if email and password match' do
      @user = User.new(name: 'Casey', last_name: 'Bassaragh', email: 'Casey@gmail.com', password: 'AAABBBCCC')
      @user.save

      expect(User.authenticate_with_credentials('Casey@gmail.com', 'AAABBBCCC')).to eq(@user)

      expect(User.authenticate_with_credentials('Casey@gmail.com', '123456')).to eq(nil)

      expect(User.authenticate_with_credentials('Casey@gmail.com', 'AAABBBCCC')).to eq(nil)
    end

    it 'should authenticate emails if extra spaces are added before or after' do
      @user = User.new(name: 'Casey', last_name: 'Bassaragh', email: 'Casey@gmail.com', password: 'AAABBBCCC')
      @user.save

      expect(User.authenticate_with_credentials(' Casey@gmail.com ', 'AAABBBCCC')).to eq(@user)
    end

    it 'should authenticate email if email is different case' do
      @user = User.new(name: 'Casey', last_name: 'Bassaragh', email: 'CASEY@gmail.com', password: 'AAABBBCCC')
      @user.save

      expect(User.authenticate_with_credentials(' CASEY@gmail.com ', 'AAABBBCCC')).to eq(@user)
    end

  end
  
end