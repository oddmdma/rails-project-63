# frozen_string_literal: true

require_relative "hexlet_code/version"

# The HexletCode module is a library for building HTML tags.
# It provides a Tag class that can be used to build HTML tags with attributes and content.
module HexletCode
  autoload :Tag, "hexlet_code/tag"
  autoload :Form, "hexlet_code/form"
  autoload :VERSION, "hexlet_code/version"

  class Error < StandardError; end

  # Builds an HTML form for the given object with the specified options.
  # @param object [Object] The object to build the form for.
  # @param options [Hash] The options for the form.
  # @option options [String] :url The URL for the form action.
  # @yield [form] The form builder.
  # @yieldparam form [Form] The form builder.
  # @return [String] The HTML form.
  def self.form_for(object, options = {})
    action_url = options[:url] || "#"
    form_attributes = { action: action_url, method: "post" }

    # Create a new form builder
    form = Form.new(object)

    # Yield the form builder to the block if a block is given
    yield(form) if block_given?

    # Build the form tag with the inputs
    Tag.build("form", form_attributes) do
      form.inputs.join
    end
  end
end
