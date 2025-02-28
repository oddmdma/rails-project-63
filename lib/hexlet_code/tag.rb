# frozen_string_literal: true

# The HexletCode module is a library for building HTML tags.
# It provides a Tag class that can be used to build HTML tags with attributes and content.
module HexletCode
  # The Tag class provides a method to build HTML tags with attributes and content.
  class Tag
    VOID_ELEMENTS = %w[area base br col command embed hr img input keygen link meta param source track wbr].freeze

    class << self
      # Builds an HTML tag with the given name, attributes, and content.
      # @param name [String] The name of the tag.
      # @param attributes [Hash] The attributes for the tag.
      # @yield The content of the tag.
      # @return [String] The HTML tag.
      def build(name, attributes = {})
        attr_string = build_attributes_string(attributes)
        content = block_given? ? yield : ''
        build_tag(name, attr_string, content)
      end

      private

      # Builds a string of HTML attributes from a hash.
      # @param attributes [Hash] The attributes for the tag.
      # @return [String] The attributes string.
      def build_attributes_string(attributes)
        return '' if attributes.empty?

        attrs = attributes.map { |key, value| "#{key}=\"#{value}\"" }.join(' ')
        " #{attrs}"
      end

      # Builds an HTML tag with the given name, attributes string, and content.
      # @param name [String] The name of the tag.
      # @param attr_string [String] The attributes string.
      # @param content [String] The content of the tag.
      # @return [String] The HTML tag.
      def build_tag(name, attr_string, content)
        tag_end = void_element?(name) ? '' : "</#{name}>"
        "<#{name}#{attr_string}>#{content}#{tag_end}"
      end

      # Checks if the given tag name is a void element.
      # @param name [String] The name of the tag.
      # @return [Boolean] Whether the tag is a void element.
      def void_element?(name)
        VOID_ELEMENTS.include?(name)
      end
    end
  end
end
