require 'spec_helper'

describe Registrant do
  # let!(:email) { Faker::Internet.email }
  # let!(:subject_with_known_email) { Fabricate(:registrant, email: email) }

  context "with a valid email address" do
    subject { Fabricate(:registrant) }

    it "is valid" do
      expect(subject.valid?).to be_true
    end

    it "has a signup code" do
      expect(subject.sign_up_code).not_to be_blank
    end

    it "has a sign up expiration date and time" do
      expect(subject.sign_up_expires_at).not_to be_blank
    end

    it "expiration date and time is in the future" do
      expect(subject.sign_up_expires_at).to be > Time.now
    end
  end

  context "with a blank email address" do
    subject { Fabricate.build(:registrant_with_blank_email) }
    
    it "email address is not valid" do
      expect(subject.valid?).to be_false
    end

    it "does not have a signup code" do
      expect(subject.sign_up_code).to be_blank
    end

    it "does not have a sign up expiration date and time" do
      expect(subject.sign_up_expires_at).to be_blank
    end

  end

  context "with a badly formed email address" do  
    subject { Fabricate.build(:registrant_with_bad_email) }

    it "email address is not valid" do
      expect(subject.valid?).to be_false
    end

    it "does not have a signup code" do
      expect(subject.sign_up_code).to be_blank
    end

    it "does not have a sign up expiration date and time" do
      expect(subject.sign_up_expires_at).to be_blank
    end

  end

  # context "with a duplicate email address" do 
  #   it "does not create a new registrant id" do
  #     # puts "TODO"
  #   end
  # end

end