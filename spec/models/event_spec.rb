require "rails_helper"

RSpec.describe Event, type: :model do

  it do
    is_expected.
      to respond_to :starts_at, :location, :title, :author, :body, :state
  end

  describe "attribute validations" do
    it { is_expected.to validate_presence_of :starts_at }
    it { is_expected.to validate_presence_of :location  }
    it { is_expected.to validate_presence_of :title     }
    it { is_expected.to validate_presence_of :author    }
    it { is_expected.to validate_presence_of :state     }

    it { is_expected.to validate_inclusion_of(:state).in_array Event::STATES }
  end

  context "when an event is authored" do
    it "knows about its author" do
      author = create(:user)
      event = create(:event, author: author)
      expect(event.author).to eq author
    end

    it "does not validate when 'body' is blank" do
      event = Event.new(title: nil)
      expect(event).to be_invalid
      expect(event.errors.messages.keys).to include :body
    end
  end
end
