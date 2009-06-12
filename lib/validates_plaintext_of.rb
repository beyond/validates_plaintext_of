# ValidatesPlaintextOf

module ValidatesPlaintextOf
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    # add validation error when text field have any html tags.
    require 'action_controller/vendor/html-scanner'

    def validates_plaintext_of( *attr_names )
      configuration = { :on => :save }
      configuration.update(attr_names.extract_options!)

      validates_each(attr_names, configuration) do |record, attr_name, value|
        sanitized_value = HTML::FullSanitizer.new.sanitize( value )
        if value.blank? || value != sanitized_value
          record.errors.add(attr_name, :invalid, :default => configuration[:message], :value => value)
        end
      end
    end
  end

  module InstanceMethods
  end
end

ActiveRecord::Base.send :include, ValidatesPlaintextOf
