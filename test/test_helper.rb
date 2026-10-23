# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require "lesli_testing"

LesliTesting.engine("LesliView", {
    coverage_min_coverage: 10,
    fixtures: false,
    migrations: false
})

# Loading dummy app
require_relative "../test/dummy/config/environment"
require "rails/test_help"
