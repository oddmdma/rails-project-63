# frozen_string_literal: true

# Модуль с фикстурами для сложных форм
module ComplexForms
  # Возвращает HTML для формы с несколькими полями
  # @param name_value [String] Значение поля name
  # @param job_value [String] Значение поля job
  # @param action [String] URL для действия формы
  # @return [String] HTML формы с несколькими полями
  def self.form_with_multiple_fields(name_value:, job_value:, action: '#')
    %(<form action="#{action}" method="post"><label for="name">Name</label><input name="name" type="text" value="#{name_value}"><label for="job">Job</label><textarea name="job" cols="20" rows="40">#{job_value}</textarea></form>)
  end

  # Возвращает HTML для формы с полями и кнопкой отправки
  # @param name_value [String] Значение поля name
  # @param job_value [String] Значение поля job
  # @param button_value [String] Текст кнопки
  # @param action [String] URL для действия формы
  # @return [String] HTML формы с полями и кнопкой отправки
  def self.form_with_fields_and_submit(name_value:, job_value:, button_value: 'Save', action: '#')
    %(<form action="#{action}" method="post"><label for="name">Name</label><input name="name" type="text" value="#{name_value}"><label for="job">Job</label><input name="job" type="text" value="#{job_value}"><input type="submit" value="#{button_value}"></form>)
  end

  # Возвращает HTML для формы с пользовательскими атрибутами
  # @param name_value [String] Значение поля name
  # @param job_value [String] Значение поля job
  # @param name_class [String] Класс для поля name
  # @param action [String] URL для действия формы
  # @return [String] HTML формы с пользовательскими атрибутами
  def self.form_with_custom_attributes(name_value:, job_value:, name_class:, action: '#')
    %(<form action="#{action}" method="post"><label for="name">Name</label><input name="name" type="text" value="#{name_value}" class="#{name_class}"><label for="job">Job</label><input name="job" type="text" value="#{job_value}"></form>)
  end

  # Возвращает HTML для формы с текстовой областью с пользовательскими атрибутами
  # @param job_value [String] Значение поля job
  # @param cols [Integer] Количество колонок
  # @param rows [Integer] Количество строк
  # @param action [String] URL для действия формы
  # @return [String] HTML формы с текстовой областью с пользовательскими атрибутами
  def self.form_with_custom_textarea(job_value:, cols:, rows:, action: '#')
    %(<form action="#{action}" method="post"><label for="job">Job</label><textarea name="job" cols="#{cols}" rows="#{rows}">#{job_value}</textarea></form>)
  end
end
