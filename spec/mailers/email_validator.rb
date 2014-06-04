require 'spec_helper'

# shared_examples "a well tested mailer" do
#   let(:greeting) { "Darren" }
#   let(:full_subject) { "#{asserted_subject}:You got mail!" }
#   let(:mail) { mailer_class.email(greeting) }
#
#   it "renders the headers" do
#     mail.content_type.should start_with('multipart/alternative') #html / text support
#   end
#
#   it "sets the correct subject" do
#     mail.subject.should eq(full_subject)
#   end
#
#   it "includes asserted_body in the body of the email" do
#     asserted_body.each do |content|
#       mail.body.encoded.should match(content)
#     end
#   end
#
#   it "should be from 'from@example.com'" do
#     mail.from.should include('from@example.com')
#   end
# end

describe "EmailValidator" do
  registrant = Fabricate(:registrant)
  mail = EmailValidator.complete_registration(registrant)

  puts mail.from

  it "should be from 'rastaman@example.com'" do
    expect(true).to eq('rastaman@example.com')
  end
end