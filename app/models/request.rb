class Request < ApplicationRecord
  include Olivander::Resources::AutoFormAttributes

  auto_resource_fields #columns: 4

  belongs_to :policy

  attribute :request_type # loan_request | loan_repaymenet_request

  attribute :data

  has_attached_file :document
  validates_attachment_content_type :document, content_type: Mime[:pdf].to_s

end
