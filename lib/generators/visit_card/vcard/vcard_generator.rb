require 'rails/generators/migration'

module VisitCard
  module Generators
    class VcardGenerator < Rails::Generators::NamedBase
      include Rails::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)
      namespace "visit_card"

      desc "Generates a model with the given NAME (if one does not exist) with vcard " <<
           "configuration plus a migration file and vcard routes." # TODO routes??

      def self.orm_has_migration?
        Rails::Generators.options[:rails][:orm] == :active_record
      end

      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end

      class_option :orm
      class_option :migration, :type => :boolean, :default => orm_has_migration?

      def invoke_orm_model
        return unless behavior == :invoke

        if model_exists?
          say "* Model already exists. Adding Vcard behavior."
        elsif options[:orm].present?
          invoke "model", [name], :migration => false, :orm => options[:orm]

          unless model_exists?
            abort "Tried to invoke the model generator for '#{options[:orm]}' but could not find it.\n" <<
              "Please create your model by hand before calling `rails g vcard #{name}`."
          end
        else
          abort "Cannot create a vcard model because config.generators.orm is blank.\n" <<
            "Please create your model by hand or configure your generators orm before calling `rails g vcard #{name}`."
        end
      end

      def inject_vcard_config_into_model
        vcard_class_setup = <<-CONTENT

  include VisitCard::Models::Vcard

CONTENT

        case options[:orm].to_s
        when "mongoid"
          inject_into_file model_path, vcard_class_setup, :after => "include Mongoid::Document\n"
        when "data_mapper"
          inject_into_file model_path, vcard_class_setup, :after => "include DataMapper::Resource\n"
        when "active_record"
          inject_into_class model_path, class_name, vcard_class_setup + <<-CONTENT
  # Setup accessible (or protected) attributes for your model TODO
  # attr_accessible :given_name, :last_name, :additional_name
CONTENT
        end
      end

      def copy_migration_template
        return unless options.migration?
        migration_template "migration.rb", "db/migrate/create_#{table_name}_tables"
      end

      def add_vcard_routes
        # route "vcard_for :#{table_name}"
      end

    protected

      def model_exists?
        File.exists?(File.join(destination_root, model_path))
      end

      def model_path
        @model_path ||= File.join("app", "models", "#{file_path}.rb")
      end
    end
  end
end
