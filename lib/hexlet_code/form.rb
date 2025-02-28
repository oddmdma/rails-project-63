# frozen_string_literal: true

module HexletCode
  # The Form class provides methods to build form inputs based on an object's attributes.
  class Form
    attr_reader :object, :inputs

    def initialize(object)
      @object = object
      @inputs = []
    end

    def input(name, options = {})
      # Check if the object has the attribute
      validate_attribute(name)

      # Get the value from the object
      value = @object.public_send(name)

      # Add label for the input
      add_label(name)

      # Generate input based on type
      generate_input(name, value, options)
    end

    def submit(value = "Save")
      attributes = { type: "submit", value: value }
      @inputs << Tag.build("input", attributes)
    end

    private

    def validate_attribute(name)
      return if @object.respond_to?(name)

      raise NoMethodError, "undefined method `#{name}' for #{@object.inspect}"
    end

    def add_label(name)
      label_text = name.to_s.capitalize
      @inputs << Tag.build("label", for: name.to_s) { label_text }
    end

    def generate_input(name, value, options)
      # Extract the input type from options
      input_type = options.delete(:as) || :input

      # Generate the appropriate input based on the type
      case input_type
      when :input
        generate_text_input(name, value, options)
      when :textarea
        generate_textarea(name, value, options)
      else
        raise ArgumentError, "Unknown input type: #{input_type}"
      end
    end

    def generate_text_input(name, value, options)
      attributes = { name: name.to_s, type: "text", value: value }.merge(options)
      @inputs << Tag.build("input", attributes)
    end

    def generate_textarea(name, value, options)
      # Default attributes for textarea
      attributes = { name: name.to_s, cols: 20, rows: 40 }.merge(options)
      @inputs << Tag.build("textarea", attributes) { value.to_s }
    end
  end
end
