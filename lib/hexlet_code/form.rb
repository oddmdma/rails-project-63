# frozen_string_literal: true

module HexletCode
  # The Form class provides methods to build form inputs based on an object's attributes.
  class Form
    attr_reader :object, :inputs

    # Initializes a new Form instance.
    # @param object [Object] The object to build the form for.
    def initialize(object)
      @object = object
      @inputs = []
    end

    # Adds an input field to the form.
    # @param name [Symbol] The name of the field.
    # @param options [Hash] The options for the field.
    # @option options [Symbol] :as The type of input field.
    # @return [void]
    def input(name, options = {})
      validate_attribute(name)
      value = @object.public_send(name)
      add_label(name)
      generate_input(name, value, options)
    end

    # Adds a submit button to the form.
    # @param value [String] The value of the submit button.
    # @return [void]
    def submit(value = 'Save')
      @inputs << Tag.build('input', type: 'submit', value: value)
    end

    private

    # Validates that the object has the given attribute.
    # @param name [Symbol] The name of the attribute.
    # @raise [NoMethodError] If the object doesn't have the attribute.
    # @return [void]
    def validate_attribute(name)
      return if @object.respond_to?(name)

      raise NoMethodError, "undefined method `#{name}' for #{@object.inspect}"
    end

    # Adds a label for the given field.
    # @param name [Symbol] The name of the field.
    # @return [void]
    def add_label(name)
      label_text = name.to_s.capitalize
      @inputs << Tag.build('label', for: name.to_s) { label_text }
    end

    # Generates an input field based on the given type.
    # @param name [Symbol] The name of the field.
    # @param value [Object] The value of the field.
    # @param options [Hash] The options for the field.
    # @return [void]
    def generate_input(name, value, options)
      input_type = options.delete(:as) || :input
      input_builder = input_builder_for(input_type)
      send(input_builder, name, value, options)
    end

    # Returns the method name for the given input type.
    # @param input_type [Symbol] The type of input field.
    # @return [Symbol] The method name.
    def input_builder_for(input_type)
      case input_type
      when :input then :generate_text_input
      when :text, :textarea then :generate_textarea
      else
        raise ArgumentError, "Unknown input type: #{input_type}"
      end
    end

    # Generates a text input field.
    # @param name [Symbol] The name of the field.
    # @param value [Object] The value of the field.
    # @param options [Hash] The options for the field.
    # @return [void]
    def generate_text_input(name, value, options)
      attributes = { name: name.to_s, type: 'text', value: value }.merge(options)
      @inputs << Tag.build('input', attributes)
    end

    # Generates a textarea field.
    # @param name [Symbol] The name of the field.
    # @param value [Object] The value of the field.
    # @param options [Hash] The options for the field.
    # @return [void]
    def generate_textarea(name, value, options)
      default_attrs = { name: name.to_s, cols: 20, rows: 40 }
      attributes = default_attrs.merge(options)
      @inputs << Tag.build('textarea', attributes) { value.to_s }
    end
  end
end
