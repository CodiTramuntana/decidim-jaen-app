# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = { git: "https://github.com/CodiTramuntana/decidim.git", branch: "release/0.27-stable" }.freeze

gem "decidim", "0.27.5", DECIDIM_VERSION
gem "decidim-age_and_district_action_authorization", git: "https://github.com/CodiTramuntana/decidim-module-age_and_district_action_authorization"
gem "decidim-conferences", DECIDIM_VERSION
gem "decidim-consultations", DECIDIM_VERSION
gem "decidim-file_authorization_handler", git: "https://github.com/CodiTramuntana/decidim-file_authorization_handler.git", tag: "v0.27.1.1"
gem "decidim-term_customizer", git: "https://github.com/mainio/decidim-module-term_customizer.git", branch: "release/0.27-stable"
gem "decidim-verifications-members_picker", git: "https://github.com/gencat/decidim-verifications-members_picker.git", tag: "0.0.2"

gem "decidim-clave", git: "https://github.com/CodiTramuntana/decidim-module-clave.git"

gem "decidim-cdtb", git: "https://github.com/CodiTramuntana/decidim-module-cdtb.git", branch: "main"

# temporal solution while gems embrace new psych 4 (the default in Ruby 3.1) behavior.
gem "psych", "< 4"

# required by puma
gem "matrix"
gem "puma"
gem "uglifier", ">= 1.3.0"
gem "webpacker"

gem "figaro", ">= 1.1.1"
gem "openssl"

gem "omniauth-rails_csrf_protection", "~> 1.0"
gem "omniauth-saml", "~> 2.1.0"
# if deploying to a dedicated server
gem "daemons"
gem "delayed_job_active_record"
gem "whenever"
# elsif deploying to a PaaS like Heroku
# gem "redis"
# gem "sidekiq"
# group :production do
#   gem "aws-sdk-s3", require: false
#   gem "fog-aws"
#   gem "rack-ssl-enforcer"
#   gem "rails_12factor"
# end

group :development, :test do
  gem "better_errors"
  gem "binding_of_caller"
  gem "byebug", platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
  gem "faker"
end

group :development do
  gem "letter_opener_web"
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console"
end
