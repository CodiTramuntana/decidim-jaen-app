if Rails.application.secrets.dig(:omniauth, :saml).present?
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider(
      :saml,
      setup: lambda { |env|
              request = Rack::Request.new(env)
              organization = Decidim::Organization.find_by(host: request.host)
              provider_config = organization.enabled_omniauth_providers[:saml]
              env["omniauth.strategy"].options[:sp_entity_id] = provider_config[:client_id] || Rails.application.secrets.omniauth.dig(:saml, :sp_entity_id)
              env["omniauth.strategy"].options[:idp_sso_service_url] = provider_config[:site_url] || Rails.application.secrets.omniauth.dig(:saml, :idp_sso_service_url)
              env["omniauth.strategy"].options[:idp_cert_fingerprint] = provider_config[:idp_cert_fingerprint] || Rails.application.secrets.omniauth.dig(:saml, :idp_cert_fingerprint)
              env["omniauth.strategy"].options[:certificate] = ENV["CLAVE_SP_CERTIFICATE"]
              env["omniauth.strategy"].options[:private_key] = ENV["CLAVE_SP_PRIVATE_KEY"]
              # env["omniauth.strategy"].options[:security]= {metadata_signed: true} # Enable signature on Metadata
              env["omniauth.strategy"].options[:security]= {
                authn_requests_signed: true, # Enable signature on Metadata
                signature_method: XMLSecurity::Document::RSA_SHA512,
              }
            },
      scope: :autenticacio_usuari
    )
  end
end