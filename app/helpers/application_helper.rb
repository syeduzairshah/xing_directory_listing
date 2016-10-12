module ApplicationHelper

  #it will be used to translate string to its selected locale(by default it will pick from en.yml)
  # input text need to be translated
  # output translated text (by default it will pick from en.yml)

  def translate(text)
    I18n.t(text)
  end
end
