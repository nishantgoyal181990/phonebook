require 'spec_helper'

describe Account do
  before do  
  	@account = Account.new(name: "Example User", email: "user@example.com", password: "nishant", password_confirmation: "nishant") 
  end

  subject { @account }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  	describe "when name is not present" do
  		before { @account.name = " " }
  		it { should_not be_valid }
  	end

	describe "remember token" do
    	before { @account.save }
    	its(:remember_token) { should_not be_blank }
  	end
	describe "when email is not present" do
    	before { @account.email = " " }
    	it { should_not be_valid }
  	end

  	describe "when name is too long" do
    	before { @account.name = "a" * 51 }
    	it { should_not be_valid }
  	end
	describe "when email format is invalid" do
    	it "should be invalid" do
      		addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      		addresses.each do |invalid_address|
        	@account.email = invalid_address
        	@account.should_not be_valid
      		end      
    	end
  	end

  	describe "when email format is valid" do
    	it "should be valid" do
      		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      		addresses.each do |valid_address|
        	@account.email = valid_address
        	@account.should be_valid
      		end      
    	end
  	end
	
	describe "when email address is already taken" do
    	before do
      		user_with_same_email = @account.dup
      		user_with_same_email.email = @account.email.upcase
      		user_with_same_email.save
    	end

    	it { should_not be_valid }
  	end
	
	describe "when password is not present" do
  		before { @account.password = @account.password_confirmation = " " }
  		it { should_not be_valid }
	end

	describe "when password is present" do
  		before { @account.password = @account.password_confirmation = "foobar" }
  		it { should be_valid }
	end

	describe "when passwords doesn't match" do
  		before { @account.password ="nishant" 
  			@account.password_confirmation = "foobar" }
  		it { should_not be_valid }
	end

	describe "when password field is nil" do
  		before { @account.password ="" 
  			@account.password_confirmation = "foobar" }
  		it { should_not be_valid }
	
	end

	describe "with a password that's too short" do
  		before { @account.password = @account.password_confirmation = "a" * 5 }
  		it { should be_invalid }
	end

	describe "return value of authenticate method" do
  		before { @account.save }
  		let(:found_user) { Account.find_by_email(@account.email) }

  		describe "with valid password" do
    		it { should == found_user.authenticate(@account.password) }
  		end

  		describe "with invalid password" do
    		let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    		it { should_not == user_for_invalid_password }
    		specify { user_for_invalid_password.should be_false }
  		end
	end
end