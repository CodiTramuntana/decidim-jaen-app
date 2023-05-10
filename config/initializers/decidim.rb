# frozen_string_literal: true

Decidim.configure do |config|
  config.application_name = Rails.application.secrets.decidim[:application_name]

  # The email that will be used as sender in all emails from Decidim
  config.mailer_sender = Rails.application.secrets.decidim[:mailer_sender]

  # Change these lines to set your preferred locales
  config.default_locale = :es
  config.available_locales = %w(en es)

  # Sets the default locale for new organizations. When creating a new
  # organization from the System area, system admins will be able to overwrite
  # this value for that specific organization.
  config.default_locale = Rails.application.secrets.decidim[:default_locale].presence || :en

  # Custom HTML Header snippets
  #
  # The most common use is to integrate third-party services that require some
  # extra JavaScript or CSS. Also, you can use it to add extra meta tags to the
  # HTML. Note that this will only be rendered in public pages, not in the admin
  # section.
  #
  # Before enabling this you should ensure that any tracking that might be done
  # is in accordance with the rules and regulations that apply to your
  # environment and usage scenarios. This component also comes with the risk
  # that an organization's administrator injects malicious scripts to spy on or
  # take over user accounts.
  #
  config.enable_html_header_snippets = Rails.application.secrets.decidim[:enable_html_header_snippets].present?

  # Allow organizations admins to track newsletter links.
  config.track_newsletter_links = Rails.application.secrets.decidim[:track_newsletter_links].present? unless Rails.application.secrets.decidim[:track_newsletter_links] == "auto"

  # Map and Geocoder configuration
  config.maps = {
    provider: :here,
    api_key: Rails.application.secrets.maps[:here_api_key],
    static: { url: "https://image.maps.ls.hereapi.com/mia/1.6/mapview" }
  }

  # Workaround to enable SVG assets cors
  # config.cors_enabled = Rails.application.secrets.decidim[:cors_enabled].present?

  # Max requests in a time period to prevent DoS attacks. Only applied on production.
  config.throttling_max_requests = Rails.application.secrets.decidim[:throttling_max_requests].to_i

  # Time window in which the throttling is applied.
  config.throttling_period = Rails.application.secrets.decidim[:throttling_period].to_i.minutes

  config.follow_http_x_forwarded_host = Rails.application.secrets.decidim[:follow_http_x_forwarded_host].present?
end

# Inform Decidim about the assets folder
Decidim.register_assets_path File.expand_path("app/packs", Rails.application.root)

Rails.application.config.i18n.available_locales = Decidim.available_locales
Rails.application.config.i18n.default_locale = Decidim.default_locale

Rails.application.config.after_initialize do
  workflow= Decidim::Verifications.find_workflow_manifest("file_authorization_handler")
  workflow.action_authorizer = "Decidim::AgeAndDistrictActionAuthorization::Authorizer"
  workflow.options do |options|
    options.attribute :min_age, type: :string, required: false
    options.attribute :max_age, type: :string, required: false
    options.attribute :allowed_districts, type: :string, required: false
  end
end
# Inform Decidim about the assets folder
Decidim.register_assets_path File.expand_path("app/packs", Rails.application.root)
