# frozen_string_literal: true

Decidim::User.class_eval do
  devise :saml_authenticatable, :trackable
end
