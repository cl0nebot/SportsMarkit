class Document < ActiveRecord::Base
  extend FriendlyId
  include Access

  mount_uploader :file, PdfUploader
  
  belongs_to :documentable, :polymorphic => true
  
  friendly_id :use_for_slug, use: [:slugged, :finders]
  
  before_update :update_slug
  validates :file, presence: true
  validates :description, presence: true
  validates :name, presence: true

  def use_for_slug
    existing_document = Document.where('name = ?', self.name)
    if existing_document.present?
      "#{name} #{existing_document.count}"
    else
      "#{name}"
    end
  end

  def update_slug
    if (name_changed?)
      existing_document = minus_self.where('name = ?', self.name)
      if existing_document.present?
        update_column(:slug, "#{ApplicationController.helpers.to_slug(name, (existing_document.count + 1))}")
      else
        update_column(:slug, "#{ApplicationController.helpers.to_slug(name)}")
      end
    end
  end

  def minus_self
    Document.where.not(id: id)
  end

  def index_position
    array = []
    documents = Document.all
    documents.each do |c|
      array << c.id
    end
    array.uniq.find_index(id) + 1
  end

end
