class Create<%= table_name.camelize %>Tables < ActiveRecord::Migration
  def self.up
    create_table(:<%= table_name %>) do |t|
      # t.references :user
      t.references :agent
      # t.boolean :primary
      t.string :family_name
      t.string :given_name
      t.string :additional_name
      t.string :honorific_prefix, :limit => 10
      t.string :honorific_suffix, :limit => 10
      t.string :nickname
      t.text :photo
      t.date :bday
      t.string :tz
      t.float :latitude
      t.float :longitude
      t.string :title
      t.string :role
      t.text :logo
      t.string :org
      t.text :note
      t.string :url
      t.string :klass

      t.timestamps
    end
    add_index :<%= table_name %>, :agent_id
    add_index :<%= table_name %>, :klass
    # add_index :<%= table_name %>, :user_id
    # add_index :<%= table_name %>, :primary

    create_table(:vcard_adrs) do |t|
      t.references :<%= table_name.singularize %>
      t.integer :types_mask
      t.string :post_office_box
      t.string :extended_address
      t.string :street_address
      t.string :locality
      t.string :region
      t.string :postal_code
      t.string :country_name
    end
    add_index :vcard_adrs, :<%= table_name.singularize %>_id

    create_table(:vcard_tels) do |t|
      t.references :<%= table_name.singularize %>
      t.integer :types_mask
      t.string :value
    end
    add_index :vcard_tels, :<%= table_name.singularize %>_id

    create_table(:vcard_emails) do |t|
      t.references :<%= table_name.singularize %>
      t.integer :types_mask
      t.string :value
    end
    add_index :vcard_emails, :<%= table_name.singularize %>_id

    create_table(:vcard_dictionaries) do |t|
      t.string :klass
      t.string :name
      t.string :description
    end
    add_index :vcard_dictionaries, [:klass, :name], :unique => true

    create_table(:vcard_categorizations) do |t|
      t.references :<%= table_name.singularize %>
      t.references :vcard_dictionary
    end
    add_index :vcard_categorizations, [:<%= table_name.singularize %>_id, :vcard_dictionary_id], :unique => true

    create_table(:vcard_extentions) do |t|
      t.references :<%= table_name.singularize %>
      t.references :vcard_dictionary
      t.integer :types_mask
      t.string :value
    end
    add_index :vcard_extentions, :<%= table_name.singularize %>_id
    add_index :vcard_extentions, :vcard_dictionary_id
  end

  def self.down
    drop_table :<%= table_name %>
    drop_table :vcard_adrs
    drop_table :vcard_tels
    drop_table :vcard_emails
    drop_table :vcard_dictionaries
    drop_table :vcard_categorizations
    drop_table :vcard_extentions
  end
end
