# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = { git: "https://github.com/CodiTramuntana/decidim.git", branch: "release/0.25-stable" }.freeze
gem "decidim-conferences", DECIDIM_VERSION
gem "decidim-term_customizer", git: "https://github.com/mainio/decidim-module-term_customizer.git", branch: "release/0.25-stable"
gem "decidim-verifications-members_picker", git: "https://github.com/gencat/decidim-verifications-members_picker.git", tag: "0.0.2"

gem "daemons"
gem "delayed_job_active_record"
gem "puma"
gem "uglifier", ">= 1.3.0"
gem "whenever"

gem "figaro", ">= 1.1.1"
gem "openssl"
gem "webpacker"

gem "decidim", DECIDIM_VERSION

group :development, :test do
  gem "better_errors"
  gem "binding_of_caller"
  gem "byebug", platform: :mri
  gem "decidim-dev", DECIDIM_VERSION
  gem "faker"
end

group :development do
  gem "letter_opener_web"
  gem "listen", "~> 3.1.0"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console"
end
