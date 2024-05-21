# frozen_string_literal: true

require_relative "hexlet_code/version"

# The HexletCode module is a library for building HTML tags.
# It provides a Tag class that can be used to build HTML tags with attributes and content.
module HexletCode
  autoload :Tag, "hexlet_code/tag"
  autoload :VERSION, "hexlet_code/version"

  class Error < StandardError; end

  # Your code goes here...
end
