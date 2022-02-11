# frozen_string_literal: true

require './lib/scripts/simple_translation'
ActiveRecord::Base.extend(SimpleTranslation)
