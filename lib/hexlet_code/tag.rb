# frozen_string_literal: true

# The HexletCode module is a library for building HTML tags.
# It provides a Tag class that can be used to build HTML tags with attributes and content.
module HexletCode
  # The Tag class provides a method to build HTML tags with attributes and content.
  class Tag
    VOID_ELEMENTS = %w[area base br col command embed hr img input keygen link meta param source track wbr].freeze

    def self.build(name, attributes = {})
      attr_string = attributes.map { |key, value| "#{key}=\"#{value}\"" }.join(" ")
      attr_string = " #{attr_string}" unless attr_string.empty?
      content = block_given? ? yield : ''
      tag_end = VOID_ELEMENTS.include?(name) ? '' : "</#{name}>"
      "<#{name}#{attr_string}>#{content}#{tag_end}"
    end
  end
end
