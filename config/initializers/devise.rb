# frozen_string_literal: true

Devise.setup do |config|
  # config.cas_base_url = ENV["CAS_BASE_URL"]

  # you can override these if you need to, but cas_base_url is usually enough
  # config.cas_login_url = "#{ENV["CAS_BASE_URL"]}/login"
  # config.cas_logout_url = "https://cas.myorganization.com/logout"
  # config.cas_validate_url = "https://cas.myorganization.com/serviceValidate"

  # The CAS specification allows for the passing of a follow URL to be displayed when
  # a user logs out on the CAS server. RubyCAS-Server also supports redirecting to a
  # URL via the destination param. Set either of these urls and specify either nil,
  # 'destination' or 'follow' as the logout_url_param. If the urls are blank but
  # logout_url_param is set, a default will be detected for the service.
  # config.cas_destination_url = 'https://cas.myorganization.com'
  # config.cas_follow_url = 'https://cas.myorganization.com'
  # config.cas_logout_url_param = nil

  # You can specify the name of the destination argument with the following option.
  # e.g. the following option will change it from 'destination' to 'url'
  # config.cas_destination_logout_param_name = 'url'

  # By default, devise_cas_authenticatable will create users.  If you would rather
  # require user records to already exist locally before they can authenticate via
  # CAS, uncomment the following line.
  # config.cas_create_user = false

  # You can enable Single Sign Out, which by default is disabled.
  # config.cas_enable_single_sign_out = true

  # If you don't want to use the username returned from your CAS server as the unique
  # identifier, but some other field passed in cas_extra_attributes, you can specify
  # the field name here.
  # config.cas_user_identifier = nil

  # If you want to use the Devise Timeoutable module with single sign out,
  # uncommenting this will redirect timeouts to the logout url, so that the CAS can
  # take care of signing out the other serviced applocations. Note that each
  # application manages timeouts independently, so one application timing out will
  # kill the session on all applications serviced by the CAS.
  # config.warden do |manager|
  #   manager.failure_app = DeviseCasAuthenticatable::SingleSignOut::WardenFailureApp
  # end

  # You can also set another single sign out strategy so that you won't be attached to rails_cache.
  # Be aware that to do so you also need to set the session_store.
  # Example for setting redis_cache.
  # There are some gems the help with it. One of them is called redis-rails and it can easily be set like this:
  # Rails.application.config.session_store :redis_store, servers: ["redis://localhost:6379/0/session"]
  # This is specially useful when you need to share session id accross apps (i.e. in a distributed environment)
  # config.cas_single_sign_out_mapping_strategy = :redis_cache

  # If you need to specify some extra configs for rubycas-client, you can do this via:
  # config.cas_client_config_options = {
  #     logger: Rails.logger
  # }

  # ==> Configuration for :saml_authenticatable

  # Create user if the user does not exist. (Default is false)
  # Can also accept a proc, for ex:
  # Devise.saml_create_user = Proc.new do |model_class, saml_response, auth_value|
  #  model_class == Admin
  # end
  config.saml_create_user = true

  # Update the attributes of the user after a successful login. (Default is false)
  # Can also accept a proc, for ex:
  # Devise.saml_update_user = Proc.new do |model_class, saml_response, auth_value|
  #  model_class == Admin
  # end
  config.saml_update_user = true

  # Lambda that is called if Devise.saml_update_user and/or Devise.saml_create_user are true.
  # Receives the model object, saml_response and auth_value, and defines how the object's values are
  # updated with regards to the SAML response.
  # config.saml_update_resource_hook = -> (user, saml_response, auth_value) {
  #   saml_response.attributes.resource_keys.each do |key|
  #     user.send "#{key}=", saml_response.attribute_value_by_resource_key(key)
  #   end
  #
  #   if (Devise.saml_use_subject)
  #     user.send "#{Devise.saml_default_user_key}=", auth_value
  #   end
  #
  #   user.save!
  # }

  # Lambda that is called to resolve the saml_response and auth_value into the correct user object.
  # Receives a copy of the ActiveRecord::Model, saml_response and auth_value. Is expected to return
  # one instance of the provided model that is the matched account, or nil if none exists.
  # config.saml_resource_locator = -> (model, saml_response, auth_value) {
  #   model.where(Devise.saml_default_user_key => auth_value).first
  # }
  config.saml_attribute_map_resolver = "UserAttributeMapResolver"

  # Set the default user key. The user will be looked up by this key. Make
  # sure that the Authentication Response includes the attribute.
  config.saml_default_user_key = :email

  # Optional. This stores the session index defined by the IDP during login.  If provided it will be used as a salt
  # for the user's session to facilitate an IDP initiated logout request.
  config.saml_session_index_key = :session_index

  # You can set this value to use Subject or SAML assertion as info to which email will be compared.
  # If you don't set it then email will be extracted from SAML assertion attributes.
  config.saml_use_subject = true

  # You can implement IdP settings with the options to support multiple IdPs and use the request object by setting this value to the name of a class that implements a ::settings method
  # which takes an IdP entity id and a request object as arguments and returns a hash of idp settings for the corresponding IdP.
  # config.idp_settings_adapter = "MyIdPSettingsAdapter"

  # You provide you own method to find the idp_entity_id in a SAML message in the case of multiple IdPs
  # by setting this to the name of a custom reader class, or use the default.
  # config.idp_entity_id_reader = "DeviseSamlAuthenticatable::DefaultIdpEntityIdReader"

  # You can set the name of a class that takes the response for a failed SAML request and the strategy,
  # and implements a #handle method. This method can then redirect the user, return error messages, etc.
  # config.saml_failed_callback = "MySamlFailedCallbacksHandler"

  # You can customize the named routes generated in case of named route collisions with
  # other Devise modules or libraries. Set the saml_route_helper_prefix to a string that will
  # be appended to the named route.
  # If saml_route_helper_prefix = 'saml' then the new_user_session route becomes new_saml_user_session
  config.saml_route_helper_prefix = "saml"

  # You can add allowance for clock drift between the sp and idp.
  # This is a time in seconds.
  # config.allowed_clock_drift_in_seconds = 0

  # In SAML responses, validate that the identity provider has included an InResponseTo
  # header that matches the ID of the SAML request. (Default is false)
  # config.saml_validate_in_response_to = false

  # Configure with your SAML settings (see ruby-saml's README for more information: https://github.com/onelogin/ruby-saml).
  config.saml_configure do |settings|
    settings.assertion_consumer_service_url = "http://localhost:3000/users/saml/auth"
    settings.assertion_consumer_service_binding = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
    settings.name_identifier_format = "urn:oasis:names:tc:SAML:2.0:nameid-format:transient"
    settings.issuer = Rails.application.secrets.clave[:nif_dir]
    settings.authn_context = ""
    settings.idp_slo_service_url = "http://localhost:3000/simplesaml/www/saml2/idp/SingleLogoutService.php"
    settings.idp_sso_service_url = "https://se-pasarela.clave.gob.es/Proxy2/ServiceProvider"
    settings.idp_cert = Rails.application.secrets.clave[:cert]
  end
end
