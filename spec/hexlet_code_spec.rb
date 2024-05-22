# frozen_string_literal: true

require "hexlet_code/tag"

RSpec.describe HexletCode do
  it "has a version number" do
    expect(HexletCode::VERSION).not_to be nil
  end
end

RSpec.describe HexletCode do
  User = Struct.new(:name, :job, keyword_init: true)

  describe ".form_for" do
    let(:user) { User.new name: "rob" }

    context "when no url is provided" do
      it "returns a form with action='#' and method='post'" do
        expect(described_class.form_for(user)).to eq("<form action=\"#\" method=\"post\"></form>")
      end
    end

    context "when url is provided" do
      it "returns a form with the provided url as action and method='post'" do
        expect(described_class.form_for(user, url: "/users")).to eq("<form action=\"/users\" method=\"post\"></form>")
      end
    end
  end
end

RSpec.describe HexletCode::Tag do
  describe ".build" do
    context "when no attributes or block given" do
      it "returns a self-closing tag for void elements" do
        expect(described_class.build("br")).to eq("<br>")
      end

      it "returns an open and close tag for non-void elements" do
        expect(described_class.build("div")).to eq("<div></div>")
      end
    end

    context "when attributes given" do
      it "includes the attributes in the tag" do
        expect(described_class.build("img", src: "path/to/image")).to eq('<img src="path/to/image">')
        expect(described_class.build("input", type: "submit", value: "Save"))
          .to eq('<input type="submit" value="Save">')
        expect(described_class.build("label", for: "email")).to eq('<label for="email"></label>')
      end
    end

    context "when block given" do
      it "includes the block content in the tag" do
        expect(described_class.build("label") { "Email" }).to eq("<label>Email</label>")
        expect(described_class.build("label", for: "email") { "Email" }).to eq('<label for="email">Email</label>')
      end
    end
  end
end
