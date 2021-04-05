# Translation module
module SimpleTranslation
  def translate(attrs)
    class_eval do
      has_many :translations, as: :resource, dependent: :destroy, autosave: true
      after_save :save_translation

      default_scope { includes(:translations) }

      attrs.each do |attr|
        # Define Getter & Fallback
        define_method(attr) do |**_args|
          translation(attr) || read_attribute(attr)
        end

        # Define Setter
        define_method(:"#{attr}=") do |value|
          write_attribute(attr, value)
        end
      end

      def translation(attr, **args)
        options = { lang: I18n.locale, nil: true }.merge(args).with_indifferent_access
        content = translations.find { |t| t.column == attr&.to_s && t.lang == options[:lang]&.to_s }&.content
        content = '' if content.nil? && !options[:nil]

        content
      end
      alias_method :tr, :translation

      private

      def save_translation
        default_locale   = Rails.application.config.i18n.default_locale
        fallback_default = {}
        current_locale   = I18n.locale

        self.class::TRANSLATION_FIELDS.each do |attr|
          # next unless send("saved_change_to_#{attr}?")

          translation = translations.find_or_initialize_by(column: attr, lang: I18n.locale)
          translation.content = read_attribute(attr)
          translation.save

          # SET fallback attribute to default locale
          if current_locale != default_locale
            tran = translations.find_or_initialize_by(column: attr, lang: default_locale)
            fallback_default[attr] = tran.content || read_attribute(attr)
          end
        end

        return true if fallback_default.empty?

        # Update attribute to default locale content
        # update_columns fallback_default
      end
    end
  end
end
