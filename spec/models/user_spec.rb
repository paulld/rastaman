require 'spec_helper'

describe User do
  let!(:email) { Faker::Internet.email }
  let!(:subject_with_known_email) { Fabricate(:user, email: email) }

  context "with a valid email address and password" do
    subject { Fabricate(:user) }

    it "is valid" do
      expect(subject.valid?).to be_true
      expect(subject.salt).not_to be_blank
      expect(subject.fish).not_to be_blank
    end
  end

  context "with a blank email address" do
    subject { Fabricate.build(:user_with_blank_email) }

    it "is not valid" do
      expect(subject.valid?).to be_false
    end
  end

  context "with a badly formed email address" do
    subject { Fabricate.build(:user_with_bad_email) }

    it "is not valid" do
      expect(subject.valid?).to be_false
    end
  end

end