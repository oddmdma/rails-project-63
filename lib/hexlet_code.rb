# frozen_string_literal: true

require_relative "hexlet_code/version"

# The HexletCode module is a library for building HTML tags.
# It provides a Tag class that can be used to build HTML tags with attributes and content.
module HexletCode
  autoload :Tag, "hexlet_code/tag"
  autoload :VERSION, "hexlet_code/version"

  class Error < StandardError; end

  # Your code goes here...
  def self.form_for(_object, options = {})
    action_url = options[:url] || "#"
    Tag.build("form", action: action_url, method: "post")
  end
end
