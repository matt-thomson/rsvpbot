require 'csv'
require 'gmail'

Gmail.connect(:xoauth2, ENV["GMAIL_USERNAME"], ENV["GMAIL_ACCESS_TOKEN"]) do |gmail|
  CSV.foreach(ARGV[0], headers: true) do |row|
    gmail.deliver do
      to row["email"]
      from "Hayley and Matt <#{ENV["GMAIL_USERNAME"]}>"
      subject "Wedding RSVP"
      text_part do
        body <<~MESSAGE
          Hi #{row["name"]},

          We haven't heard from you yet about our wedding, and were wondering if you can make it? Please could you let us know by replying to this email, including any dietary requirements you may have.

          Hope you are well!

          Thanks,
          Hayley and Matt
        MESSAGE
      end
    end
  end
end
