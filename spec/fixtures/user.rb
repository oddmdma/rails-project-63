# frozen_string_literal: true

# Определение структуры User для тестов
User = Struct.new(:name, :job, :gender, keyword_init: true)

# Модуль с фикстурами для тестов
module Fixtures
  # Создает пользователя с заданными параметрами
  # @param name [String] Имя пользователя
  # @param job [String] Работа пользователя
  # @param gender [String] Пол пользователя
  # @return [User] Объект пользователя
  def self.user(name: 'rob', job: 'hexlet', gender: 'm')
    User.new(name: name, job: job, gender: gender)
  end

  # Возвращает HTML для формы без полей
  # @param action [String] URL для действия формы
  # @return [String] HTML формы
  def self.empty_form(action: '#')
    %(<form action="#{action}" method="post"></form>)
  end

  # Возвращает HTML для формы с текстовым полем
  # @param name [String] Имя поля
  # @param value [String] Значение поля
  # @param action [String] URL для действия формы
  # @param attrs [Hash] Дополнительные атрибуты для поля
  # @return [String] HTML формы с текстовым полем
  def self.form_with_text_input(name:, value:, action: '#', attrs: {})
    attrs_str = attrs.empty? ? '' : " #{attrs.map { |k, v| "#{k}=\"#{v}\"" }.join(" ")}"
    %(<form action="#{action}" method="post"><label for="#{name}">#{name.capitalize}</label><input name="#{name}" type="text" value="#{value}"#{attrs_str}></form>)
  end

  # Возвращает HTML для формы с текстовой областью
  # @param name [String] Имя поля
  # @param value [String] Значение поля
  # @param action [String] URL для действия формы
  # @param cols [Integer] Количество колонок
  # @param rows [Integer] Количество строк
  # @return [String] HTML формы с текстовой областью
  def self.form_with_textarea(name:, value:, action: '#', cols: 20, rows: 40)
    %(<form action="#{action}" method="post"><label for="#{name}">#{name.capitalize}</label><textarea name="#{name}" cols="#{cols}" rows="#{rows}">#{value}</textarea></form>)
  end

  # Возвращает HTML для формы с кнопкой отправки
  # @param button_value [String] Текст кнопки
  # @param action [String] URL для действия формы
  # @return [String] HTML формы с кнопкой отправки
  def self.form_with_submit(button_value: 'Save', action: '#')
    %(<form action="#{action}" method="post"><input type="submit" value="#{button_value}"></form>)
  end
end
