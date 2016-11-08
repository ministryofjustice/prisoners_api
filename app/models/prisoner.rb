class Prisoner < ActiveRecord::Base
  include Swagger::Blocks

  # rubocop:disable Metrics/BlockLength
  swagger_schema :Prisoner do
    key :required, [:id, :noms_id, :given_name, :surname, :date_of_birth, :gender]
    property :id do
      key :type, :string
      key :format, :uuid
    end
    property :noms_id do
      key :type, :string
    end
    property :title do
      key :type, :string
    end
    property :given_name do
      key :type, :string
    end
    property :middle_names do
      key :type, :string
    end
    property :surname do
      key :type, :string
    end
    property :suffix do
      key :type, :string
    end
    property :date_of_birth do
      key :type, :string
      key :format, :date
    end
    property :gender do
      key :type, :string
    end
    property :nationality_code do
      key :type, :string
    end
    property :pnc_number do
      key :type, :string
    end
    property :cro_number do
      key :type, :string
    end
    property :establishment_code do
      key :type, :string
    end
  end

  swagger_schema :PrisonerInput do
    allOf do
      schema do
        key :'$ref', :Prisoner
      end
      schema do
        key :required, [:noms_id, :given_name, :surname, :date_of_birth, :gender]
        property :id do
          key :type, :string
          key :format, :uuid
        end
      end
    end
  end

  has_paper_trail

  has_many :aliases, dependent: :destroy

  validates :noms_id, presence: true, uniqueness: { scope: :date_of_birth }
  validates :given_name, presence: true
  validates :surname, presence: true
  validates :date_of_birth, presence: true
  validates :gender, presence: true

  scope :updated_after, -> (time) { where('updated_at > ?', time) }

  def self.search(params)
    options = params.dup
    results = distinct
    if options[:given_name] || options[:middle_names] || options[:surname]
      results = results.joins('LEFT JOIN aliases ON prisoners.id = aliases.prisoner_id')
      %i(given_name middle_names surname).each do |field|
        next unless options[field]
        term = options.delete(field)
        results =
          results.where("prisoners.#{field} ILIKE :term OR aliases.#{field} ILIKE :term", term: "%#{term}%")
      end
    end
    results.where(options).order(:surname, :given_name, :middle_names)
  end

  def update_aliases(aliases_params)
    return unless aliases_params
    transaction do
      aliases.delete_all
      aliases.create(aliases_params)
    end
  end
end
