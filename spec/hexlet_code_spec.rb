# frozen_string_literal: true

require 'hexlet_code/tag'
require_relative 'fixtures/user'
require_relative 'fixtures/complex_forms'

RSpec.describe HexletCode do
  it 'has a version number' do
    expect(HexletCode::VERSION).not_to be nil
  end
end

RSpec.describe HexletCode do
  describe '.form_for' do
    let(:user) { Fixtures.user(name: 'rob') }

    context 'when no url is provided' do
      it "returns a form with action='#' and method='post'" do
        expect(described_class.form_for(user)).to eq(Fixtures.empty_form)
      end
    end

    context 'when url is provided' do
      it "returns a form with the provided url as action and method='post'" do
        expect(described_class.form_for(user, url: '/users')).to eq(Fixtures.empty_form(action: '/users'))
      end
    end
  end
end

# Тесты для генерации полей ввода
RSpec.describe HexletCode do
  describe '.form_for with text input fields' do
    let(:user) { Fixtures.user }

    it 'generates text input fields' do
      result = described_class.form_for user do |f|
        f.input :name
      end
      expect(result).to eq(Fixtures.form_with_text_input(name: 'name', value: 'rob'))
    end
  end
end

RSpec.describe HexletCode do
  describe '.form_for with textarea fields' do
    let(:user) { Fixtures.user }

    it 'generates textarea fields' do
      result = described_class.form_for user do |f|
        f.input :job, as: :textarea
      end
      expect(result).to eq(Fixtures.form_with_textarea(name: 'job', value: 'hexlet'))
    end
  end
end

# Тесты для генерации нескольких полей
RSpec.describe HexletCode do
  describe '.form_for with multiple fields' do
    let(:user) { Fixtures.user }

    it 'generates multiple fields' do
      result = described_class.form_for user do |f|
        f.input :name
        f.input :job, as: :textarea
      end
      expect(result).to eq(ComplexForms.form_with_multiple_fields(name_value: 'rob', job_value: 'hexlet'))
    end
  end
end

# Тесты для пользовательских атрибутов
RSpec.describe HexletCode do
  describe '.form_for with custom attributes for text fields' do
    let(:user) { Fixtures.user }

    it 'supports additional attributes for fields' do
      result = described_class.form_for user, url: '#' do |f|
        f.input :name, class: 'user-input'
        f.input :job
      end
      expect(result).to eq(ComplexForms.form_with_custom_attributes(
                             name_value: 'rob',
                             job_value: 'hexlet',
                             name_class: 'user-input'
                           ))
    end
  end
end

RSpec.describe HexletCode do
  describe '.form_for with custom attributes for textarea' do
    let(:user) { Fixtures.user }

    it 'allows overriding default attributes for textarea' do
      result = described_class.form_for user, url: '#' do |f|
        f.input :job, as: :textarea, rows: 50, cols: 50
      end
      expect(result).to eq(ComplexForms.form_with_custom_textarea(
                             job_value: 'hexlet',
                             cols: 50,
                             rows: 50
                           ))
    end
  end
end

# Тесты для кнопки отправки формы
RSpec.describe HexletCode do
  describe '.form_for with default submit button' do
    let(:user) { Fixtures.user }

    it 'generates a submit button with default value' do
      result = described_class.form_for user do |f|
        f.input :name
        f.input :job
        f.submit
      end
      expect(result).to eq(ComplexForms.form_with_fields_and_submit(
                             name_value: 'rob',
                             job_value: 'hexlet'
                           ))
    end
  end
end

RSpec.describe HexletCode do
  describe '.form_for with custom submit button' do
    let(:user) { Fixtures.user }

    it 'generates a submit button with custom value' do
      result = described_class.form_for user do |f|
        f.input :name
        f.input :job
        f.submit 'Wow'
      end
      expect(result).to eq(ComplexForms.form_with_fields_and_submit(
                             name_value: 'rob',
                             job_value: 'hexlet',
                             button_value: 'Wow'
                           ))
    end
  end
end

# Тесты для обработки ошибок
RSpec.describe HexletCode do
  describe '.form_for error handling' do
    let(:user) { Fixtures.user }

    it "raises an error when field doesn't exist" do
      expect do
        described_class.form_for user, url: '/users' do |f|
          f.input :name
          f.input :job, as: :textarea
          f.input :age
        end
      end.to raise_error(NoMethodError, /undefined method `age'/)
    end
  end
end

# Тесты для класса Tag
RSpec.describe HexletCode::Tag do
  describe '.build' do
    context 'when no attributes or block given' do
      it 'returns a self-closing tag for void elements' do
        expect(described_class.build('br')).to eq('<br>')
      end

      it 'returns an open and close tag for non-void elements' do
        expect(described_class.build('div')).to eq('<div></div>')
      end
    end

    context 'when attributes given' do
      it 'includes the attributes in the tag' do
        expect(described_class.build('img', src: 'path/to/image')).to eq('<img src="path/to/image">')
        expect(described_class.build('input', type: 'submit', value: 'Save'))
          .to eq('<input type="submit" value="Save">')
        expect(described_class.build('label', for: 'email')).to eq('<label for="email"></label>')
      end
    end

    context 'when block given' do
      it 'includes the block content in the tag' do
        expect(described_class.build('label') { 'Email' }).to eq('<label>Email</label>')
        expect(described_class.build('label', for: 'email') { 'Email' }).to eq('<label for="email">Email</label>')
      end
    end
  end
end
