# if using gem russian or something what replace original to_label_tag then you need re-replace this method back by yourself
module VisitCard
  module Helpers
    module VcardsHelper
      extend ActiveSupport::Concern

      included do
        ActionView::Helpers::FormBuilder.send :include, VcardsHelper::FormBuilder
        ActionView::Helpers::InstanceTag.send :include, VcardsHelper::InstanceTag
      end

      module FormBuilder
        def check_box_collection(method, collection, options = {})
          output = "<fieldset class='#{method.to_s.downcase}'><legend>#{method.to_s.humanize}</legend>"
          if collection.is_a? Array # array collection - hbtm through bit mask
            collection.each do |value|
              options.delete(:id)
              output << check_box_collection_check_box(method, value, options) << "\n"
              output << label(method, value.humanize, :value => value.downcase) << "\n"
            end
            output << check_box_collection_hidden_field(method)
          else # hash collection - hbtm through join table
            collection.each do |key, value|
              options[:id] = "#{object_name}_#{method}_#{value}"
              output << check_box_collection_check_box(method, key, options) << "\n"
              output << label(method, value.humanize, :value => value.downcase) << "\n"
            end
          end
          output << '</fieldset>'
          output.html_safe
        end

        def check_box_collection_check_box(method, value, options = {})
          if options[:id] # hbtm through join table
            name = "#{object_name}[#{method.to_s.singularize}_ids][]"
            checked = object.send(:"#{method.to_s.singularize}_ids").include?(value)
          else # hbtm through bit mask
            name = "#{object_name}[#{method}][]"
            checked = object.send(method.to_sym).include?(value)
          end
          ActionView::Helpers::InstanceTag.new(object_name, method, self, options.delete(:object)).
                                           to_check_box_collection_check_box_tag(name, value, checked, options)
        end

        def check_box_collection_hidden_field(method, options = {})
          options[:name] ||= "#{object_name}[#{method}][]"
          ActionView::Helpers::InstanceTag.new(object_name, method, self, options.delete(:object)).to_input_field_tag("hidden", options)
        end
      end

      module InstanceTag
        def to_check_box_collection_check_box_tag(name, value, checked, options)
          options[:id] ||= name.dup << value.to_s
          options[:id] = sanitize_to_id(options[:id])
          check_box_tag name, value, checked, options
        end
      end

      module InstanceMethods
      end

      module ClassMethods
      end
    end
  end
end
