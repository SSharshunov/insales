require 'i18n'

I18n.load_path = Dir[Hanami.root.join("config/locales/**/*.{yml,rb}")]
# I18n.config.enforce_available_locales = true
I18n.default_locale = 'ru'
I18n.backend.load_translations
