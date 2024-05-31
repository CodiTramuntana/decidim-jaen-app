# frozen_string_literal: true

Rails.application.config.after_initialize do
  workflow= Decidim::Verifications.find_workflow_manifest("file_authorization_handler")
  workflow.action_authorizer = "Decidim::AgeAndDistrictActionAuthorization::Authorizer"
  workflow.options do |options|
    options.attribute :min_age, type: :string, required: false
    options.attribute :max_age, type: :string, required: false
    options.attribute :allowed_districts, type: :string, required: false
  end
end
